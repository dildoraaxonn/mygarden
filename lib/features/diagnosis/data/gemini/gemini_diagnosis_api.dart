import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_config.dart';
import '../../../../core/network/api_exception.dart';
import '../diagnosis_api.dart';
import '../models/diagnosis.dart';
import '../models/diagnosis_request.dart';
import 'gemini_prompt.dart';

/// Gemini key and model, set at build time:
///
/// ```sh
/// flutter build apk --dart-define-from-file=dart_defines.local.json
/// ```
///
/// The key ends up inside the app. Fine for a family app on the free tier;
/// for anything wider, use our server instead (server/, docs/diagnosis_api.md).
class GeminiConfig {
  const GeminiConfig({
    required this.apiKey,
    required this.model,
    this.fallbackModel = '',
  });

  factory GeminiConfig.fromEnvironment() => const GeminiConfig(
    apiKey: String.fromEnvironment('GEMINI_API_KEY'),
    model: String.fromEnvironment(
      'GEMINI_MODEL',
      defaultValue: 'gemini-3.8-flash',
    ),
    fallbackModel: String.fromEnvironment(
      'GEMINI_FALLBACK_MODEL',
      defaultValue: 'gemini-3.6-flash',
    ),
  );

  final String apiKey;
  final String model;

  /// Tried when [model] stays overloaded (HTTP 503). Empty = no fallback.
  final String fallbackModel;

  bool get isConfigured => apiKey.isNotEmpty;

  static const baseUrl = 'https://generativelanguage.googleapis.com/v1beta';
}

/// Asks Google Gemini directly from the phone.
class GeminiDiagnosisApi implements DiagnosisApi {
  GeminiDiagnosisApi(
    this._config, {
    ApiClient? client,
    this.retryDelay = const Duration(seconds: 2),
  }) : _client =
           client ??
           ApiClient(
             const ApiConfig(baseUrl: GeminiConfig.baseUrl, appToken: ''),
           );

  final GeminiConfig _config;
  final ApiClient _client;

  /// Wait before retrying an overloaded model (grows with each attempt).
  final Duration retryDelay;

  @override
  bool get isDemo => false;

  @override
  Future<Diagnosis> diagnose(
    DiagnosisRequest request, {
    CancelToken? cancel,
  }) async {
    final bytes = await File(request.imagePath).readAsBytes();
    final body = {
      'systemInstruction': {
        'parts': [
          {'text': geminiSystemInstruction(request.language)},
        ],
      },
      'contents': [
        {
          'role': 'user',
          'parts': [
            {
              'inlineData': {
                'mimeType': _mimeType(request.imagePath),
                'data': base64Encode(bytes),
              },
            },
            {'text': geminiUserText(request)},
          ],
        },
      ],
      'generationConfig': {
        'responseMimeType': 'application/json',
        'responseJsonSchema': geminiResponseSchema,
      },
    };

    // Gemini is often briefly overloaded (503): retry, then try the
    // fallback model, before bothering the user.
    final fallback = _config.fallbackModel;
    final models = [
      _config.model,
      _config.model,
      if (fallback.isNotEmpty && fallback != _config.model) fallback,
    ];
    for (var attempt = 0; ; attempt++) {
      final model = models[attempt];
      final Map<String, dynamic> response;
      try {
        response = await _client.postJson(
          '/models/$model:generateContent',
          headers: {'x-goog-api-key': _config.apiKey},
          cancelToken: cancel,
          data: body,
        );
      } on ServerException catch (e) {
        final overloaded = e.statusCode == 503 || e.statusCode == 500;
        final canRetry =
            attempt < models.length - 1 && !(cancel?.isCancelled ?? false);
        if (overloaded && canRetry) {
          await Future<void>.delayed(retryDelay * (attempt + 1));
          continue;
        }
        throw _translate(e);
      }
      return _parse(response, model);
    }
  }

  /// Gemini's own errors → the cases the app already shows messages for.
  ApiException _translate(ServerException e) {
    final message = e.message ?? '';
    if (message.contains('API key') || message.contains('API_KEY')) {
      return const UnauthorizedException();
    }
    if (message.contains('location is not supported')) {
      return ServerException(
        statusCode: e.statusCode,
        code: 'location_not_supported',
      );
    }
    return ServerException(statusCode: e.statusCode, code: 'upstream_error');
  }

  Diagnosis _parse(Map<String, dynamic> response, String model) {
    final feedback = response['promptFeedback'];
    if (feedback is Map && feedback['blockReason'] != null) {
      throw const ServerException(statusCode: 200, code: 'blocked');
    }
    final candidates = response['candidates'];
    final first = candidates is List && candidates.isNotEmpty
        ? candidates.first
        : null;
    final content = first is Map ? first['content'] : null;
    final parts = content is Map ? content['parts'] : null;
    final text = parts is List
        ? parts.map((part) => (part as Map)['text'] ?? '').join().trim()
        : '';
    if (text.isEmpty) {
      throw const InvalidResponseException('empty Gemini answer');
    }

    final Map<String, dynamic> answer;
    try {
      answer = jsonDecode(text) as Map<String, dynamic>;
    } on Object {
      throw const InvalidResponseException('Gemini answer is not JSON');
    }
    if (answer['image_ok'] == false) {
      // Gemini's summary says how to retake the photo, in the user's language.
      throw ServerException(
        statusCode: 400,
        code: 'image_unclear',
        message: answer['summary'] as String?,
      );
    }
    // Drop malformed problems instead of failing the whole answer.
    final problems = answer['problems'];
    answer['problems'] = problems is List
        ? problems
              .whereType<Map<String, dynamic>>()
              .where(
                (p) => p['name'] is String && (p['name'] as String).isNotEmpty,
              )
              .take(3)
              .toList()
        : const [];
    answer['model'] = model;
    return Diagnosis.fromJson(answer);
  }

  static String _mimeType(String path) =>
      switch (p.extension(path).toLowerCase()) {
        '.png' => 'image/png',
        '.webp' => 'image/webp',
        '.heic' => 'image/heic',
        _ => 'image/jpeg',
      };
}
