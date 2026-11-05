import 'package:dio/dio.dart';

/// Adds the app token to every request to our backend.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._token);

  final String _token;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $_token';
    }
    handler.next(options);
  }
}
