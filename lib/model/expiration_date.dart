class ExpirationDate{
  DateTime exp_date;
  String id;
  String remainder_days;

  ExpirationDate({
    this.exp_date,
    this.id,
    this.remainder_days
  });

  ExpirationDate.fromJson(Map<String, dynamic> json){
    exp_date = json['date'];
    id = json['id'];
    remainder_days = json['remainderDays'];
  }

  Map<String, dynamic> toJson() => {
    'date' : exp_date,
    'id' : id,
    'remainderDays' : remainder_days,
  };

}