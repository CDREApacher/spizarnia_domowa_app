import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:spizarnia_domowa_app/api/backendless_config.dart';

Logger logger = Logger();

Dio client (){
  Dio dio = new Dio();

  dio.options.baseUrl = "$queryUrl/$restAPIKey";
  dio.options.receiveTimeout = 10000;
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options) => requestInterceptors(options),
      onResponse: (Response response) => responseInterceptors(response),
      onError: (DioError err) => errorInterceptors(err)
    ), // InterceptorsWrapper
  ); // interceptors.add
  return dio;
} // Dio client

requestInterceptors(RequestOptions options){
  logger.d(options);
  return options;
}

responseInterceptors(Response response){
  logger.d(response.data);
  return response;
}

errorInterceptors(DioError err){
  logger.d(err.error);
  logger.d(err.message);
  return err;
}