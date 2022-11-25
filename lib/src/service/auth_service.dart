import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supplies/src/models/models.dart';

import '../providers/providers.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'suppliesfarm.azurewebsites.net';

  Future<String?> createUser(RegisterFormProvider user) async {
    final Map<String, List<dynamic>> authData = {
      "data": [
        {"table": "users", "email": user.email, "password": user.password},
        {
          "table": "person",
          "name": user.name,
          "phone": user.phone,
          "address": user.address,
          "photo": user.photo,
          "birthday": user.birthday.toString(),
          "FK": "user_id"
        }
      ]
    };

    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final url = Uri.http(_baseUrl, '/api/supplies/both');
    log(json.encode(authData));
    final resp =
        await http.post(url, headers: headers, body: json.encode(authData));
    final decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      // Token hay que guardarlo en un lugar seguro
      //await storage.write(key: 'token', value: decodedResp['idToken']);
      // decodedResp['idToken'];
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final url = Uri.https(_baseUrl, '/api/auth');
    final resp =
        await http.post(url, headers: headers, body: json.encode(authData));
    final List<dynamic> decodedResp = json.decode(resp.body);
    //NO hay TOken asi que guardamos el ID no más
    if (decodedResp.isNotEmpty) {
      // Token hay que guardarlo en un lugar seguro
      //await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return 'Usuario invalido';
    }
  }

  Future logout() async {
    // await storage.delete(key: 'id');
    return;
  }
}
