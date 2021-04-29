class Produkt {
  String id;
  String nazwa;
  int ilosc;

  Produkt({
    this.id,
    this.nazwa,
    this.ilosc
  });

  Produkt.fromJson(Map<String, dynamic> json){
    id = json['objectId'];
    nazwa = json['nazwa'];
    ilosc = json['ilosc'];
  }

  Map<String, dynamic> toJson() => {
    'objectId': id,
    'nazwa': nazwa,
    'ilosc' : ilosc,
  };

}// class Produkt