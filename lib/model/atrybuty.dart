class Atrybuty{
  String objectId;
  String nazwa;
  //String objectIdProdukt;

  Atrybuty({
    this.objectId,
    this.nazwa,
    //this.objectIdProdukt,
  });

  Atrybuty.fromJson(Map<String, dynamic> json){
    //objectId = json['objectId'];
    //nazwa = json['nazwa'];
    //objectIdProdukt = json['objectIdProdukt'];
    objectId = json["id"];
    nazwa = json['name'];
  }

  Map<String, dynamic> toJson() => {
    //'objectId': objectId,
    //'nazwa': nazwa,
    //'objectIdProdukt' : objectIdProdukt,
    'id' : objectId,
    'name' : nazwa,
  };

} // class