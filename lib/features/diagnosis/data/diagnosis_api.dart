import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import 'models/diagnosis.dart';
import 'models/diagnosis_request.dart';

/// Sends a photo for diagnosis. The app only knows this interface; which AI
/// actually answers is decided on the server.
abstract interface class DiagnosisApi {
  /// True when answers are samples, not real diagnoses.
  bool get isDemo;

  /// Throws [ApiException] on failure.
  Future<Diagnosis> diagnose(DiagnosisRequest request, {CancelToken? cancel});
}

/// Our backend: `POST /v1/diagnose` (see docs/diagnosis_api.md).
class RemoteDiagnosisApi implements DiagnosisApi {
  RemoteDiagnosisApi(this._client);

  final ApiClient _client;

  static const path = '/v1/diagnose';

  @override
  bool get isDemo => false;

  @override
  Future<Diagnosis> diagnose(
    DiagnosisRequest request, {
    CancelToken? cancel,
  }) async {
    final form = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        request.imagePath,
        filename: 'photo${p.extension(request.imagePath)}',
        contentType: _mediaType(request.imagePath),
      ),
      'context': jsonEncode(request.contextJson()),
    });
    final json = await _client.postJson(
      path,
      data: form,
      headers: {'Accept-Language': request.language},
      cancelToken: cancel,
    );
    return Diagnosis.fromJson(json);
  }

  static DioMediaType _mediaType(String path) =>
      switch (p.extension(path).toLowerCase()) {
        '.png' => DioMediaType('image', 'png'),
        '.webp' => DioMediaType('image', 'webp'),
        '.heic' => DioMediaType('image', 'heic'),
        _ => DioMediaType('image', 'jpeg'),
      };
}

/// Used until the server exists, so the whole flow can be tried. Answers
/// are clearly marked as demo in the UI.
class DemoDiagnosisApi implements DiagnosisApi {
  const DemoDiagnosisApi({this.delay = const Duration(seconds: 2)});

  final Duration delay;

  @override
  bool get isDemo => true;

  @override
  Future<Diagnosis> diagnose(
    DiagnosisRequest request, {
    CancelToken? cancel,
  }) async {
    await Future<void>.delayed(delay);
    if (cancel?.isCancelled ?? false) throw const RequestCancelledException();
    final ru = request.language == 'ru';
    final fruit = request.fruitLocal ?? request.fruit;
    return Diagnosis(
      healthy: false,
      model: Diagnosis.demoModel,
      urgency: Urgency.medium,
      summary: ru
          ? 'Пример ответа: у растения «$fruit» похоже на нехватку калия.'
          : 'Sample answer: the $fruit looks short of potassium.',
      problems: [
        DiagnosisProblem(
          name: ru ? 'Нехватка калия' : 'Potassium deficiency',
          confidence: 0.7,
          description: ru
              ? 'Края старых листьев желтеют и подсыхают.'
              : 'Edges of older leaves turn yellow and dry out.',
          actions: ru
              ? [
                  'Подкормите калийным удобрением.',
                  'Поливайте реже, но обильнее.',
                ]
              : [
                  'Feed with a potassium fertilizer.',
                  'Water less often, but deeper.',
                ],
        ),
        DiagnosisProblem(
          name: ru ? 'Холодовой стресс' : 'Cold stress',
          confidence: 0.3,
          actions: ru
              ? ['Ночью держите в теплице не ниже +12 °C.']
              : ['Keep the greenhouse above +12 °C at night.'],
        ),
      ],
      careTips: ru
          ? ['Это демо-режим: настоящий ИИ ещё не подключён.']
          : ['This is demo mode: the real AI is not connected yet.'],
    );
  }
}
