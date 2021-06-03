class Miara {
  String objectId;
  String miara;

  Miara({
    this.objectId,
    this.miara,
  });

  Miara.fromJson(Map<String, dynamic> json){
    objectId = json['id'];
    miara = json['name'];
  }

  Map<String, dynamic> toJson() => {
    'id' : objectId,
    'name' : miara,
  };

} // class Miara