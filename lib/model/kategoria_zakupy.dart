import 'package:spizarnia_domowa_app/model/grupa.dart';

class KategoriaZakupy {
  String objectId;
  String nazwa;
  Grupa grupa;

  KategoriaZakupy({
    this.objectId,
    this.nazwa,
    this.grupa,
  });

  KategoriaZakupy.fromJson(Map<String, dynamic> json) {
    objectId = json['id'];
    nazwa = json['name'];
    grupa = Grupa.fromJson(json['group']);
  }

  Map<String, dynamic> toJson() => {
    'id': objectId,
    'name': nazwa,
    'group' : grupa.toJson(),
  };
}