//import 'dart:html';

import 'package:flutter/material.dart';

import 'package:spizarnia_domowa_app/model/grupa.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/kategoria.dart';
import 'package:spizarnia_domowa_app/model/kategoria_zakupy.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';
import 'package:spizarnia_domowa_app/model/atrybuty.dart';
import 'package:spizarnia_domowa_app/model/miara.dart';
import 'package:spizarnia_domowa_app/model/shopping_list.dart';
import 'package:spizarnia_domowa_app/model/grupa.dart';
import 'package:spizarnia_domowa_app/model/kody_kreskowe.dart';
import 'package:spizarnia_domowa_app/model/expiration_date.dart';

import 'package:spizarnia_domowa_app/repository/produkt_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_core/get_core.dart';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/instance_manager.dart';



import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:logger/logger.dart';
import 'dart:developer';

class ProduktController extends GetxController {

  RxList<Produkt> produkty = <Produkt>[].obs;

  RxList<Kategoria> kategorie = <Kategoria>[].obs; // Kategorie produktow

  RxList<KategoriaZakupy> kategorieZakupy = <KategoriaZakupy>[].obs; // Kategorie zakupow

  List<String> displayKategorie = []; // add_produkt.dart & produkt_detail.dart

  List<String> displayKategorieZakupy = []; // produkt_detail.dart

  List<Produkt> produktyKategorii = [];

  RxList<ShoppingList> listaZakupow = <ShoppingList>[].obs;// lista_zakupow.dart

  List<ProduktZakupy> zakupy = [];

  //List<ProduktZakupy> zakupyWyswietlaj = []; BE

  RxList<ShoppingList> zakupyWyswietlaj = <ShoppingList>[].obs;

  //List<ProduktZakupy> doKupienia = []; // tryb_zakupow.dart BE

  RxList<ShoppingList> doKupienia = <ShoppingList>[].obs;

  RxList<Atrybuty> atrybuty = <Atrybuty>[].obs;

  RxList<Miara> miary = <Miara>[].obs; // lista_miar.dart
  /*
   * Old way of using was:
   * List<Miara> miary = [];
   * When changing to RxList here ALSO change in Repository
   */


  List<String> displayMiary = [];


  Grupa pobranaGrupa;


  Produkt selectedProduct;
  ProduktRepository produktRepository = ProduktRepository();

  static ProduktController get to => Get.find<ProduktController>();




  Logger logger = Logger();

  Grupa currentlyChosenGroup;
  String currentlyChosenGroupCode;
  String currentlyChosenGroupName;

  //RxList<dynamic> listaGrup = <dynamic>[].obs;
  RxList<Grupa> listaGrup = <Grupa>[].obs;

  RxList<Grupa> listaGrupWyswietlaj = <Grupa>[].obs;



  RxList<Grupa> listaGrupTest = <Grupa>[].obs;



  String kod_kreskowy_nowego_produktu;
  String data_produktu_poprawny_format;


  // Produkty

  fetchAllProdukts() async {

    produkty = await produktRepository.fetchAllProdukts(currentlyChosenGroupCode);

    update();
  }

  refreshAllProdukts() async {

    produkty = await produktRepository.fetchAllProdukts(currentlyChosenGroupCode);
    update();
  }

  Future<Produkt> fetchProdukt(String id) async {
   return await produktRepository.fetchProdukt(id);

  }

  addProdukt(Produkt produkt) async {
    produkty.add(await produktRepository.addProdukt(produkt));

    update();


  }
/*
  deleteProdukt(String objectId) async {
    Response response = await produktRepository.deleteProdukt(objectId);
    if(response.data['code'] == null){
      produkty.removeWhere((element) => element.objectId == objectId);
      update();
    }
  }
*/

  updateProdukt(String objectId, Produkt produkt) async {
    Response response = await produktRepository.updateProdukt(produkt);

    int index = produkty.indexWhere((element) => element.objectId == objectId);

    produkty[index] = produkt;

    update();
  }


  // Kategorie

  fetchKategorieProdukty() async {
    kategorie = await produktRepository.fetchKategorieProdukt(currentlyChosenGroupCode);
    update();
  }

  fetchKategorieZakupy() async {
    kategorieZakupy = await produktRepository.fetchKategorieZakup(currentlyChosenGroupCode);
    update();
  }

  addKategoriaProdukty(Kategoria kategoria) async {
    kategorie.add(await produktRepository.addKategoriaProdukt(kategoria));
    update();
  }

  addKategoriaZakupy(KategoriaZakupy kategoriaZakupy) async {
    kategorieZakupy.add(await produktRepository.addKategoriaZakup(kategoriaZakupy));
    update();
  }

  deleteKategorieProdukty(String objectId) async {
    Response response = await produktRepository.deleteKategoriaProduktu(objectId);

    kategorie.removeWhere((element) => element.objectId == objectId);
    update();
  }

  deleteKategorieZakupy(String objectId) async {
    Response response = await produktRepository.deleteKategoriaZakupu(objectId);

    kategorieZakupy.removeWhere((element) => element.objectId == objectId);
    update();
  }



  // Zakupy

  addNewZakup(ShoppingList listaZakupow) async {
    await produktRepository.addZakupy(listaZakupow);
    update();
  }

  fetchZakupy() async {
    listaZakupow = await produktRepository.fetchAllZakupy(currentlyChosenGroupCode);
    update();
  }

  buyProdukts(String produktId, int quantity) async{
    return await produktRepository.buyProdukts(produktId, quantity);
    update();
  }

  updateZakup(String objectId, int quantity, ShoppingList zakup) async {
    Response response = await produktRepository.updateZakupy(objectId, quantity);

    int index = listaZakupow.indexWhere((element) => element.objectId == objectId);

    listaZakupow[index] = zakup;

    update();
  }

  deleteZakup(String objectId) async {
    Response response = await produktRepository.deleteZakup(objectId);

    zakupy.removeWhere((element) => element.objectId == objectId);
    listaZakupow.removeWhere((element) => element.objectId == objectId);
    update();
  }

  // Atrybuty

  addAtrybut(String idProduktu, String nazwaAtrybutu) async {

    int index = produkty.indexWhere((element) => element.objectId == idProduktu);
    Produkt tenProdukt = produkty[index];
    tenProdukt.atrybuty.add(await produktRepository.addAtrybutToObject(idProduktu, nazwaAtrybutu));

    update();
  }

  deleteAtrybut(String produktId, String atrybutId) async {
    Response response = await produktRepository.deleteAtrybut(produktId, atrybutId);

    int index = produkty.indexWhere((element) => element.objectId == produktId);
    Produkt tenProdukt = produkty[index];
    tenProdukt.atrybuty.removeWhere((element2) => element2.objectId == atrybutId);

    update();
  }

  // Miary

  fetchMiary() async {
    miary = await produktRepository.fetchAllMiary(currentlyChosenGroupCode);
    update();
  }

  addMiary(Miara miara) async {
    miary.add(await produktRepository.addMiara(miara));
    update();
  }

  deleteMiary(String objectId) async {
    Response response = await produktRepository.deleteMiara(objectId);

    miary.removeWhere((element) => element.objectId == objectId);
    update();
  }

  // Grupy
  getDeviceGroupList() async {
    SharedPreferences sprefs = await SharedPreferences.getInstance();

    String encGroupListString = (sprefs.getString('spidom_group_list') ?? "");

    if(encGroupListString != "") {
      Iterable l = json.decode(encGroupListString);
      listaGrup = RxList.from(l.map((model) => Grupa.fromJson(model)));
    }

    listaGrup.forEach((Grupa grupa) {
      log(grupa.nazwa_server);
      log(grupa.kod_grupy);
    });

  }

  getDefaultDeviceGroup() async {
    SharedPreferences sprefs = await SharedPreferences.getInstance();

    currentlyChosenGroupCode = (sprefs.getString('spidom_default_group_code') ?? "");
    currentlyChosenGroupName = (sprefs.getString('spidom_default_group_name') ?? "");

    log("Defaultowo wybrana grupa: kod:");
    log(currentlyChosenGroupCode);
    log("Defaultowo wybrana grupa: nazwa:");
    log(currentlyChosenGroupName);


    // We got the group, now get their data
    // HERE call all the functions that download the data from the server. DO NOT do that in initstate of main.dart or homemain.dart
    /*
    fetchMiary();
    fetchKategorieProdukty();
    fetchKategorieZakupy();
    fetchAllProdukts();
    fetchZakupy();
    */
    fetchFromDatabse();
  }

  test_addTestGrupy() {

    addGrupyTest("Testowa Grupa 111");

    addGrupyTest("Testowa Grupa 222");

  }

  addGrupyTest(String nazwa) async {
    SharedPreferences sprefs = await SharedPreferences.getInstance();

    pobranaGrupa = await produktRepository.addGrupa(nazwa);

    listaGrup.add(pobranaGrupa);

    sprefs.setString('spidom_default_group_name', pobranaGrupa.nazwa_server);
    sprefs.setString('spidom_default_group_code', pobranaGrupa.kod_grupy);

    listaGrup.forEach((Grupa grupa) {
      log(grupa.nazwa_server);
      log(grupa.kod_grupy);
    });

    String encodedGroupString = (sprefs.getString('spidom_group_list') ?? "");

    var encodedListaGrup = json.encode(listaGrup);

    await sprefs.setString('spidom_group_list', encodedListaGrup);
    String testString = sprefs.getString('spidom_group_list');

    Iterable l = json.decode(encodedGroupString);
    listaGrup = RxList.from(l.map((model) => Grupa.fromJson(model)));

    log("----------------------------------------------------------------");

    listaGrup.forEach((Grupa grupa) {
      log(grupa.nazwa_server);
      log(grupa.kod_grupy);
    });

    update();

  }

  addGrupy(String nazwa) async {
    // Initialise persistent storage
    SharedPreferences sprefs = await SharedPreferences.getInstance();

    // Set the newly made group as the active one
    // This will make all queries be done on this group
    currentlyChosenGroup = await produktRepository.addGrupa(nazwa);
    currentlyChosenGroupCode = currentlyChosenGroup.kod_grupy;
    currentlyChosenGroupName = currentlyChosenGroup.nazwa_server;


    // Set the group as the current chosen group in persistent storage as default
    sprefs.setString('spidom_default_group_name', currentlyChosenGroupName);
    sprefs.setString('spidom_default_group_code', currentlyChosenGroupCode);

    // Add the group to a list of groups saved on the device
    // listaGrup should be decoded somewhere else before -- at app startup
    // IT WILL BE DECODED
    // The decoding function getDeviceGroupList() runs in main.dart


    listaGrup.add(currentlyChosenGroup);// Right after adding is just an instance of not a readable name and code

    var encodedListaGrup = json.encode(listaGrup);// Encode to a string

    await sprefs.setString('spidom_group_list', encodedListaGrup);// Save string in persistent storage
    String groupListString = sprefs.getString('spidom_group_list');// Read the string

    // Recover the group list from the encoded string
    Iterable glist = json.decode(groupListString);
    listaGrup = RxList.from(glist.map((model) => Grupa.fromJson(model)));

    // Fetch all the data for this group
    fetchFromDatabse();

    update();
  }

  joinGrupyTest(String kod_grupy) async {

    pobranaGrupa = await produktRepository.joinGrupa(kod_grupy);
    listaGrup.add(pobranaGrupa);

    listaGrup.forEach((Grupa grupa) {
      log(grupa.nazwa_server);
      log(grupa.kod_grupy);
    });

    update();

  }

  joinGrupy(String kod_grupy) async {
    // Initialise persistent storage
    SharedPreferences sprefs = await SharedPreferences.getInstance();

    // Set the newly made group as the active one
    // This will make all queries be done on this group
    pobranaGrupa = await produktRepository.joinGrupa(kod_grupy);
    currentlyChosenGroup = pobranaGrupa;
    currentlyChosenGroupName = pobranaGrupa.nazwa_server;
    currentlyChosenGroupCode = pobranaGrupa.kod_grupy;

    // Set the group as the current chosen group in persistent storage as default
    sprefs.setString('spidom_default_group_code', currentlyChosenGroupCode);
    sprefs.setString('spidom_default_group_name', currentlyChosenGroupName);

    listaGrup.add(pobranaGrupa);// Right after adding is just an instance of not a readable name and code

    var encodedListaGrup = json.encode(listaGrup);// Encode to a string

    await sprefs.setString('spidom_group_list', encodedListaGrup);// Save string in persistent storage
    String groupListString = sprefs.getString('spidom_group_list');// Read the string

    // Recover the group list from the encoded string
    Iterable glist = json.decode(groupListString);
    listaGrup = RxList.from(glist.map((model) => Grupa.fromJson(model)));

    // Fetch all the data for this group
    fetchFromDatabse();

    update();
  }

  selectActiveGroup(String nazwa, String kod_grupy) async {
    // Initialise persistent storage
    SharedPreferences sprefs = await SharedPreferences.getInstance();

    // Set the selected group as active

    currentlyChosenGroupCode = kod_grupy;
    currentlyChosenGroupName = nazwa;

    // Set the group as the current chosen group in persistent storage as default
    sprefs.setString('spidom_default_group_code', currentlyChosenGroupCode);
    sprefs.setString('spidom_default_group_name', currentlyChosenGroupName);

    log("Zmieniono grupę na:");
    log(currentlyChosenGroupName);
    log(currentlyChosenGroupCode);

    fetchFromDatabse();
  }


  // Barcody

  addBarcodes(String barcode, String product_id, String name) async {
    Barcodes newBarcode = await produktRepository.addBarcodeToObject(barcode, product_id, name);
    update();
  }

  deleteBarcodes(String product_id, String barcode_id) async {
    Response response = await produktRepository.deleteBarcode(product_id, barcode_id);

    int index = produkty.indexWhere((element) => element.objectId == product_id);
    Produkt tenProdukt = produkty[index];
    tenProdukt.kody_kreskowe.removeWhere((element2) => element2.id == barcode_id);

    update();
  }

  // Daty spożycia
  addExpDates(String product_id, String expDate, int remindDays, String nazwa) async {
    ExpirationDate newExpDate = await produktRepository.addExpDateToObject(product_id, expDate, remindDays, nazwa);
    update();
  }

  deleteExpDates(String product_id, String expDate_id) async {
    Response response = await produktRepository.deleteExpDate(product_id, expDate_id);

    int index = produkty.indexWhere((element) => element.objectId == product_id);
    Produkt tenProdukt = produkty[index];
    tenProdukt.daty_waznosci.removeWhere((element2) => element2.id == expDate_id);

    update();
  }

  // Funkcje

  fetchFromDatabse(){
    fetchMiary();
    fetchKategorieProdukty();
    fetchKategorieZakupy();
    fetchAllProdukts();
    fetchZakupy();
  }



  setSelected(Produkt produkt){
    selectedProduct = produkt;
    update();
  }

  clearSelected(){
    selectedProduct = null;
    update();
  }



  // Znajdz index obiektu w liscie zakupy gdzie :
  // Produkt.objectId == ProduktZakupy.objectIdProduktu
  findProduktInZakupyList(String produktId){
    int index = zakupy.indexWhere((element) => element.objectIdProduktu == produktId);
    return index;
  }

  getProduktFromZakupy(int index){
    return zakupy[index];
    /*
    * Child function to findProduktInZakupyList
    * should be called if the parent function returns something other than -1
    * returns a ProduktZakupy object
    * */
  }



} // class ProduktController