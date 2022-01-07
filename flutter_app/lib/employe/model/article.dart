class Article {

  int id;
  int item;
  String status;
  String date;

  Article();

  void fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.item = map['item'];
    this.status = map['status'];
    this.date = map['date'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'item': this.item,
      'status': this.status,
      'date' : this.date,
    };

    if (id != null) {
      map['id'] = this.id;
    }
    return map;
  }

}