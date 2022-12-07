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

  final int initialForm = 0;

  bool isLoading = true;
  List<String> listtype = <String>[
    'Actividad',
    'Insumos',
    'Animales',
    'Edificios'
  ];
  List<String> listtemp = [
    "Miguel Angel",
    "Jaime Sanchez",
    "ana gabriela",
    "Mario Ballina"
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
    final Map<String, dynamic> actmData = {
      "table": "activities",
      "values": [
        {
          "farm_id": 2,
          "add_by": await storage.read(key: 'id'),
          "name": activity.nameActivitie,
          "description": activity.description,
          "note": activity.note,
          "execution_date": '2022-11-29 11:35:00',
          "redo": activity.redo,
          "period": activity.period,
          "employee_id": 9,
          "directedTo": activity.directedTo,
          "type": activity.type,
          "active": activity.active
        }
      ]
    };

    final url = Uri.http(_baseUrl, '/api/supplies/');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final resp =
        await http.post(url, headers: headers, body: json.encode(actmData));
    final decodedData = json.decode(resp.body);

    activity.idActivitie = decodedData['insertId'];

    activities.add(activity);

    return activity.idActivitie;
  }

  createAnimal(Animals animal) async {
    final Map<String, List<dynamic>> animalData = {
      "data": [
        {
          "table": "group_animals",
          "quantity": animal.quantity,
          "name_group": animal.nameGroup,
          "add_by": 12,
          "farm_id": 2
        },
        {
          "table": "animals",
          "id": 1,
          "birthday": "2022-01-18",
          "breed": animal.breed,
          "weight": 20.5,
          "FK": "group_id"
        }
      ]
    };

    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final url = Uri.http(_baseUrl, '/api/supplies/both');

    final resp =
        await http.post(url, headers: headers, body: json.encode(animalData));
    final decodedResp = json.decode(resp.body);
  }

  createBuilding(Buildings buil) async {
    final Map<String, dynamic> buildingData = {
      "table": "buildings",
      "values": [
        {
          "funtion": buil.funtion,
          "area": buil.area,
          "latitude": 20.885680,
          "longitude": -89.652740,
          "farm_id": 2
        }
      ]
    };
    final url = Uri.http(_baseUrl, '/api/supplies/');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final resp =
        await http.post(url, headers: headers, body: json.encode(buildingData));
    final decodedData = json.decode(resp.body);

    buil.id = decodedData['insertId'];
  }

  createConsumables(Consumables consu) async {
    final Map<String, dynamic> consugData = {
      "table": "consumables",
      "values": [
        {
          "farm_id": 1,
          "add_by": 1,
          "name": consu.name,
          "quantity": consu.quantity,
          "expiration": "2023-01-05 12:00:00",
          "produced": "2022-10-12 12:00:00"
        }
      ]
    };
    final url = Uri.http(_baseUrl, '/api/supplies/');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final resp =
        await http.post(url, headers: headers, body: json.encode(consugData));
    final decodedData = json.decode(resp.body);

    consu.id = decodedData['insertId'];
  }
}
