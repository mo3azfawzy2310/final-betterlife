import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _displayName;

  String? get token => _token;
  String? get displayName => _displayName;

  Future<bool> register(String displayName, String email, String password,
      String phoneNumber, String userName) async {
    final url = Uri.parse("http://betterlife.runasp.net/api/Authentication/Register");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "displayName": displayName,
          "email": email,
          "password": password,
          "phoneNumber": phoneNumber,
          "userName": userName,
          "role": "Patient"
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Registration exception: $e");
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final url = Uri.parse("https://betterlife.runasp.net/api/Authentication/Login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
          "role": "Patient"
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        _token = json['token'];
        _displayName = json['displayName'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        await prefs.setString('displayName', _displayName!);

        notifyListeners();
        return true;
      } else {
        print("Login failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Login exception: $e");
      return false;
    }
  }

  Future<void> logout() async {
    _token = null;
    _displayName = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('displayName');

    notifyListeners();
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _displayName = prefs.getString('displayName');
    notifyListeners();
  }
}
