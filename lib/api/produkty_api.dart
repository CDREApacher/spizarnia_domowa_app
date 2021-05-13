import 'package:dio/dio.dart';

Future<Response> fetchAll(Dio dio, int pgOffset){
  return dio.get("/data/Produkt", queryParameters: {'pageSize' : 100, 'offset' : pgOffset});
}
/*
Future<Response> fetchAll(Dio dio){
  return dio.get("/data/Produkt", queryParameters: {'pageSize' : 100});
}
*/
Future<Response> getCount(Dio dio){
  return dio.get("/data/Produkt", queryParameters: {'property' : 'Count(nazwaProduktu)'});
}

Future<Response> fetch(Dio dio, String objectId){
  return dio.get("/data/Produkt/$objectId");
}

Future<Response> add(Dio dio, Map<String, dynamic> dane){
  return dio.post("/data/Produkt", data: dane);
}

Future<Response> delete(Dio dio, String objectId){
  return dio.delete("/data/Produkt/$objectId");
}

Future<Response> update(Dio dio, String objectId, Map<String, dynamic> dane){
  return dio.put("/data/Produkt/$objectId", data: dane);
}