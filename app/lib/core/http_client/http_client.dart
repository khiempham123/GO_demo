import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'http_client_support.dart';

class HttpClient {
  late Dio dio;
  HttpClient({List<Interceptor>? interceptors}) {
    dio = createDio([
      if (interceptors != null) ...interceptors,
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: false,
      ),
    ]);
  }
}
