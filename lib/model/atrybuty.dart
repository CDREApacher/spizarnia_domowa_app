class Atrybuty{
  String objectId;
  String nazwa;

  Atrybuty({
    this.objectId,
    this.nazwa,
  });

  Atrybuty.fromJson(Map<String, dynamic> json){
    objectId = json['id'];
    nazwa = json['name'];
  }

  Map<String, dynamic> toJson() => {
    'id': objectId,
    'name': nazwa,
  };

} // class