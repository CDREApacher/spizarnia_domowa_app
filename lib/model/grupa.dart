import 'dart:convert';

class Grupa{
  //String nazwa_local;
  String nazwa_server;
  String kod_grupy;

  Grupa({
    //this.nazwa_local,
    this.nazwa_server,
    this.kod_grupy,
  });

  Grupa.fromJson(Map<String, dynamic> json){
    nazwa_server = json["name"];
    kod_grupy = json["code"];
  }

  Map<String, dynamic> toJson() => {
    'name' : nazwa_server,
    'code': kod_grupy,
  };

  
} // Grupa