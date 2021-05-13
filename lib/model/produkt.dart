/*
class Produkt {
  String id;
  String nazwa;
  int ilosc;
  String rodzaj;


  Produkt({
    this.id,
    this.nazwa,
    this.ilosc,
    this.rodzaj
  });

  Produkt.fromJson(Map<String, dynamic> json){
    id = json['objectId'];
    nazwa = json['nazwa'];
    ilosc = json['ilosc'];
    rodzaj = json['rodzaj_ilosc'];
  }

  Map<String, dynamic> toJson() => {
    'objectId': id,
    'nazwa': nazwa,
    'ilosc' : ilosc,
    'rodzaj_ilosc' : rodzaj,
  };



}// class Produkt
*/

class Produkt {
  String objectId;
  String nazwaProduktu;
  int ilosc;
  String miara;
  int progAutoZakupu;
  bool autoZakup;
  String kategorieZakupy;
  String kategorieProdukty;


  Produkt({
    this.objectId,
    this.nazwaProduktu,
    this.ilosc,
    this.miara,
    this.progAutoZakupu,
    this.autoZakup,
    this.kategorieProdukty,
    this.kategorieZakupy,
  });

  Produkt.fromJson(Map<String, dynamic> json){
    objectId = json['objectId'];
    nazwaProduktu = json['nazwaProduktu'];
    ilosc = json['ilosc'];
    miara = json['miara'];
    progAutoZakupu = json['progAutoZakupu'];
    autoZakup = json['autoZakup'];
    kategorieProdukty = json['kategorieProdukty'];
    kategorieZakupy = json['kategorieZakupy'];
  }

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



}// class Produkt
