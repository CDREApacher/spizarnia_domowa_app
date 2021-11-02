import 'package:spizarnia_domowa_app/model/grupa.dart';

class Kategoria{
  String objectId;
  //String lista;
  String nazwa;
  Grupa grupa;


  Kategoria({
    this.objectId,
    this.nazwa,
    //this.lista,
    this.grupa,
});

  Kategoria.fromJson(Map<String, dynamic> json) {
    //objectId = json['objectId'];
    //nazwa = json['nazwa'];
    //lista = json['lista'];
    objectId = json['id'];
    nazwa = json['name'];
    grupa = Grupa.fromJson(json['group']);
  }

  Map<String, dynamic> toJson() => {
    //'objectId': objectId,
    //'nazwa': nazwa,
    //'lista': lista,
    'id' : objectId,
    'name' : nazwa,
    'group' : grupa.toJson(),
  };

}// class Kategoria