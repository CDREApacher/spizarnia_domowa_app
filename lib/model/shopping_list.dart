import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/grupa.dart';

class ShoppingList{

  String objectId;
  int quantityToBuy;
  Produkt produkt;
  Grupa grupa;

  ShoppingList({
    this.objectId,
    this.quantityToBuy,
    this.produkt,
    this.grupa,
  });

  ShoppingList.fromJson(Map<String, dynamic> json){
    objectId = json['id'];
    quantityToBuy = json['quantityToBuy'];
    produkt = Produkt.fromJson(json['product']);
    grupa = Grupa.fromJson(json['group']);
  }

  Map<String, dynamic> toJson() => {
    'id': objectId,
    'quantityToBuy' : quantityToBuy,
    'product': produkt.toJson(),
    'group' : grupa.toJson(),
  };




}