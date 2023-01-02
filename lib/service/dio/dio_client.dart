import 'package:dio/dio.dart';
import 'package:morevie/service/Config.dart';
import 'package:morevie/service/dio/dio_interceptor.dart';

class DioClient {
  Dio dio = Dio(BaseOptions(
      baseUrl: Config.baseUrl,
      followRedirects: true,
      responseType: ResponseType.json))
    ..interceptors.add(DioInterceptor());

  Dio dioGenres = Dio(BaseOptions(
    baseUrl: Config.baseGenres,
    followRedirects: true,
    responseType: ResponseType.json
  ))..interceptors.add(DioInterceptor());
}
