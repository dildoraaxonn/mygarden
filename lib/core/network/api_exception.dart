import 'dart:io';

import 'package:dio/dio.dart';

/// Every network failure the app can show a message for.
sealed class ApiException implements Exception {
  const ApiException();

  /// Turns a dio error into one of the cases below.
  factory ApiException.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const ApiTimeoutException();
      case DioExceptionType.connectionError:
        return const NoConnectionException();
      case DioExceptionType.cancel:
        return const RequestCancelledException();
      case DioExceptionType.badCertificate:
        return const ServerException(statusCode: 0, code: 'bad_certificate');
      case DioExceptionType.badResponse:
        return _fromResponse(e.response);
      case DioExceptionType.unknown:
        if (e.error is SocketException || e.error is HttpException) {
          return const NoConnectionException();
        }
        return UnknownApiException(e.message ?? e.error?.toString());
    }
  }

  static ApiException _fromResponse(Response<dynamic>? response) {
    final status = response?.statusCode ?? 0;
    // Our backend answers errors as {"error": {"code": "...", "message": "..."}}.
    String? code;
    String? message;
    final body = response?.data;
    if (body is Map && body['error'] is Map) {
      final error = body['error'] as Map;
      code = error['code']?.toString();
      message = error['message']?.toString();
    }
    return switch (status) {
      401 || 403 => const UnauthorizedException(),
      429 => const RateLimitedException(),
      _ => ServerException(statusCode: status, code: code, message: message),
    };
  }
}

/// No internet, DNS failure, server unreachable.
final class NoConnectionException extends ApiException {
  const NoConnectionException();
}

final class ApiTimeoutException extends ApiException {
  const ApiTimeoutException();
}

/// Wrong or missing app token.
final class UnauthorizedException extends ApiException {
  const UnauthorizedException();
}

/// Daily or per-minute limit on the server reached.
final class RateLimitedException extends ApiException {
  const RateLimitedException();
}

final class RequestCancelledException extends ApiException {
  const RequestCancelledException();
}

/// The server answered with an error. [code] is our backend's error code,
/// e.g. `image_unclear`, when it sent one.
final class ServerException extends ApiException {
  const ServerException({required this.statusCode, this.code, this.message});

  final int statusCode;
  final String? code;
  final String? message;

  @override
  String toString() => 'ServerException($statusCode, $code, $message)';
}

/// The answer arrived but isn't in the expected shape.
final class InvalidResponseException extends ApiException {
  const InvalidResponseException([this.details]);

  final String? details;

  @override
  String toString() => 'InvalidResponseException($details)';
}

final class UnknownApiException extends ApiException {
  const UnknownApiException([this.details]);

  final String? details;

  @override
  String toString() => 'UnknownApiException($details)';
}
