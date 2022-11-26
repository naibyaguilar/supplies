import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supplies/src/models/models.dart';
import 'package:http/http.dart' as http;

class PersonaService extends ChangeNotifier {
  final String _baseUrl = 'suppliesfarm.azurewebsites.net';
  final storage = const FlutterSecureStorage();
  final List<Person> person = [];
  final List<Users> user = [];
  bool isLoading = true;

  PersonaService() {
    loadPerson();
    loadUser();
  }

  Future<List<Person>> loadPerson() async {
    final Map<String, dynamic> personData = {
      "table": "person",
      "param": "user_id",
      "value": await storage.read(key: 'id')
    };

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

  Future<List<Users>> loadUser() async {
    final Map<String, dynamic> personData = {
      "table": "users",
      "param": "id",
      "value": "49 " //await storage.read(key: 'id')
    };
    String id = await storage.read(key: 'id') as String;
    log(id);

    try {
      isLoading = true;
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
}
