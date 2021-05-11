import 'package:dio/dio.dart';

Future<Response> fetchAll(Dio dio, int pgOffset){
  return dio.get("/data/Test", queryParameters: {'pageSize' : 100, 'offset' : pgOffset});
}

Future<Response> getCount(Dio dio){
  return dio.get("/data/Test", queryParameters: {'property' : 'Count(nazwa)'});
}

Future<Response> fetch(Dio dio, String objectId){
  return dio.get("/data/Test/$objectId");
}

Future<Response> add(Dio dio, Map<String, dynamic> dane){
  return dio.post("/data/Test", data: dane);
}

Future<Response> delete(Dio dio, String objectId){
  return dio.delete("/data/Test/$objectId");
}

Future<Response> update(Dio dio, String objectId, Map<String, dynamic> dane){
  return dio.put("/data/Test/$objectId", data: dane);
}