import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class FarmService extends ChangeNotifier {
  final String _baseUrl = 'suppliesfarm.azurewebsites.net';
  final List<Farm> farms = [];
  bool isLoading = true;

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
        this.farms.add(temp);
      }
      isLoading = false;
      notifyListeners();

      return farms;
    } catch (e) {
      return farms;
    }
  }
}
