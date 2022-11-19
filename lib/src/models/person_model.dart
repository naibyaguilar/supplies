import 'dart:convert';

class Person {
  int id;
  int userId;
  String name;
  String phone;
  String address;
  String photo;
  String birthday;

  Person({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.address,
    required this.photo,
    required this.birthday,
  });

  factory Person.fromJson(String str) => Person.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Person.fromMap(Map<String, dynamic> json) => Person(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      photo: json['photo'],
      birthday: json['brithday']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'name': name,
        'phone': phone,
        'address': address,
        'photo': photo,
        'brithday': birthday,
      };

  Person copy() => Person(
      id: id,
      userId: userId,
      name: name,
      phone: phone,
      address: address,
      photo: phone,
      birthday: birthday);
}
