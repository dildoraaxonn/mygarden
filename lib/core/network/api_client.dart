import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_config.dart';
import 'api_exception.dart';
import 'auth_interceptor.dart';

/// The one place that talks HTTP. Features call [postJson] and get either a
/// JSON map or an [ApiException] — never a raw dio error.
class ApiClient {
  ApiClient(
    this.config, {
    HttpClientAdapter? adapter,
    bool enableLogging = kDebugMode,
  }) : dio = Dio(
         BaseOptions(
           baseUrl: config.baseUrl,
           connectTimeout: const Duration(seconds: 15),
           // Photos upload slowly on village mobile internet.
           sendTimeout: const Duration(seconds: 60),
           // AI answers can take a while.
           receiveTimeout: const Duration(seconds: 90),
           responseType: ResponseType.json,
         ),
       ) {
    if (adapter != null) dio.httpClientAdapter = adapter;
    dio.interceptors.add(AuthInterceptor(config.appToken));
    if (enableLogging) {
      dio.interceptors.add(
        LogInterceptor(
          requestHeader: false, // would print the token
          requestBody: false, // would print the whole photo
          responseBody: true,
          logPrint: (line) => debugPrint('[api] $line'),
        ),
      );
    }
  }

  final ApiConfig config;
  final Dio dio;

  Future<Map<String, dynamic>> postJson(
    String path, {
    Object? data,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    return _json(
      () => dio.post<Object>(
        path,
        data: data,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Map<String, dynamic>> _json(
    Future<Response<Object>> Function() send,
  ) async {
    try {
      final response = await send();
      final body = response.data;
      if (body is Map<String, dynamic>) return body;
      if (body is String && body.isNotEmpty) {
        final decoded = jsonDecode(body);
        if (decoded is Map<String, dynamic>) return decoded;
      }
      throw const InvalidResponseException('expected a JSON object');
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    } on FormatException catch (e) {
      throw InvalidResponseException(e.message);
    }
  }
}
