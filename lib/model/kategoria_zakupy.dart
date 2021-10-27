class KategoriaZakupy {
  String objectId;
  String nazwa;

  KategoriaZakupy({
    this.objectId,
    this.nazwa,
  });

  KategoriaZakupy.fromJson(Map<String, dynamic> json) {
    objectId = json['id'];
    nazwa = json['name'];
  }

  Map<String, dynamic> toJson() => {
    'id': objectId,
    'name': nazwa,
  };
}