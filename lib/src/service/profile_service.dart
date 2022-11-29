import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supplies/src/models/models.dart';
import 'package:http/http.dart' as http;

class ProfileService extends ChangeNotifier {
  final String _baseUrl = 'suppliesfarm.azurewebsites.net';
  final storage = const FlutterSecureStorage();
  final List<Person> person = [];
  final List<Users> user = [];
  late Farm selectedFarm;

  bool isLoading = true;

  ProfileService() {
    loadPerson();
    loadUser();
  }

  Future<List<Person>> loadPerson() async {
    final Map<String, dynamic> personData = {
      "table": "person",
      "param": "id",
      "value": await storage.read(key: 'id')
    };

    try {
      isLoading = true;

      notifyListeners();
      final url = Uri.http(_baseUrl, '/api/supplies/any');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

      final resp =
          await http.post(url, headers: headers, body: json.encode(personData));

      final decodedResp = json.decode(resp.body);

      for (var i in decodedResp) {
        final temp = Person.fromMap(i);
        person.add(temp);
      }

      isLoading = false;
      notifyListeners();

      return person;
    } catch (e) {
      return person;
    }
  }

  Future<List<Users>> loadUser() async {
    final Map<String, dynamic> personData = {
      "table": "users",
      "param": "id",
      "value": "49 " //await storage.read(key: 'id')
    };

    try {
      isLoading = true;

      notifyListeners();
      final url = Uri.http(_baseUrl, '/api/supplies/any');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

      final resp =
          await http.post(url, headers: headers, body: json.encode(personData));

      final decodedResp = json.decode(resp.body);

      for (var i in decodedResp) {
        final temp = Users.fromMap(i);
        user.add(temp);
      }

      isLoading = false;
      notifyListeners();

      return user;
    } catch (e) {
      return user;
    }
  }

  Future<List<Farm?>> getMyFarm() async {
    final Map<String, dynamic> idData = {
      "table": "farm",
      "param": "admin_id",
      "value": await storage.read(key: 'id')
    };

    final List<Farm?> farms = [];
    try {
      isLoading = true;
      // notifyListeners();

      final url = Uri.http(_baseUrl, '/api/supplies/any');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

      final resp =
          await http.post(url, headers: headers, body: json.encode(idData));

      final decodedResp = json.decode(resp.body);
      for (var i in decodedResp) {
        final temp = Farm.fromMap(i);
        if ((farms.firstWhere((item) => item?.id == temp.id,
                orElse: () => null)) !=
            null) {
        } else {
          farms.add(temp);
        }
      }
      isLoading = false;
      notifyListeners();

      return farms;
    } catch (e) {
      return farms;
    }
  }

  Future<List<Person>> GetMember(int id) async {
    final Map<String, dynamic> personData = {
      "table": "employees",
      "param": "farm_id",
      "value": id
    };

    List<Person> person = [];
    try {
      isLoading = true;

      final url = Uri.http(_baseUrl, '/api/supplies/any');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

      final resp =
          await http.post(url, headers: headers, body: json.encode(personData));

      final decodedResp = json.decode(resp.body);

      for (var i in decodedResp) {
        final temp = Person.fromMap(i);
        person.add(temp);
      }

      isLoading = false;
      notifyListeners();

      return person;
    } catch (e) {
      return person;
    }
  }
}
