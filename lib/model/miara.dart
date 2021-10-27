class Miara {
  String objectId;
  String miara;

  Miara({
    this.objectId,
    this.miara,
  });

  Miara.fromJson(Map<String, dynamic> json){
    //objectId = json['objectId'];
    //miara = json['nazwa'];
    objectId = json['id'];
    miara = json['name'];
  }

  Map<String, dynamic> toJson() => {
    //'objectId' : objectId,
    //'nazwa' : miara,
    'id' : objectId,
    'name' : miara,
  };

} // class Miara