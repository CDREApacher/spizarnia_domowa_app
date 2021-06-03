class Kategoria{
  String objectId;
  String nazwa;

  Kategoria({
    this.objectId,
    this.nazwa,
});

  Kategoria.fromJson(Map<String, dynamic> json) {
    objectId = json['id'];
    nazwa = json['name'];
  }

  Map<String, dynamic> toJson() => {
    'id': objectId,
    'name': nazwa,
  };

}// class Kategoria