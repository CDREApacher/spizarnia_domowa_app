class ItemCount{

  int counted;

  ItemCount({
    this.counted,
  });

  ItemCount.fromJson(Map<String, dynamic> json) {
    counted = json['count'];
  }

  ItemCount.giveCount(Map<String, dynamic> json);

} // class ItemCount