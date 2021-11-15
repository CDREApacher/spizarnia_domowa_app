class Barcodes{
  String barcode_code;
  String id;
  String nazwa;

  Barcodes({
    this.barcode_code,
    this.id,
    this.nazwa
  });

  Barcodes.fromJson(Map<String, dynamic> json){
    barcode_code = json['barcode'];
    id = json['id'];
    nazwa = json['note'];
  }

  Map<String, dynamic> toJson() => {
    //'objectId': objectId,
    //'nazwa': nazwa,
    //'objectIdProdukt' : objectIdProdukt,
    'barcode' : barcode_code,
    'id' : id,
    'note' : nazwa,
  };

}