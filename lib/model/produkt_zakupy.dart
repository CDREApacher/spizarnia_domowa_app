class ProduktZakupy {

  String objectId;
  String kategoriaZakupy;
  int ilosc;
  String miara;
  String nazwaProduktu;
  String objectIdProduktu;

  ProduktZakupy({
    this.objectId,
    this.kategoriaZakupy,
    this.ilosc,
    this.miara,
    this.nazwaProduktu,
    this.objectIdProduktu,
  });

  ProduktZakupy.fromJson(Map<String, dynamic> json){
    objectId = json['objectId'];
    kategoriaZakupy = json['kategoriaZakupy'];
    ilosc = json['ilosc'];
    miara = json['miara'];
    nazwaProduktu = json['nazwaProduktu'];
    objectIdProduktu = json['objectIdProduktu'];

  }

  Map<String, dynamic> toJson() => {
    'objectId': objectId,
    'kategoriaZakupy': kategoriaZakupy,
    'ilosc' : ilosc,
    'miara' : miara,
    'nazwaProduktu': nazwaProduktu,
    'objectIdProduktu' : objectIdProduktu,
  };

} //class