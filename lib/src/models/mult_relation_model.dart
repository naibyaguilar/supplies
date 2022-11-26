import 'dart:convert';

class Both {
  Both({required this.data, required this.table, this.datos});

  List<dynamic> data;
  String table;
  dynamic datos;

  // factory Both.fromJson(String str) => Both.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  // factory Both.fromMap(Map<String, dynamic> json) => Both(
  //       data: List<dynamic>.from(json["data"].map((x) => Datum.fromMap(x))),
  //     );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}
