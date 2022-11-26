// To parse this JSON data, do
//
//     final users = usersFromMap(jsonString);

import 'dart:convert';

class Data {
  Data({
    required this.data,
    required this.user,
    required this.person,
  });

  Map<String, List<dynamic>> data;
  Users user;
  Person person;
/**
 * List<Word> temp = jsonMap['data'] 
    .map((map) => map as Map<String, dynamic>)  
    .map((Map<String, dynamic> map) => Word.fromJson(map)).toList(); //
 */
  // String toJson() => json.encode(toMap());

  // Map<String, dynamic> toMap() => {
  //       "data": List<dynamic>.from(data.map((x) => x.toMap())),
  //     };
}

class Users {
  Users({
    this.id,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  int? id;
  String email;
  String password;
  DateTime createdAt;

  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "password": password,
        "created_at": createdAt.toIso8601String(),
      };
}

class Person {
  Person({
    this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.address,
    this.photo,
    required this.birthday,
  });

  int? id;
  int userId;
  String name;
  String phone;
  String address;
  dynamic photo;
  DateTime birthday;

  factory Person.fromJson(String str) => Person.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        photo: json["photo"],
        birthday: DateTime.parse(json["birthday"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone": phone,
        "address": address,
        "photo": photo,
        "birthday": birthday.toIso8601String(),
      };
}
