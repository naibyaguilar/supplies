import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ActivitiesService extends ChangeNotifier {
  final String _baseUrl = 'suppliesfarm.azurewebsites.net';
  final storage = const FlutterSecureStorage();

  bool isLoading = true;

  Future<List<Activities>> LoadActivitiesbyFarmAdmin() async {
    final Map<String, dynamic> personData = {
      "idperson": await storage.read(key: 'id')
    };
    final List<Activities> activities = [];

    isLoading = true;

    final url = Uri.http(_baseUrl, '/api/supplies/getActivitiesbyFarmAdmin');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    final resp =
        await http.post(url, headers: headers, body: json.encode(personData));

    final decodedResp = json.decode(resp.body);
    for (var i in decodedResp) {
      final temp = Activities.fromMap(i);
      activities.add(temp);
    }
    isLoading = false;
    notifyListeners();
    return activities;
  }
}
