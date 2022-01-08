import 'dart:convert';
import 'dart:developer';

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
import 'package:spizarnia_domowa_app/model/kody_kreskowe.dart';
import 'package:spizarnia_domowa_app/model/expiration_date.dart';

import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

class ProduktRepository{

  Dio apiClient;

  ProduktRepository(){
    apiClient = client();
    // initialize others if needed
  }

  // Produkty

  Future<RxList<Produkt>> fetchAllProdukts(String kod_grupy) async {

    Response response = await fetchAll(apiClient, kod_grupy);

    return RxList<Produkt>.from(
      (response.data).map((json) => Produkt.fromJson(json))
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
/*
  Future<Response> deleteProdukt(String objectId) async {
    return await delete(apiClient, objectId);
  }
*/

  Future<Response> updateProdukt(Produkt produkt) async {
    return await update(apiClient, produkt.toJson());
  }

  Future<Response> deleteProdukty(String objectId) async {
    return await deleteProdukt(apiClient, objectId);
  }

  // Kategorie

  Future<RxList<Kategoria>> fetchKategorieProdukt(String kod_grupy) async {
    Response response = await fetchKategorieProdukty(apiClient, kod_grupy);

    return RxList<Kategoria>.from(
        (response.data).map((json) => Kategoria.fromJson(json))
    );
  }

  Future<RxList<KategoriaZakupy>> fetchKategorieZakup(String kod_grupy) async {
    Response response = await fetchKategorieZakupy(apiClient, kod_grupy);

    return RxList<KategoriaZakupy>.from(
        (response.data).map((json) => KategoriaZakupy.fromJson(json))
    );
  }

  Future<Kategoria> addKategoriaProdukt(Kategoria kategoria) async {
    Response response = await addKategorieProdukty(apiClient, kategoria.toJson());
    return Kategoria.fromJson(response.data);
  }

  Future<KategoriaZakupy> addKategoriaZakup(KategoriaZakupy kategoriaZakupy) async {
    Response response = await addKategorieZakupy(apiClient, kategoriaZakupy.toJson());
    return KategoriaZakupy.fromJson(response.data);
  }

  Future<Response> deleteKategoriaProduktu(String objectId) async {
    return await deleteKategorieProdukty(apiClient, objectId);
  }

  Future<Response> deleteKategoriaZakupu(String objectId) async {
    return await deleteKetegorieZakupy(apiClient, objectId);
  }

  // Zakupy

  Future<RxList<ShoppingList>> fetchAllZakupy(String kod_grupy) async {
    Response response = await fetchZakupy(apiClient, kod_grupy);

    return RxList<ShoppingList>.from(
        (response.data).map((json) => ShoppingList.fromJson(json))
    );
  }

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

  // Grupy

  Future<Grupa> addGrupa(String nazwa) async {
    Response response = await addGrupy(apiClient, nazwa);
    return Grupa.fromJson(response.data);

  }

  Future<Grupa> joinGrupa(String kod_grupy) async {
    Response response = await joinGrupy(apiClient, kod_grupy);
    return Grupa.fromJson(response.data);

  }

  // Barcody
  Future<Barcodes> addBarcodeToObject(String barcode, String product_id, String name) async {
    Response response = await addBarcodes(apiClient, barcode, product_id, name);

    return Barcodes.fromJson(response.data);
  }

  Future<Response> deleteBarcode(String product_id, String barcode_id) async {
    return await deleteBarcodes(apiClient, product_id, barcode_id);
  }

  // Daty przydatności

  Future<ExpirationDate> addExpDateToObject(String product_id, String expDate, int remindDays, String nazwa ) async {
    Response response = await addExpDates(apiClient, product_id, expDate, remindDays, nazwa);

    return ExpirationDate.fromJson(response.data);
  }

  Future<Response> deleteExpDate(String product_id, String expDate_id) async {
    return await deleteExpDates(apiClient, product_id, expDate_id);
  }


} // class ProduktRepository