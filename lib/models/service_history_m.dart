class ServiceHistoryM {
  late String uid;
  late String userName;
  late int times;
  late List<int> lapse;

  ServiceHistoryM({
    required this.uid,
    required this.userName,
    required this.times,
    required this.lapse,
  });

  ServiceHistoryM.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    userName = json['user_name'];
    times = json['times'];
    lapse = json['lapse'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['user_name'] = this.userName;
    data['times'] = this.times;
    data['lapse'] = this.lapse;
    return data;
  }
}
