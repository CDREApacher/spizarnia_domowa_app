import 'package:spizarnia_domowa_app/model/produkt.dart';
class ShoppingList{

  String objectId;
  int quantityToBuy;
  Produkt produkt;

  ShoppingList({
    this.objectId,
    this.quantityToBuy,
    this.produkt
  });

  ShoppingList.fromJson(Map<String, dynamic> json){
    objectId = json['id'];
    quantityToBuy = json['quantityToBuy'];
    produkt = Produkt.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() => {
    'id': objectId,
    'quantityToBuy' : quantityToBuy,
    'product': produkt.toJson(),
  };




}