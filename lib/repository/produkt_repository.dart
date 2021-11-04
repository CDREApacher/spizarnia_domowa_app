import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:spizarnia_domowa_app/api/client.dart';
import 'package:spizarnia_domowa_app/api/produkty_api.dart';
import 'package:spizarnia_domowa_app/model/kategoria.dart';
import 'package:spizarnia_domowa_app/model/kategoria_zakupy.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/item_count.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';
import 'package:spizarnia_domowa_app/model/atrybuty.dart';
import 'package:spizarnia_domowa_app/model/miara.dart';
import 'package:spizarnia_domowa_app/model/shopping_list.dart';
import 'package:spizarnia_domowa_app/model/grupa.dart';

import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

class ProduktRepository{

  //final ProduktController produktController = ProduktController.to;

  Dio apiClient;
  // or Database
  // or Shared Preferences

  ProduktRepository(){
    apiClient = client();
    // initialize others if needed
  }

  // Produkty

  Future<RxList<Produkt>> fetchAllProdukts(String kod_grupy) async {

    Response response = await fetchAll(apiClient, kod_grupy);

    return RxList<Produkt>.from(
      (response.data).map((json) => Produkt.fromJson(json))
      ); // Old method that didn't include paging


    /*
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
    */
  }




  Future<List<ItemCount>> fetchItemCount(apiClient) async {
    Response response = await getCount(apiClient);

    return List<ItemCount>.from(
      (response.data).map((json) => ItemCount.fromJson(json)),
    );
  }

  Future<Produkt> fetchProdukt(String objectId) async {
    Response response = await fetch(apiClient, objectId);

    return Produkt.fromJson(response.data);
  }

  Future<Produkt> addProdukt(Produkt produkt) async {
    Response response = await add(apiClient, produkt.toJson());
    return Produkt.fromJson(response.data);
  }

  Future<Response> deleteProdukt(String objectId) async {
    return await delete(apiClient, objectId);
  }
/*
  Future<Response> updateProdukt(String objectId, Produkt produkt) async {
    return await update(apiClient, objectId, produkt.toJson());
  }
*/

  Future<Response> updateProdukt(Produkt produkt) async {
    return await update(apiClient, produkt.toJson());
  }


  // Return Produkty nalezace do danej kategorii
  Future<List<Produkt>> fetchProduktFromCategorie(String kategoria) async {
    Response response = await fetchProduktFromCategory(apiClient, kategoria);

    return List<Produkt>.from(
        (response.data).map((json) => Produkt.fromJson(json)),
    );

  }

  // Kategorie

  /* Obsolete
  Future<List<Kategoria>> fetchAllKategorie() async {
    Response response = await fetchKategorie(apiClient);

    return List<Kategoria>.from(
        (response.data).map((json) => Kategoria.fromJson(json))
    );
  }
 */

  //
  Future<RxList<Kategoria>> fetchKategorieProdukt(String kod_grupy) async {
    Response response = await fetchKategorieProdukty(apiClient, kod_grupy);

    return RxList<Kategoria>.from(
        (response.data).map((json) => Kategoria.fromJson(json))
    );
  }

  // *NEW*
  Future<RxList<KategoriaZakupy>> fetchKategorieZakup(String kod_grupy) async {
    Response response = await fetchKategorieZakupy(apiClient, kod_grupy);

    return RxList<KategoriaZakupy>.from(
        (response.data).map((json) => KategoriaZakupy.fromJson(json))
    );
  }

  // *NEW*
  Future<Kategoria> addKategoriaProdukt(Kategoria kategoria) async {
    Response response = await addKategorieProdukty(apiClient, kategoria.toJson());
    return Kategoria.fromJson(response.data);
  }

  // *NEW*
  Future<KategoriaZakupy> addKategoriaZakup(KategoriaZakupy kategoriaZakupy) async {
    Response response = await addKategorieZakupy(apiClient, kategoriaZakupy.toJson());
    return KategoriaZakupy.fromJson(response.data);
  }




  /*
  Future<Kategoria> addKategoria(Kategoria kategoria) async {
    Response response = await addKategorie(apiClient, kategoria.toJson());
    return Kategoria.fromJson(response.data);
  }
   */

  /*
  Future<Response> deleteKategoria(String objectId) async {
    return await deleteKategorie(apiClient, objectId);
  }

   */

  // Zakupy

  Future<RxList<ShoppingList>> fetchAllZakupy(String kod_grupy) async {
    Response response = await fetchZakupy(apiClient, kod_grupy);

    return RxList<ShoppingList>.from(
        (response.data).map((json) => ShoppingList.fromJson(json))
    );
  }
/*
  Future<ProduktZakupy> addZakupy(ProduktZakupy produktZakup) async {
    Response response = await addZakup(apiClient, produktZakup.toJson());

    return ProduktZakupy.fromJson(response.data);
  }
*/
  Future<ShoppingList> addZakupy(ShoppingList listaZakupow) async {
    Response response = await addZakup(apiClient, listaZakupow.toJson());

    return ShoppingList.fromJson(response.data);
  }





  Future<Response> buyProdukts(String produktId, int quantity) async {
    return await buyProdukt(apiClient, produktId, quantity);
  }






  Future<Response> updateZakupy(String objectId, int quantity) async {
    return await updateZakup(apiClient, objectId, quantity);
  }



  Future<Response> deleteZakup(String objectId) async {
    return await deleteZakupy(apiClient, objectId);
  }

  // Atrybuty
  //BE Obsolete
  Future<List<Atrybuty>> fetchAtrybuty(String objectId) async {
    Response response = await fetchAtrybutyById(apiClient, objectId);

    return List<Atrybuty>.from(
        (response.data).map((json) => Atrybuty.fromJson(json))
    );
  }


  /*
  Future<Atrybuty> addAtrybutToObject(String objectId, Atrybuty atrybut) async {
    Response response = await addAtrybut(apiClient, objectId, atrybut.toJson());

    return Atrybuty.fromJson(response.data);
  }
  */
  Future<Atrybuty> addAtrybutToObject(String idProduktu, String nazwaAtrybutu) async {
    Response response = await addAtrybut(apiClient, idProduktu, nazwaAtrybutu);

    return Atrybuty.fromJson(response.data);
  }



  Future<Response> deleteAtrybut(String produktId, String atrybutId) async {
    return await deleteAtrybuty(apiClient, produktId, atrybutId);
  }


  // Miary

  Future<RxList<Miara>> fetchAllMiary(String kod_grupy) async {
    Response response = await fetchMiary(apiClient, kod_grupy);

    return RxList<Miara>.from(
        (response.data).map((json) => Miara.fromJson(json))
    );
  }



  Future<Miara> addMiara(Miara miara) async {
    Response response = await addMiary(apiClient, miara.toJson());
    return Miara.fromJson(response.data);
  }



  Future<Response> deleteMiara(String objectId) async {
    return await deleteMiary(apiClient, objectId);
  }



  /*
  Future<List<Kategoria>> fetchKategorieProdukty() async {
    Response response = await fetchKategorieProdukty();

    return List<Kategoria>.from(
        (response.data).map((json) => Kategoria.fromJson(json))
    );
  }
*/

  /*
  Future<List<Kategoria>> fetchKategorieZakupy() async {
    Response response = await fetchKategorieZakupy(apiClient);

    return List<Kategoria>.from(
        (response.data).map((json) => Kategoria.fromJson(json))
    );
  }
*/

  // Grupy

  Future<Grupa> addGrupa(String nazwa) async {
    Response response = await addGrupy(apiClient, nazwa);
    return Grupa.fromJson(response.data);

  }

  Future<Grupa> joinGrupa(String kod_grupy) async {
    Response response = await joinGrupy(apiClient, kod_grupy);

    return Grupa.fromJson(response.data);
    /*
    if(response.data != ""){
      return Grupa.fromJson(response.data);
    }else{
      return null;
    }
    */
  }

} // class ProduktRepository