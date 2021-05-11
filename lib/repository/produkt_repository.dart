import 'package:dio/dio.dart';
import 'package:spizarnia_domowa_app/api/client.dart';
import 'package:spizarnia_domowa_app/api/produkty_api.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/item_count.dart';


class ProduktRepository{

  Dio apiClient;
  // or Database
  // or Shared Preferences

  ProduktRepository(){
    apiClient = client();
    // initialize others if needed
  }

  Future<List<Produkt>> fetchAllProdukts() async {
    /*Response response = await fetchAll(apiClient);

    return List<Produkt>.from(
      (response.data).map((json) => Produkt.fromJson(json)),*/ // Old method that didn't include paging

    List<Produkt> listaP = [];
    List<ItemCount> itemCountList = await fetchItemCount(apiClient);

    Response response;
    int pgOffset = 0;

    do {
      response = await fetchAll(apiClient, pgOffset);
      listaP += List<Produkt>.from(
          (response.data).map((json) => Produkt.fromJson(json))
      );
      pgOffset += 100;
    } while (pgOffset < itemCountList.first.counted);

    return listaP;
  }

  Future<List<ItemCount>> fetchItemCount(apiClient) async {
    Response response = await getCount(apiClient);

    return List<ItemCount>.from(
        (response.data).map((json) => ItemCount.fromJson(json)),
    );
  }

  Future<List<Produkt>> fetchProdukt(String objectId) async {
    Response response = await fetch(apiClient, objectId);

    return List<Produkt>.from(
        (response.data).map((json) => Produkt.fromJson(json)),
    );
  }

  Future<Produkt> addProdukt(Produkt produkt) async {
    Response response = await add(apiClient, produkt.toJson());
    return Produkt.fromJson(response.data);
  }

  Future<Response> deleteProdukt(String objectId) async {
    return await delete(apiClient, objectId);
  }

  Future<Response> updateProdukt(String objectId, Produkt produkt) async {
    return await update(apiClient, objectId, produkt.toJson());
  }

} // class ProduktRepository