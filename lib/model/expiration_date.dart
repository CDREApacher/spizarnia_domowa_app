class ExpirationDate{
  String nazwa;
  String exp_date;
  String id;
  int remainder_days;

  ExpirationDate({
    this.nazwa,
    this.exp_date,
    this.id,
    this.remainder_days
  });

  ExpirationDate.fromJson(Map<String, dynamic> json){
    exp_date = json['date'];
    id = json['id'];
    remainder_days = json['remainderDays'];
    nazwa = json['note'];
  }

  Map<String, dynamic> toJson() => {
    'date' : exp_date,
    'id' : id,
    'remainderDays' : remainder_days,
    'note' : nazwa,
  };

}