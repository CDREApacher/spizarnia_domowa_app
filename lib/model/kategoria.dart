class Kategoria{
  String objectId;
  String lista;
  String nazwa;

  Kategoria({
    this.objectId,
    this.nazwa,
    this.lista,
});

  Kategoria.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    nazwa = json['nazwa'];
    lista = json['lista'];
  }

  Map<String, dynamic> toJson() => {
    'objectId': objectId,
    'nazwa': nazwa,
    'lista': lista,
  };

}// class Kategoria