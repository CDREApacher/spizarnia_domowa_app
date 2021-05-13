import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/repository/produkt_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ProduktController extends GetxController {
  List<Produkt> produkty = [];
  Produkt selectedProduct;
  ProduktRepository produktRepository = ProduktRepository();

  static ProduktController get to => Get.find<ProduktController>();

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
      produkty[index] == Produkt.fromJson(response.data);
      update();
    }
  }

  setSelected(Produkt produkt){
    selectedProduct = produkt;
    update();
  }

  clearSelected(){
    selectedProduct = null;
    update();
  }



} // class ProduktController