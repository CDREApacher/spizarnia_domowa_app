class Kategoria{
  String objectId;
  //String lista;
  String nazwa;

  Kategoria({
    this.objectId,
    this.nazwa,
    //this.lista,
});

  Kategoria.fromJson(Map<String, dynamic> json) {
    //objectId = json['objectId'];
    //nazwa = json['nazwa'];
    //lista = json['lista'];
    objectId = json['id'];
    nazwa = json['name'];
  }

  Map<String, dynamic> toJson() => {
    //'objectId': objectId,
    //'nazwa': nazwa,
    //'lista': lista,
    'id' : objectId,
    'name' : nazwa,
  };

}// class Kategoria