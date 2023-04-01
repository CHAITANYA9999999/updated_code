class ServiceM {
  late int date;
  late String id;
  late String sid;
  late String name;
  late String description;
  late String timings;
  late List<String> images;
  late int doIt;
  late int getIt;
  late int limit;
  late double price;
  late bool punch;
  late String endDate;
  late Object location;
  late bool status;
  late bool isService;
  late String banFor;
  late String storeName;

  ServiceM(
      {required this.date,
      required this.id,
      required this.sid,
      required this.name,
      required this.description,
      required this.timings,
      required this.images,
      required this.doIt,
      required this.getIt,
      required this.limit,
      required this.price,
      required this.punch,
      required this.endDate,
      required this.location,
      required this.isService,
      required this.status,
      required this.banFor,
      required this.storeName});

  ServiceM.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    id = json['id'];
    sid = json['sid'];
    name = json['name'];
    description = json['description'];
    timings = json['timings'];
    images = json['images'].cast<String>();
    doIt = json['do_it'];
    getIt = json['get_it'];
    limit = json['limit'];
    price = json['price'].toDouble();
    punch = json['punch'];
    endDate = json['endDate'];
    location = json['location']['geopoint'];
    isService = json['is_service'];
    status = json['status'];
    banFor = json['ban_for'];
    storeName = json['owner_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['id'] = this.id;
    data['sid'] = this.sid;
    data['name'] = this.name;
    data['description'] = this.description;
    data['timings'] = this.timings;
    data['images'] = this.images;
    data['do_it'] = this.doIt;
    data['get_it'] = this.getIt;
    data['limit'] = this.limit;
    data['price'] = this.price;
    data['punch'] = this.punch;
    data['endDate'] = this.endDate;
    data['location'] = this.location;
    data['is_service'] = this.isService;
    data['status'] = this.status;
    data['ban_for'] = this.banFor;
    data['owner_name'] = this.storeName;
    return data;
  }
}
