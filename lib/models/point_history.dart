class PointHistory {
  late int date;
  late String uid;
  late String oid;
  late String storeName;
  late String userName;
  late int total;

  PointHistory(
      {required this.date,
      required this.uid,
      required this.oid,
      required this.storeName,
      required this.userName,
      required this.total});

  PointHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    uid = json['uid'];
    oid = json['oid'];
    storeName = json['store_name'];
    userName = json['user_name'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['uid'] = this.uid;
    data['oid'] = this.oid;
    data['store_name'] = this.storeName;
    data['user_name'] = this.userName;
    data['total'] = this.total;
    return data;
  }
}
