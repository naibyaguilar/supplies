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
    this.latitude,
    this.longitude,
    required this.type,
    this.createdAt,
    required this.adminId,
  });

  int? id;
  String name;
  double area;
  String address;
  String? latitude;
  String? longitude;
  String type;
  DateTime? createdAt;
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
  factory Farm.fromEmployeeMap(dynamic json) => Farm(
        id: json["id_farm"],
        name: json["name_farm"],
        area: json["area"].toDouble(),
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        adminId: 1,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "area": area,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "type": type,
        "created_at": createdAt,
        "admin_id": adminId,
      };
  Map<String, dynamic> toMapDelete() => {
        "table": "farm",
        "values": [
          {
            "id": id,
          }
        ]
      };
}

class Employees {
  Employees({
    this.idPerson,
    this.nombrePersona,
  });

  int? idPerson;
  String? nombrePersona;

  factory Employees.fromJson(String str) => Employees.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Employees.fromMap(Map<String, dynamic> json) => Employees(
        idPerson: json["id_person"],
        nombrePersona: json["nombre_persona"],
      );

  Map<String, dynamic> toMap() => {
        "id_person": idPerson,
        "nombre_persona": nombrePersona,
      };
}
