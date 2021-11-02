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
import 'package:get/instance_manager.dart';

class ProduktController extends GetxController {
  List<Produkt> produkty = [];

  List<Kategoria> kategorie = [];

  List<KategoriaZakupy> kategorieZakupy = [];

  List<String> displayKategorie = []; // add_produkt.dart & produkt_detail.dart

  List<String> displayKategorieZakupy = []; // produkt_detail.dart

  List<Produkt> produktyKategorii = [];

  List<ShoppingList> listaZakupow = [];// lista_zakupow.dart

  List<ProduktZakupy> zakupy = [];
  //List<ProduktZakupy> zakupyWyswietlaj = [];
  List<ShoppingList> zakupyWyswietlaj = [];

  //List<ProduktZakupy> doKupienia = []; // tryb_zakupow.dart
  List<ShoppingList> doKupienia = [];

  List<Atrybuty> atrybuty = [];

  List<Miara> miary = []; // lista_miar.dart

  List<String> displayMiary = [];

  Produkt selectedProduct;
  ProduktRepository produktRepository = ProduktRepository();

  static ProduktController get to => Get.find<ProduktController>();



  // Produkty

  fetchAllProdukts() async {
    produkty = await produktRepository.fetchAllProdukts();
    update();
  }

  refreshAllProdukts() async {
    produkty = await produktRepository.fetchAllProdukts();
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
    produkty[index] = Produkt.fromJson(response.data);
    update();
  }


  // Kategorie

  fetchAllKategorie() async {
    kategorie = await produktRepository.fetchAllKategorie();
    update();
  }






  // *NEW*
  fetchKategorieProdukty() async {
    kategorie = await produktRepository.fetchKategorieProdukt();
    update();
  }

  // *NEW*
  fetchKategorieZakupy() async {
    kategorieZakupy = await produktRepository.fetchKategorieZakup();
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
    listaZakupow = await produktRepository.fetchAllZakupy();
    update();
  }






  buyProdukts(String produktId, int quantity) async{
    return await produktRepository.buyProdukts(produktId, quantity);
    update();
  }







  updateZakup(String objectId, ProduktZakupy produktZakup) async {
    Response response = await produktRepository.updateZakupy(objectId, produktZakup);
    if(response.data['code'] == null){
      int index = zakupy.indexWhere((element) => element.objectId == objectId);
      zakupy[index] = ProduktZakupy.fromJson(response.data);
      update();
    }
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
    atrybuty.add(await produktRepository.addAtrybutToObject(idProduktu, nazwaAtrybutu));
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
    update();

  }

  // Miary

  fetchMiary() async {
    miary = await produktRepository.fetchAllMiary();
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

  addGrupy(Grupa grupa) async {
    await produktRepository.addGrupa(grupa);
    // TODO dodać obsługę grup
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