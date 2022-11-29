import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class FarmService extends ChangeNotifier {
  final String _baseUrl = 'suppliesfarm.azurewebsites.net';
  final storage = const FlutterSecureStorage();

  final List<Farm> farms = [];
  late Farm selectedfarm;

  List<String> listtype = <String>[
    'Agricola',
    'Agropecuario',
    'Avícolas',
    'Diferentes usos',
    'Ganadero',
    'Pecuario',
    'Porcícolas',
    'Orgánica'
  ];

  bool isLoading = true;
  bool isSaving = false;

  FarmService() {
    LoadFarm();
  }

  Future<List<Farm>> LoadFarm() async {
    try {
      isLoading = true;

      final url = Uri.http(_baseUrl, '/api/supplies/farm',
          {'key': 'Content-Type', 'value': 'application/json'});
      final resp = await http.get(url);

      final decodedResp = json.decode(resp.body);
      for (var i in decodedResp) {
        final temp = Farm.fromMap(i);
        farms.add(temp);
      }
      isLoading = false;
      notifyListeners();

      return farms;
    } catch (e) {
      return farms;
    }
  }

  Future saveOrCreateFarm(Farm farm) async {
    isSaving = true;
    notifyListeners();

    if (farm.id == null) {
      // Es necesario crear
      await this.createFarm(farm);
    } else {
      // Actualizar
      await this.updateFarm(farm);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<int?> updateFarm(Farm farm) async {
    final url = Uri.http(_baseUrl, '/api/supplies/');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    final resp = await http.put(url, headers: headers, body: farm.toJson());
    final decodedData = resp.body;

    final index = this.farms.indexWhere((element) => element.id == farm.id);
    this.farms[index] = farm;

    return farm.id!;
  }

  Future<int?> createFarm(Farm farm) async {
    final Map<String, dynamic> farmData = {
      "table": "farm",
      "values": [
        {
          "name": farm.name,
          "area": farm.area,
          "address": farm.address,
          "latitude": 20.885680,
          "longitude": -89.652740,
          "type": farm.type,
          "admin_id": await storage.read(key: 'id')
        }
      ]
    };

    final url = Uri.http(_baseUrl, '/api/supplies/');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    log(json.encode(farmData));
    final resp =
        await http.post(url, headers: headers, body: json.encode(farmData));
    final decodedData = json.decode(resp.body);

    farm.id = decodedData['insertId'];

    this.farms.add(farm);

    return farm.id;
  }
}
