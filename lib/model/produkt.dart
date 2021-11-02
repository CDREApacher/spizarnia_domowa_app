import 'package:spizarnia_domowa_app/model/atrybuty.dart';
import 'package:spizarnia_domowa_app/model/kategoria.dart';
import 'package:spizarnia_domowa_app/model/kategoria_zakupy.dart';
import 'package:spizarnia_domowa_app/model/miara.dart';
import 'package:spizarnia_domowa_app/model/grupa.dart';

class Produkt {
  String objectId;
  String nazwaProduktu;
  int ilosc;
  Miara miara;
  int progAutoZakupu;
  bool autoZakup;
  KategoriaZakupy kategorieZakupy;
  Kategoria kategorieProdukty;
  List <Atrybuty> atrybuty;
  Grupa grupa;


  Produkt({
    this.objectId,
    this.nazwaProduktu,
    this.ilosc,
    this.miara,
    this.progAutoZakupu,
    this.autoZakup,
    this.kategorieProdukty,
    this.kategorieZakupy,
    this.atrybuty,
    this.grupa,
  });

  /*
  Produkt.fromJson(Map<String, dynamic> json){
    objectId = json['id'];
    nazwaProduktu = json['productName'];
    ilosc = json['quantity'];
    miara = json['miara'];//////////////////
    progAutoZakupu = json['autoPurchaseCount'];
    autoZakup = json['autoPurchase'];
    kategorieProdukty = json['kategorieProdukty'];///////////////
    kategorieZakupy = json['kategorieZakupy'];/////////////////
  }
  */

  Produkt.fromJson(Map<String, dynamic> json){
    objectId = json['id'];
    nazwaProduktu = json['productName'];
    ilosc = json['quantity'];
    miara = Miara.fromJson(json['measure']);
    progAutoZakupu = json['autoPurchaseCount'];
    autoZakup = json['autoPurchase'];
    kategorieProdukty = Kategoria.fromJson(json['categoryProduct']);
    kategorieZakupy = KategoriaZakupy.fromJson(json['categoryShopping']);
    if (json['attributeList'] != null) {
      // ignore: deprecated_member_use
      atrybuty = new List<Atrybuty>();
      json['attributeList'].forEach((v) {
        atrybuty.add(new Atrybuty.fromJson(v));
      });
    }
    grupa = Grupa.fromJson(json['group']);
  }


  /*
  Map<String, dynamic> toJson() => {
    'objectId': objectId,
    'nazwaProduktu': nazwaProduktu,
    'ilosc' : ilosc,
    'miara' : miara,
    'progAutoZakupu' : progAutoZakupu,
    'autoZakup' : autoZakup,
    'kategorieProdukty' : kategorieProdukty,
    'kategorieZakupy' : kategorieZakupy,
  };
  */

  Map<String, dynamic> toJson() => {
    'id': objectId,
    'productName': nazwaProduktu,
    'quantity' : ilosc,

    'group' : grupa.toJson(),

    if (miara != null)
      'measure' : miara.toJson(),
    'autoPurchaseCount' : progAutoZakupu,
    'autoPurchase' : autoZakup,
    if (kategorieProdukty != null)
      'categoryProduct' : kategorieProdukty.toJson(),
    if (kategorieZakupy != null)
      'categoryShopping' : kategorieZakupy.toJson(),
    if (atrybuty != null)
      'attributeList' : atrybuty.map((v) => v.toJson()).toList(),
  };


}// class Produkt
