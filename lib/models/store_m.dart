class StoreM {
  late String id;
  late int date;
  late String name;
  late String description;
  late String timings;
  late int totalOffers;
  late List<String> images;
  late List<String> users;
  late String mapLink;
  late Object location;
  late String address;
  late String province;
  late bool status;
  late bool isStore;
  late String banFor;
  late String email;
  late String ownerName;
  late String phone;

  StoreM(
      {required this.id,
      required this.date,
      required this.name,
      required this.description,
      required this.timings,
      required this.totalOffers,
      required this.images,
      required this.users,
      required this.mapLink,
      required this.location,
      required this.address,
      required this.province,
      required this.status,
      required this.isStore,
      required this.banFor,
      required this.email,
      required this.ownerName,
      required this.phone});

  StoreM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    name = json['name'];
    description = json['description'];
    timings = json['timings'];
    totalOffers = json['total_offers'];
    images = json['images'].cast<String>();
    users = json['users'].cast<String>();
    mapLink = json['mapLink'];
    location = json['location']['geopoint'];
    address = json['address'];
    province = json['province'];
    isStore = json['is_store'];
    status = json['status'];
    banFor = json['ban_for'];
    email = json['email'];
    ownerName = json['owner_name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['name'] = this.name;
    data['description'] = this.description;
    data['timings'] = this.timings;
    data['total_offers'] = this.totalOffers;
    data['images'] = this.images;
    data['users'] = this.users;
    data['mapLink'] = this.mapLink;
    data['location'] = this.location;
    data['address'] = this.address;
    data['province'] = this.province;
    data['is_store'] = this.isStore;
    data['status'] = this.status;
    data['ban_for'] = this.banFor;
    data['email'] = this.email;
    data['owner_name'] = this.ownerName;
    data['phone'] = this.phone;
    return data;
  }
}
