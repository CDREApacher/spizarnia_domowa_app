class Miara {
  String objectId;
  String miara;

  Miara({
    this.objectId,
    this.miara,
  });

  Miara.fromJson(Map<String, dynamic> json){
    objectId = json['objectId'];
    miara = json['nazwa'];
  }

  Map<String, dynamic> toJson() => {
    'objectId' : objectId,
    'nazwa' : miara,
  };

} // class Miara