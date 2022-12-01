// To parse this JSON data, do
//
//     final buildings = buildingsFromMap(jsonString);

import 'dart:convert';

class Buildings {
  Buildings({
    this.id,
    required this.funtion,
    required this.area,
    required this.latitude,
    required this.longitude,
    required this.farmId,
  });

  int? id;
  String funtion;
  double area;
  String latitude;
  String longitude;
  int farmId;

  factory Buildings.fromJson(String str) => Buildings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Buildings.fromMap(Map<String, dynamic> json) => Buildings(
        id: json["id"],
        funtion: json["funtion"],
        area: json["area"].toDouble(),
        latitude: json["latitude"],
        longitude: json["longitude"],
        farmId: json["farm_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "funtion": funtion,
        "area": area,
        "latitude": latitude,
        "longitude": longitude,
        "farm_id": farmId,
      };
}
