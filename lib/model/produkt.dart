class Produkt {
  String id;
  String nazwa;
  int ilosc;
  String rodzaj;


  Produkt({
    this.id,
    this.nazwa,
    this.ilosc,
    this.rodzaj
  });

  Produkt.fromJson(Map<String, dynamic> json){
    id = json['objectId'];
    nazwa = json['nazwa'];
    ilosc = json['ilosc'];
    rodzaj = json['rodzaj_ilosc'];
  }

  Map<String, dynamic> toJson() => {
    'objectId': id,
    'nazwa': nazwa,
    'ilosc' : ilosc,
    'rodzaj_ilosc' : rodzaj,
  };

}// class Produkt