import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ActivitiesService extends ChangeNotifier {
  final String _baseUrl = 'suppliesfarm.azurewebsites.net';

  final List<Activities> activities = [];
  bool isLoading = true;

  ActivitiesService() {
    LoadActivities();
  }

  Future<List<Activities>> LoadActivities() async {
    isLoading = true;

    final url = Uri.http(_baseUrl, '/api/supplies/activities',
        {'key': 'Content-Type', 'value': 'application/json'});
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    for (var i in decodedResp) {
      final temp = Activities.fromMap(i);
      activities.add(temp);
    }
    print(activities[0].name);
    isLoading = false;
    notifyListeners();
    return activities;
  }
}
