import 'dart:convert';

class Consumables {
  Consumables({
    this.id,
    required this.farmId,
    required this.addBy,
    this.createdAt,
    required this.name,
    required this.type,
    required this.quantity,
    required this.expiration,
    required this.produced,
  });

  int? id;
  int farmId;
  int addBy;
  DateTime? createdAt;
  String name;
  dynamic type;
  int quantity;
  DateTime expiration;
  DateTime produced;

  factory Consumables.fromJson(String str) =>
      Consumables.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Consumables.fromMap(Map<String, dynamic> json) => Consumables(
        id: json["id"],
        farmId: json["farm_id"],
        addBy: json["add_by"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        type: json["type"],
        quantity: json["quantity"],
        expiration: DateTime.parse(json["expiration"]),
        produced: DateTime.parse(json["produced"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "farm_id": farmId,
        "add_by": addBy,
        "name": name,
        "type": type,
        "quantity": quantity,
        "expiration": expiration.toIso8601String(),
        "produced": produced.toIso8601String(),
      };
}
