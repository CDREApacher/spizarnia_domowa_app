//import 'package:spizarnia_domowa_app/model/grupa.dart';
// I think this is for BE edition of the app - unused in current model
class ProduktZakupy {

  String objectId;
  String kategoriaZakupy;
  int ilosc;
  String miara;
  String nazwaProduktu;
  String objectIdProduktu;
  //Grupa grupa;


  ProduktZakupy({
    this.objectId,
    this.kategoriaZakupy,
    this.ilosc,
    this.miara,
    this.nazwaProduktu,
    this.objectIdProduktu,
    //this.grupa,
  });

  ProduktZakupy.fromJson(Map<String, dynamic> json){
    objectId = json['objectId'];
    kategoriaZakupy = json['kategoriaZakupy'];
    ilosc = json['ilosc'];
    miara = json['miara'];
    nazwaProduktu = json['nazwaProduktu'];
    objectIdProduktu = json['objectIdProduktu'];
    //grupa = Grupa.fromJson(json['group']);
  }

  Map<String, dynamic> toJson() => {
    'objectId': objectId,
    'kategoriaZakupy': kategoriaZakupy,
    'ilosc' : ilosc,
    'miara' : miara,
    'nazwaProduktu': nazwaProduktu,
    'objectIdProduktu' : objectIdProduktu,
    //'group' : grupa.toJson(),
  };

} //class