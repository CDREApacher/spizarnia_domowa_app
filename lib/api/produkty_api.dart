import 'package:dio/dio.dart';

// Produkty

Future<Response> fetchAll(Dio dio, String kod_grupy){
  return dio.get("/products/all?code=$kod_grupy");
}

Future<Response> fetch(Dio dio, String id_produktu){
  return dio.get("/products?id=$id_produktu");
}

Future<Response> add(Dio dio, Map<String, dynamic> dane){
  return dio.post("/products", data: dane);
}
/* BE
Future<Response> delete(Dio dio, String objectId){
  return dio.delete("/data/Produkt/$objectId");
}
*/
Future<Response> update(Dio dio, Map<String, dynamic> dane){
  return dio.put("/products/update", data: dane);
}

Future<Response> deleteProdukt(Dio dio, String objectId){
  return dio.delete("/products?id=$objectId");
}

// Kategorie

Future<Response> fetchKategorie(Dio dio){
  return dio.get("/data/Kategorie", queryParameters: {'pageSize' : 100});
}

Future<Response> fetchKategorieProdukty(Dio dio, String kod_grupy){
  return dio.get("/category-product/all?code=$kod_grupy");
}

Future<Response> fetchKategorieZakupy(Dio dio, String kod_grupy){
  return dio.get("/category-shopping/all?code=$kod_grupy");
}

Future<Response> addKategorieProdukty(Dio dio, Map<String, dynamic> dane){
  return dio.post("/category-product", data: dane);
}

Future<Response> addKategorieZakupy(Dio dio, Map<String, dynamic> dane){
  return dio.post("/category-shopping", data: dane);
}

Future<Response> deleteKategorieProdukty(Dio dio, String objectId){
  return dio.delete("/category-product?id=$objectId");
}

Future<Response> deleteKetegorieZakupy(Dio dio, String objectId){
  return dio.delete("/category-shopping?id=$objectId");
}

// Zakupy

Future<Response> fetchZakupy(Dio dio, String kod_grupy){
  return dio.get("/shopping-list/all?code=$kod_grupy");
}

Future<Response> addZakup(Dio dio, Map<String, dynamic> dane){
  return dio.post("/shopping-list", data: dane);
}

Future<Response> deleteZakupy(Dio dio, String objectId){
  return dio.delete("/shopping-list/$objectId");
}

Future<Response> buyProdukt(Dio dio, String produktId, int quantity) {
  return dio.post("/shopping-list/buy/$produktId?quantity=$quantity");
}

Future<Response> updateZakup(Dio dio, String objectId, int quantity){
  return dio.put("/shopping-list/quantity/$objectId?quantity=$quantity");
}

// Atrybuty

Future<Response> addAtrybut(Dio dio, String idProduktu, String nazwaAtrybutu){
  return dio.put("/products/attribute/$idProduktu?attributeName=$nazwaAtrybutu");
}

Future<Response> deleteAtrybuty(Dio dio, String produktId, String atrybutId){
  return dio.delete("/products/attribute/$produktId?attributeId=$atrybutId");
}

// Miary

Future<Response> fetchMiary(Dio dio, String kod_grupy){
  return dio.get("/measures/all?code=$kod_grupy");
}

Future<Response> addMiary(Dio dio, Map<String, dynamic> dane){
  return dio.post("/measures", data: dane);
}

Future<Response> deleteMiary(Dio dio, String objectId){
  return dio.delete("/measures?id=$objectId");
}

// Grupy
Future<Response> addGrupy(Dio dio, String nazwa){
  return dio.post("/groups?name=$nazwa");
}

Future<Response> joinGrupy(Dio dio, String kod_grupy){
  return dio.get("/groups?code=$kod_grupy");
}

// Barcody

Future<Response> addBarcodes(Dio dio, String barcode, String product_id, String name){
  return dio.put("/products/barcode/$product_id?barcode=$barcode&note=$name");
}

Future<Response> deleteBarcodes(Dio dio, String product_id, String barcode_id){
  return dio.delete("/products/barcode/$product_id?barcodeId=$barcode_id");
}

// Daty przydatno??ci

Future<Response> addExpDates(Dio dio, String product_id, String expDate, int remindDays, String nazwa){
  return dio.put("/products/exp-date/$product_id?date=$expDate&days=$remindDays&note=$nazwa");
}

Future<Response> deleteExpDates(Dio dio, String product_id, String expDate_id){
  return dio.delete("/products/exp-date/$product_id?expirationDateId=$expDate_id");
}
