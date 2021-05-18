import 'package:dio/dio.dart';

// Produkty

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

// Return all products from given category
/*
Future<Response> fetchProduktFromCategory(Dio dio, String kategoria){
  return dio.get("/data/Produkt", queryParameters: {
    "where" : 'kategorieProdukty$kategoria'
  });
}
*/

Future<Response> fetchProduktFromCategory(Dio dio, String kategoria){
  return dio.get("/data/Produkt?where=kategorieProdukty%3D'$kategoria'", queryParameters: {
    'pageSize' : 100
  });
}

// Kategorie

Future<Response> fetchKategorie(Dio dio){
  return dio.get("/data/Kategorie", queryParameters: {'pageSize' : 100});
}

Future<Response> fetchKategorieProdukty(Dio dio){
  return dio.get("/data/Kategorie", queryParameters: {'pageSize' : 100, 'lista' : 'produkty'});
}

Future<Response> fetchKategorieZakupy(Dio dio){
  return dio.get("/data/Kategorie", queryParameters: {'pageSize' : 100, 'lista' : 'zakupy'});
}

Future<Response> addKategorie(Dio dio, Map<String, dynamic> dane){
  return dio.post("/data/Kategorie", data: dane);
}

// Zakupy

Future<Response> fetchZakupy(Dio dio){
  return dio.get("/data/Lista_Zakupow", queryParameters: {'pageSize' : 100});
}

Future<Response> addZakup(Dio dio, Map<String, dynamic> dane){
  return dio.post("/data/Lista_Zakupow", data: dane);
}

Future<Response> updateZakup(Dio dio, String objectId, Map<String, dynamic> dane){
  return dio.put("/data/Lista_Zakupow/$objectId", data: dane);
}

// Atrybuty

Future<Response> fetchAtrybutyById(Dio dio, String objectId){
  return dio.get("/data/Atrybuty?where=objectIdProdukt%3D'$objectId'", queryParameters: {'pageSize' : 100});
}

Future<Response> addAtrybut(Dio dio, Map<String, dynamic> dane){
  return dio.post("/data/Atrybuty", data: dane);
}