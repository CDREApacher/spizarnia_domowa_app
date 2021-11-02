import 'package:spizarnia_domowa_app/model/grupa.dart';

class Miara {
  String objectId;
  String miara;
  Grupa grupa;

  Miara({
    this.objectId,
    this.miara,
    this.grupa,
  });

  Miara.fromJson(Map<String, dynamic> json){
    //objectId = json['objectId'];
    //miara = json['nazwa'];
    objectId = json['id'];
    miara = json['name'];
    grupa = Grupa.fromJson(json['group']);
  }

  Map<String, dynamic> toJson() => {
    //'objectId' : objectId,
    //'nazwa' : miara,
    'id' : objectId,
    'name' : miara,
    'group' : grupa.toJson(),
  };

} // class Miara