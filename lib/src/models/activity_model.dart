// To parse this JSON data, do
//
//     final activities = activitiesFromMap(jsonString);

import 'dart:convert';

class Activities {
  Activities({
    this.idFarm,
    this.nameFarm,
    this.idActivitie,
    required this.addBy,
    required this.createdAt,
    required this.nameActivitie,
    required this.description,
    required this.note,
    required this.executionDate,
    required this.redo,
    required this.period,
    this.employeeName,
    this.employeeId,
    required this.directedTo,
    required this.type,
    required this.active,
  });

  int? idFarm;
  String? nameFarm;
  int? idActivitie;
  int addBy;
  DateTime createdAt;
  String nameActivitie;
  String description;
  String note;
  DateTime executionDate;
  int redo;
  int period;
  String? employeeName;
  int? employeeId;
  int directedTo;
  String type;
  int active;

  factory Activities.fromJson(String str) =>
      Activities.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
  String toJsoUpdaten() => json.encode(toMapUpdate());

  factory Activities.fromMap(Map<String, dynamic> json) => Activities(
        idFarm: json["id_farm"],
        nameFarm: json["name_farm"],
        idActivitie: json["id_activitie"],
        addBy: json["add_by"],
        createdAt: DateTime.parse(json["created_at"]),
        nameActivitie: json["name_activitie"],
        description: json["description"],
        note: json["note"],
        executionDate: DateTime.parse(json["execution_date"]),
        redo: json["redo"],
        period: json["period"],
        employeeName: json["employee_name"],
        directedTo: json["directedTo"],
        type: json["type"],
        active: json["active"],
      );
  factory Activities.fromMapMyActivitie(Map<String, dynamic> json) =>
      Activities(
        idActivitie: json["id"],
        idFarm: json["farm_id"],
        addBy: json["add_by"],
        createdAt: DateTime.parse(json["created_at"]),
        nameActivitie: json["name"],
        description: json["description"],
        note: json["note"],
        executionDate: DateTime.parse(json["execution_date"]),
        redo: json["redo"],
        period: json["period"],
        employeeId: json["employee_id"],
        directedTo: json["directedTo"],
        type: json["type"],
        active: json["active"],
      );

  Map<String, dynamic> toMap() => {
        "id_farm": idFarm,
        "name_farm": nameFarm,
        "id_activitie": idActivitie,
        "add_by": addBy,
        "created_at": createdAt.toIso8601String(),
        "name_activitie": nameActivitie,
        "description": description,
        "note": note,
        "execution_date": executionDate.toIso8601String(),
        "redo": redo,
        "period": period,
        "employee_name": employeeName,
        "directedTo": directedTo,
        "type": type,
        "active": active,
      };
  Map<String, dynamic> toMapUpdate() => {
        "table": "activities",
        "values": [
          {
            "id": idActivitie,
            "active": active,
          }
        ]
      };
}
