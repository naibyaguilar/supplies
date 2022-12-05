import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import '../providers/providers.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'suppliesfarm.azurewebsites.net';

  final storage = FlutterSecureStorage();

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

    final resp =
        await http.post(url, headers: headers, body: json.encode(authData));
    final decodedResp = json.decode(resp.body);

    if (decodedResp != null) {
      await storage.write(key: 'id', value: decodedResp['insertId'].toString());
      await storage.write(key: 'name', value: 'Moises');

      return null;
    } else {
      return 'Usuario invalido';
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
      await storage.write(
          key: 'id', value: decodedResp[0]['id_person'].toString());
      await storage.write(
          key: 'name', value: decodedResp[0]['name'].toString());
      return null;
    } else {
      return 'Usuario invalido';
    }
  }

  Future logout() async {
    await storage.delete(key: 'id');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'id') ?? '';
  }
}
