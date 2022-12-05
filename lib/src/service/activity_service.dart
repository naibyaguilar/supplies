import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ActivitiesService extends ChangeNotifier {
  final String _baseUrl = 'suppliesfarm.azurewebsites.net';
  final storage = const FlutterSecureStorage();

  bool isLoading = true;
  List<String> listtype = <String>[
    'Actividad',
    'Insumos',
    'Animales',
    'Edificios'
  ];

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
      if (temp.active != 1) {
        activities.add(temp);
      }
    }
    isLoading = false;
    notifyListeners();
    return activities;
  }

  Future<List<Activities>> LoadMyActivities() async {
    final Map<String, dynamic> myActivitiesData = {
      "table": "activities",
      "param": "employee_id",
      "value": await storage.read(key: 'id')
    };
    final List<Activities> myactivities = [];

    isLoading = true;

    final url = Uri.http(_baseUrl, '/api/supplies/any');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    final resp = await http.post(url,
        headers: headers, body: json.encode(myActivitiesData));

    final decodedResp = json.decode(resp.body);
    for (var i in decodedResp) {
      final temp = Activities.fromMapMyActivitie(i);
      if (temp.active != 1) {
        myactivities.add(temp);
      }
    }
    isLoading = false;
    notifyListeners();
    return myactivities;
  }

  Future saveOrCreateActivity(Activities activities) async {
    notifyListeners();

    if (activities.idActivitie == null) {
      // Es necesario crear
      await createActivity(activities);
    } else {
      // Actualizar
      await updateFarm(activities);
    }
    notifyListeners();
  }

  Future<int?> updateFarm(Activities activitie) async {
    // final List<Activities> activities = [];
    final url = Uri.http(_baseUrl, '/api/supplies');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    log(activitie.toJsoUpdaten());
    final resp =
        await http.put(url, headers: headers, body: activitie.toJsoUpdaten());
    final decodedData = resp.body;
    if (decodedData.isNotEmpty) {
      return null;
    } else {
      return 1;
    }
  }

  Future<int?> createActivity(Activities activity) async {
    final List<Activities> activities = [];
    final Map<String, dynamic> farmData = {
      "table": "farm",
      "values": [
        {
          "farm_id": activity.idFarm,
          "add_by": await storage.read(key: 'id'),
          "name": activity.nameActivitie,
          "description": activity.description,
          "note": activity.note,
          "execution_date": activity.executionDate,
          "redo": activity.redo,
          "period": activity.period,
          "employee_id": activity.employeeName,
          "directedTo": activity.directedTo,
          "type": activity.type,
          "active": activity.active
        }
      ]
    };

    final url = Uri.http(_baseUrl, '/api/supplies/');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final resp =
        await http.post(url, headers: headers, body: json.encode(farmData));
    final decodedData = json.decode(resp.body);

    activity.idActivitie = decodedData['insertId'];

    activities.add(activity);

    return activity.idActivitie;
  }
}
