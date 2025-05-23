import 'package:dio/dio.dart';

Dio createDio(List<Interceptor> interceptors) {
  final dio = Dio(
    BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.addAll(interceptors);

  return dio;
}
