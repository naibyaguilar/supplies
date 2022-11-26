// To parse this JSON data, do
//
//     final farm = farmFromMap(jsonString);

import 'dart:convert';

class Farm {
  Farm({
    this.id,
    required this.name,
    required this.area,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.createdAt,
    required this.adminId,
  });

  int? id;
  String name;
  double area;
  String address;
  String? latitude;
  String? longitude;
  String type;
  DateTime createdAt;
  int adminId;

  factory Farm.fromJson(String str) => Farm.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Farm.fromMap(dynamic json) => Farm(
        id: json["id"],
        name: json["name"],
        area: json["area"].toDouble(),
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        adminId: json["admin_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "area": area,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "type": type,
        "created_at": createdAt.toIso8601String(),
        "admin_id": adminId,
      };
}