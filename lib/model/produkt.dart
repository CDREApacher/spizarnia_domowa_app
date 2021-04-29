class Produkt {
  int id;
  String nazwa;

  Produkt({
    this.id,
    this.nazwa
  });

  Produkt.fromJson(Map<String, dynamic> json){
    id = json['ID'];
    nazwa = json['Nazwa'];
  }

  Map<String, dynamic> toJson() => {
    'ID': id,
    'Nazwa': nazwa,
  };

}// class Produkt