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


  // Produkty

  fetchAllProdukts() async {
    /*
    SharedPreferences sprefs = await SharedPreferences.getInstance();
    //sprefs.setString('spidom_current_group', currentlyChosenGroupCode);
    currentlyChosenGroupCode = sprefs.getString('spidom_default_group_code');
    */
    produkty = await produktRepository.fetchAllProdukts(currentlyChosenGroupCode);
    update();
  }

  refreshAllProdukts() async {
    /*
    SharedPreferences sprefs = await SharedPreferences.getInstance();
    currentlyChosenGroupCode = sprefs.getString('spidom_default_group_code');
    */
    produkty = await produktRepository.fetchAllProdukts(currentlyChosenGroupCode);
    update();
  }


  Future<Produkt> fetchProdukt(String id) async {
   return await produktRepository.fetchProdukt(id);
   selectedProduct = await produktRepository.fetchProdukt(id);
  }



  addProdukt(Produkt produkt) async {
    produkty.add(await produktRepository.addProdukt(produkt));

    update();


  }

  deleteProdukt(String objectId) async {
    Response response = await produktRepository.deleteProdukt(objectId);
    if(response.data['code'] == null){
      produkty.removeWhere((element) => element.objectId == objectId);
      update();
    }
  }
/*
  updateProdukt(String objectId, Produkt produkt) async {
    Response response = await produktRepository.updateProdukt(objectId, produkt);
    if(response.data['code'] == null){
      int index = produkty.indexWhere((element) => element.objectId == objectId);
      produkty[index] = Produkt.fromJson(response.data);
      update();
    }
  }
*/

  updateProdukt(String objectId, Produkt produkt) async {
    Response response = await produktRepository.updateProdukt(produkt);
    /*
    if(response.data['code'] == null){
      int index = produkty.indexWhere((element) => element.objectId == objectId);
      produkty[index] = Produkt.fromJson(response.data);
      update();
    }
    */
    int index = produkty.indexWhere((element) => element.objectId == objectId);

    //produkty[index] = Produkt.fromJson(response.data);

    produkty[index] = produkt;

    update();
  }


  // Kategorie

  /* Obsolete
  fetchAllKategorie() async {
    kategorie = await produktRepository.fetchAllKategorie();
    update();
  }
  */

  //
  fetchKategorieProdukty() async {
    kategorie = await produktRepository.fetchKategorieProdukt(currentlyChosenGroupCode);
    update();
  }

  //
  fetchKategorieZakupy() async {
    kategorieZakupy = await produktRepository.fetchKategorieZakup(currentlyChosenGroupCode);
    update();
  }

  // *NEW*
  addKategoriaProdukty(Kategoria kategoria) async {
    kategorie.add(await produktRepository.addKategoriaProdukt(kategoria));
    update();
  }

  // *NEW*
  addKategoriaZakupy(KategoriaZakupy kategoriaZakupy) async {
    kategorieZakupy.add(await produktRepository.addKategoriaZakup(kategoriaZakupy));
    update();
  }




  // Return produkty danej kategorii
  fetchProduktyKategorii(String kategoria) async {
    produktyKategorii = await produktRepository.fetchProduktFromCategorie(kategoria);
    update();
  }



/*
  addKategorie(Kategoria kategoria) async {
    kategorie.add(await produktRepository.addKategoria(kategoria));
    update();
  }
*/

  /*
  deleteKategoria(String objectId) async {
    Response response = await produktRepository.deleteKategoria(objectId);
    if(response.data['code'] == null){
      kategorie.removeWhere((element) => element.objectId == objectId);
      update();
    }
  }
  */



  // Zakupy
/*
  addNewZakup(ProduktZakupy produkt) async {
    zakupy.add(await produktRepository.addZakupy(produkt));
    update();
  }
*/
  // *NEW*
  addNewZakup(ShoppingList listaZakupow) async {
    await produktRepository.addZakupy(listaZakupow);
    update();
  }

/*
  fetchZakupy() async {
    zakupy = await produktRepository.fetchAllZakupy();
    update();
  }
*/

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
    /*
    if(response.data['code'] == null){
      int index = zakupy.indexWhere((element) => element.objectId == objectId);
      zakupy[index] = ProduktZakupy.fromJson(response.data);
    }
    */

    int index = listaZakupow.indexWhere((element) => element.objectId == objectId);

    listaZakupow[index] = zakup;

    update();
  }

  deleteZakup(String objectId) async {
    Response response = await produktRepository.deleteZakup(objectId);
    /*
    if(response.data['code'] == null){
      zakupy.removeWhere((element) => element.objectId == objectId);
      update();
    }
    */
    zakupy.removeWhere((element) => element.objectId == objectId);
    update();
  }

  // Atrybuty

  fetchAtrybuty(String objectId) async {
    atrybuty = await produktRepository.fetchAtrybuty(objectId);
    update();
  }
/*
  addAtrybut(String objectId, Atrybuty atrybut) async {
    atrybuty.add(await produktRepository.addAtrybutToObject(objectId, atrybut));
  }
*/
  addAtrybut(String idProduktu, String nazwaAtrybutu) async {
    //atrybuty.add(await produktRepository.addAtrybutToObject(idProduktu, nazwaAtrybutu));
    Atrybuty nowyAtrybut = await produktRepository.addAtrybutToObject(idProduktu, nazwaAtrybutu);
/*
    int index = produkty.indexWhere((element) => element.objectId == idProduktu);
    Produkt tenProdukt = produkty[index];
    tenProdukt.atrybuty.add(nowyAtrybut);
*/
    update();
  }



  deleteAtrybut(String produktId, String atrybutId) async {
    Response response = await produktRepository.deleteAtrybut(produktId, atrybutId);
    /*
    if(response.data['code'] == null){
      atrybuty.removeWhere((element) => element.objectId == objectId);
      update();
    }
    */

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
    if(response.data['code'] == null){
      miary.removeWhere((element) => element.objectId == objectId);
      update();
    }

  }

  // Grupy
  getDeviceGroupList() async {
    SharedPreferences sprefs = await SharedPreferences.getInstance();
    String encGroupListString = (sprefs.getString('spidom_group_list') ?? "");
    if(encGroupListString != "") {
      listaGrup = json.decode(encGroupListString);
    }
  }

  getDefaultDeviceGroup() async {
    SharedPreferences sprefs = await SharedPreferences.getInstance();

    /*
    currentlyChosenGroupCode = sprefs.getString('spidom_default_group_code');
    currentlyChosenGroupName = sprefs.getString('spidom_default_group_name');
    */

    currentlyChosenGroupCode = "fGI57";
    currentlyChosenGroupName = "Spiżarniowa grupa";

    log("Defaultowo wybrana grupa: kod:");
    //log(currentlyChosenGroup.nazwa_server);
    log(currentlyChosenGroupCode);
    log("Defaultowo wybrana grupa: nazwa:");
    log(currentlyChosenGroupName);
    log("Currently chosen group object"); // will always be null without creating the object
    log(currentlyChosenGroup.toString()); // will always be null without creating the object

    /*
    * FOR 5.11
    * Hardcode a group here that is already created on the server
    * Forgo SharedPreferences for now
    *
    * */


    /* Forgo SharedPreferences for now

    String encodedGroupString = sprefs.getString('spidom_group_list');
    log("Encoded");
    log(encodedGroupString);

    Iterable l = json.decode(encodedGroupString);
    listaGrup = RxList.from(l.map((model) => Grupa.fromJson(model)));

    */

    Grupa hardcoded = new Grupa(
      nazwa_server: currentlyChosenGroupName,
      kod_grupy: currentlyChosenGroupCode
    );

    listaGrup.add(hardcoded);


    log("lista grup po MAGICZNYCH WIDZIMISIACH juz jako OBIEKTY");

    listaGrup.forEach((Grupa grupa) {
      log(grupa.nazwa_server);
      log(grupa.kod_grupy);
    });






    // HERE call all the functions that download the data from the server. DO NOT do that in initstate of main.dart or homemain.dart
    fetchMiary();
    fetchKategorieProdukty();
    fetchKategorieZakupy();
    fetchAllProdukts();
    fetchZakupy();

  }

  addGrupyTest(String nazwa) async {
    pobranaGrupa = await produktRepository.addGrupa(nazwa);

    listaGrup.add(pobranaGrupa);

    listaGrup.forEach((Grupa grupa) {
      log(grupa.nazwa_server);
      log(grupa.kod_grupy);
    });

    update();

  }

  addGrupy(String nazwa) async {

    // Set the newly made group as the active one
    currentlyChosenGroup = await produktRepository.addGrupa(nazwa);
    currentlyChosenGroupCode = currentlyChosenGroup.kod_grupy;
    currentlyChosenGroupName = currentlyChosenGroup.nazwa_server;
    /*
    currentlyChosenGroupCode = YtUed;
    currentlyChosenGroupName = Test_z_Apki_LOG;
    */
    // Set the group as the current chosen group in persistent storage
    SharedPreferences sprefs = await SharedPreferences.getInstance();
    sprefs.setString('spidom_current_group', currentlyChosenGroupCode);

    // Add the group to a list of groups saved on the device
    // listaGrup should be decoded somewhere else before -- at app startup

    String encGroupListString = (sprefs.getString('spidom_group_list') ?? "");

    if(encGroupListString != "") {
      Iterable l = json.decode(encGroupListString);
      listaGrup = RxList<Grupa>.from(l.map((model) => Grupa.fromJson(model)));
    }
    //log(listaGrup.toString());
    listaGrup.add(currentlyChosenGroup);// Right after adding is just an instance of not a readable name and code

    var encodedListaGrup = json.encode(listaGrup);

    await sprefs.setString('spidom_group_list', encodedListaGrup);
    String testString = sprefs.getString('spidom_group_list');
    listaGrup = json.decode(testString);
    //log(listaGrup.toString());

    // Set the newly added group as the default one
    sprefs.setString('spidom_default_group_name', currentlyChosenGroup.nazwa_server);
    sprefs.setString('spidom_default_group_code', currentlyChosenGroupCode);




    /*
    * After receiving a response save the group to a list in Shared Preferences // done
    * Also set the group as the current used one //done
    * Also set the current group as the default one to be default in the code for all queries
    * */

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
    pobranaGrupa = await produktRepository.joinGrupa(kod_grupy);
    currentlyChosenGroup = pobranaGrupa;
    currentlyChosenGroupName = pobranaGrupa.nazwa_server;
    currentlyChosenGroupCode = pobranaGrupa.kod_grupy;
  }


  // Funkcje

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