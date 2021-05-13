import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/kategoria.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';
import 'package:spizarnia_domowa_app/model/atrybuty.dart';

import 'package:spizarnia_domowa_app/repository/produkt_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ProduktController extends GetxController {
  List<Produkt> produkty = [];

  List<Kategoria> kategorie = [];

  List<Produkt> produktyKategorii = [];

  List<ProduktZakupy> zakupy = [];

  List<Atrybuty> atrybuty = [];

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

  /*
  Future<List<Produkt>> fetchProdukt(String id) async {
   return await produktRepository.fetchProdukt(id);
  }
  */

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

  updateProdukt(String objectId, Produkt produkt) async {
    Response response = await produktRepository.updateProdukt(objectId, produkt);
    if(response.data['code'] == null){
      int index = produkty.indexWhere((element) => element.objectId == objectId);
      produkty[index] = Produkt.fromJson(response.data);
      update();
    }
  }

  // Kategorie


  fetchAllKategorie() async {
    kategorie = await produktRepository.fetchAllKategorie();
  }

  // Return produkty danej kategorii
  fetchProduktyKategorii(String kategoria) async {
    produktyKategorii = await produktRepository.fetchProduktFromCategorie(kategoria);
    update();
  }

  addKategorie(Kategoria kategoria) async {
    kategorie.add(await produktRepository.addKategoria(kategoria));
    update();
  }



  // Zakupy

  addNewZakup(ProduktZakupy produkt) async {
    zakupy.add(await produktRepository.addZakupy(produkt));
    update();
  }

  fetchZakupy() async {
    zakupy = await produktRepository.fetchAllZakupy();
    update();
  }

  // Atrybuty

  fetchAtrybuty(String objectId) async {
    atrybuty = await produktRepository.fetchAtrybuty(objectId);
    update();
  }

  addAtrybut(Atrybuty atrybut) async {
    atrybuty.add(await produktRepository.addAtrybutToObject(atrybut));
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



} // class ProduktController