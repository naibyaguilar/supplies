import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ActivitiesService extends ChangeNotifier {
  final String _baseUrl = 'suppliesfarm.azurewebsites.net';
  final storage = const FlutterSecureStorage(); // *TODO: QUITAR

  final List<Activities> activities = [];
  bool isLoading = true;

  ActivitiesService() {
    LoadActivities();
  }

  Future<List<Activities>> LoadActivities() async {
    final Map<String, dynamic> personData = {
      "table": "activities",
      "param": "farm_id",
      "value": "2" // Cambiar
    };

    isLoading = true;

    final url = Uri.http(_baseUrl, '/api/supplies/any');
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
