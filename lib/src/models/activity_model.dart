import 'dart:convert';
import 'package:intl/intl.dart';

class Activities {
  Activities({
    this.id,
    required this.farmId,
    required this.addBy,
    required this.createdAt,
    required this.name,
    required this.description,
    this.note,
    required this.executionDate,
    required this.redo,
    this.period,
    required this.employeeId,
    this.directedTo,
    this.type,
    required this.active,
  });

  int? id;
  int farmId;
  int addBy;
  DateTime createdAt;
  String name;
  String description;
  String? note;
  DateTime executionDate;
  int redo;
  int? period;
  int employeeId;
  int? directedTo;
  String? type;
  int active;

  factory Activities.fromJson(String str) =>
      Activities.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Activities.fromMap(dynamic json) => Activities(
        id: json["id"],
        farmId: json["farm_id"],
        addBy: json["add_by"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
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
        "id": id,
        "farm_id": farmId,
        "add_by": addBy,
        "created_at": createdAt.toIso8601String(),
        "name": name,
        "description": description,
        "note": note,
        "execution_date": executionDate.toIso8601String(),
        "redo": redo,
        "period": period,
        "employee_id": employeeId,
        "directedTo": directedTo,
        "type": type,
        "active": active,
      };

  sDateTimeFormatInfo() {
    return DateFormat.yMMMMEEEEd().add_jms().format(this.executionDate);
  }

  sType() {
    switch (this.type) {
      case 'group':
        return 'Animales';
      case 'consumables':
        return 'Insumos';
      case 'buildings':
        return 'Estructuras';
      default:
        return 'Pendientes';
    }
  }
}
