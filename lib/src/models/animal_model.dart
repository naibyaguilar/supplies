import 'dart:convert';

class Animals {
  Animals(
      {this.id,
      required this.quantity,
      required this.nameGroup,
      required this.addBy,
      required this.farmId,
      required this.birthday,
      required this.breed,
      required this.weight});

  int? id;
  int quantity;
  String nameGroup;
  int addBy;
  int farmId;
  DateTime birthday;
  int breed;
  double weight;

  factory Animals.fromJson(String str) => Animals.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Animals.fromMap(Map<String, dynamic> json) => Animals(
      id: json["id"],
      quantity: json["quantity"],
      nameGroup: json["name_group"],
      addBy: json["add_by"],
      farmId: json["farm_id"],
      birthday: DateTime.parse(json["birthday"]),
      breed: json["breed"],
      weight: json["weight"].toDouble());

  Map<String, dynamic> toMap() => {
        "id": id,
        "quantity": quantity,
        "name_group": nameGroup,
        "add_by": addBy,
        "farm_id": farmId,
        "birthday":
            "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "breed": breed,
        "weight": weight
      };
}
