class UserM {
  late int date;
  late String id;
  late String token;
  late String image;
  late String name;
  late String email;
  late String phone;
  late String banFor;

  UserM(
      {required this.date,
      required this.token,
      required this.image,
      required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.banFor});

  UserM.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    id = json['id'];
    token = json['token'];
    image = json['image'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    banFor = json['ban_for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['id'] = this.id;
    data['token'] = this.token;
    data['image'] = this.image;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['ban_for'] = this.banFor;
    return data;
  }
}
