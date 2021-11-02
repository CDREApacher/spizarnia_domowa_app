import 'package:dio/dio.dart';

// Produkty

/* BE

Future<Response> fetchAll(Dio dio, int pgOffset){
  return dio.get("/data/Produkt", queryParameters: {'pageSize' : 100, 'offset' : pgOffset});
}
*/
// *NEW*
Future<Response> fetchAll(Dio dio/*, int pgOffset*/){
  return dio.get("/products/all");
}

/* B
Future<Response> fetchAll(Dio dio){
  return dio.get("/data/Produkt", queryParameters: {'pageSize' : 100});
}
*/

Future<Response> getCount(Dio dio){
  return dio.get("/data/Produkt", queryParameters: {'property' : 'Count(nazwaProduktu)'});
}
// BE
Future<Response> fetch(Dio dio, String objectId){
  return dio.get("/data/Produkt/$objectId");
}
/* BE
Future<Response> add(Dio dio, Map<String, dynamic> dane){
  return dio.post("/data/Produkt", data: dane);
}
*/

// *NEW*
Future<Response> add(Dio dio, Map<String, dynamic> dane){
  return dio.post("/products", data: dane);
}


Future<Response> delete(Dio dio, String objectId){
  return dio.delete("/data/Produkt/$objectId");
}
/*
Future<Response> update(Dio dio, String objectId, Map<String, dynamic> dane){
  return dio.put("/data/Produkt/$objectId", data: dane);
}
*/

// *NEW*
Future<Response> update(Dio dio, Map<String, dynamic> dane){
  return dio.put("/products/update", data: dane);
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






// *NEW*
Future<Response> fetchKategorieProdukty(Dio dio){
  return dio.get("/category-product/all");
}

// *NEW*
Future<Response> fetchKategorieZakupy(Dio dio){
  return dio.get("/category-shopping/all");
}



// *NEW*
Future<Response> addKategorieProdukty(Dio dio, Map<String, dynamic> dane){
  return dio.post("/category-product", data: dane);
}

// *NEW*
Future<Response> addKategorieZakupy(Dio dio, Map<String, dynamic> dane){
  return dio.post("/category-shopping", data: dane);
}





/* BE
Future<Response> addKategorie(Dio dio, Map<String, dynamic> dane){
  return dio.post("/data/Kategorie", data: dane);
}*/

/* BE
Future<Response> deleteKategorie(Dio dio, String objectId){
  return dio.delete("/data/Kategorie/$objectId");
}
*/


// Zakupy
/*
Future<Response> fetchZakupy(Dio dio){
  return dio.get("/data/Lista_Zakupow", queryParameters: {'pageSize' : 100});
}
*/
Future<Response> fetchZakupy(Dio dio){
  return dio.get("/shopping-list/all");
}
/*
Future<Response> addZakup(Dio dio, Map<String, dynamic> dane){
  return dio.post("/data/Lista_Zakupow", data: dane);
}
*/

// *NEW*
Future<Response> addZakup(Dio dio, Map<String, dynamic> dane){
  return dio.post("/shopping-list", data: dane);
}


Future<Response> deleteZakupy(Dio dio, String objectId){
  return dio.delete("/shopping-list/$objectId");
}



Future<Response> buyProdukt(Dio dio, String produktId, int quantity) {
  return dio.post("/shopping-list/buy/$produktId?quantity=$quantity");
}





Future<Response> updateZakup(Dio dio, String objectId, Map<String, dynamic> dane){
  return dio.put("/data/Lista_Zakupow/$objectId", data: dane);
}

/*
Future<Response> deleteZakupy(Dio dio, String objectId){
  return dio.delete("/data/Lista_Zakupow/$objectId");
}
*/


// Atrybuty

Future<Response> fetchAtrybutyById(Dio dio, String objectId){
  return dio.get("/data/Atrybuty?where=objectIdProdukt%3D'$objectId'", queryParameters: {'pageSize' : 100});
}

/* BE
Future<Response> addAtrybut(Dio dio, Map<String, dynamic> dane){
  return dio.post("/data/Atrybuty", data: dane);
}
 */


// *NEW* ???????????????????????
/*
Future<Response> addAtrybut(Dio dio, String objectId, Map<String, dynamic> dane){
  return dio.put("/products/$objectId", data: dane);
}
*/

Future<Response> addAtrybut(Dio dio, String idProduktu, String nazwaAtrybutu){
  return dio.put("/products/attribute/$idProduktu?attributeName=$nazwaAtrybutu");
}

Future<Response> deleteAtrybuty(Dio dio, String produktId, String atrybutId){
  return dio.delete("/products/attribute/$produktId?attributeId=$atrybutId");
}

// Miary

/* BE
Future<Response> fetchMiary(Dio dio){
  return dio.get("/data/Miara", queryParameters: {'pageSize' : 100});
}
*/

// *NEW*
Future<Response> fetchMiary(Dio dio){
  return dio.get("/measures/all");
}

/* BE
Future<Response> addMiary(Dio dio, Map<String, dynamic> dane){
  return dio.post("/data/Miara", data: dane);
}
*/

Future<Response> addMiary(Dio dio, Map<String, dynamic> dane){
  return dio.post("/measures", data: dane);
}

Future<Response> deleteMiary(Dio dio, String objectId){
  return dio.delete("/data/Miara/$objectId");
}

// Grupy
Future<Response> addGrupy(Dio dio, String nazwa){
  return dio.post("/groups?name=$nazwa");

}