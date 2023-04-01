class OfferHistory {
  late int date;
  late String image;
  late String offerName;
  late int doIt;
  late String uid;
  late String sid;
  late String userName;
  late List<int> lapse;
  late int total;

  OfferHistory(
      {required this.date,
      required this.image,
      required this.offerName,
      required this.doIt,
      required this.uid,
      required this.sid,
      required this.userName,
      required this.lapse,
      required this.total});

  OfferHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    image = json['image'];
    offerName = json['offer_name'];
    doIt = json['do_it'];
    uid = json['uid'];
    sid = json['sid'];
    userName = json['user_name'];
    lapse = json['lapse'].cast<int>();
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['image'] = this.image;
    data['offer_name'] = this.offerName;
    data['do_it'] = this.doIt;
    data['uid'] = this.uid;
    data['sid'] = this.sid;
    data['user_name'] = this.userName;
    data['lapse'] = this.lapse;
    data['total'] = this.total;
    return data;
  }
}
