class RequestM {
  late int date;
  late String id;
  late String uid;
  late String userName;
  late String oid;
  late String storeName;
  late String sid;
  late String serviceName;
  late int doIt;
  late int getIt;
  late double price;
  late bool punch;
  late bool status;

  RequestM(
      {required this.date,
      required this.id,
      required this.uid,
      required this.userName,
      required this.sid,
      required this.storeName,
      required this.oid,
      required this.serviceName,
      required this.doIt,
      required this.getIt,
      required this.price,
      required this.punch,
      required this.status});

  RequestM.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    id = json['id'];
    uid = json['uid'];
    userName = json['user_name'];
    sid = json['sid'];
    storeName = json['store_name'];
    oid = json['oid'];
    serviceName = json['service_name'];
    doIt = json['doIt'];
    getIt = json['getIt'];
    price = json['price'].toDouble();
    punch = json['punch'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['user_name'] = this.userName;
    data['sid'] = this.sid;
    data['store_name'] = this.storeName;
    data['oid'] = this.oid;
    data['service_name'] = this.serviceName;
    data['doIt'] = this.doIt;
    data['getIt'] = this.getIt;
    data['price'] = this.price;
    data['punch'] = this.punch;
    data['status'] = this.status;
    return data;
  }
}
