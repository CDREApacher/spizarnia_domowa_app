import 'package:dio/dio.dart';

Future<Response> fetchAll(Dio dio){
  return dio.get("/data/Produkty");
}

Future<Response> fetch(Dio dio, String objectId){
  return dio.get("/data/Produkty/$objectId");
}

Future<Response> add(Dio dio, Map<String, dynamic> dane){
  return dio.post("/data/Produkty", data: dane);
}

Future<Response> delete(Dio dio, String objectId){
  return dio.delete("/data/Produkty/$objectId");
}

Future<Response> update(Dio dio, String objectId, Map<String, dynamic> dane){
  return dio.put("/data/Produkty/$objectId", data: dane);
}