import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:better_life/core/cach_data/app_shared_preferences.dart';
import 'package:better_life/models/user_model.dart';
import 'package:better_life/core/services/google_auth_service.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  final GoogleAuthService _googleAuthService = GoogleAuthService();

  String? get token => _token;

  Future<bool> register(String displayName, String email, String password,
      String phoneNumber, String userName) async {
    final url =
        Uri.parse("http://betterlife.runasp.net/api/Authentication/Register");

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

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Registration failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Registration exception: $e");
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final url =
        Uri.parse("https://betterlife.runasp.net/api/Authentication/Login");

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
        
        print("🔍 Login Response: $json");

        // Create UserModel with the response data
        final user = UserModel.fromJson(json);
        
        // Save the complete user model using AppPreferences
        await AppPreferences().saveModel<UserModel>(
          'userModel',
          user,
          (u) => u.toJson(),
        );

        _token = user.token;
        
        print("🔍 User saved: ${user.toJson()}");
        print("🔍 Token: $_token");
        print("🔍 Patient ID: ${user.patientId}");

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
    // Clear the user model from AppPreferences
    await AppPreferences().removeData('userModel');
    notifyListeners();
  }

  Future<void> loadToken() async {
    // Load user data from AppPreferences
    final user = await AppPreferences().getModel<UserModel>(
      'userModel',
      UserModel.fromJson,
    );
    _token = user?.token;
    notifyListeners();
  }

  // Google Login
  Future<bool> googleLogin(String idToken) async {
    try {
      final user = await _googleAuthService.googleLogin(idToken);
      
      // Save the complete user model using AppPreferences
      await AppPreferences().saveModel<UserModel>(
        'userModel',
        user,
        (u) => u.toJson(),
      );

      _token = user.token;
      
      print("🔍 Google Login - User saved: ${user.toJson()}");
      print("🔍 Google Login - Token: $_token");
      print("🔍 Google Login - Patient ID: ${user.patientId}");

      notifyListeners();
      return true;
    } catch (e) {
      print("Google login exception: $e");
      return false;
    }
  }

  // Google Signup
  Future<bool> googleSignup(String idToken, String username) async {
    try {
      final user = await _googleAuthService.googleSignup(idToken, username);
      
      // Save the complete user model using AppPreferences
      await AppPreferences().saveModel<UserModel>(
        'userModel',
        user,
        (u) => u.toJson(),
      );

      _token = user.token;
      
      print("🔍 Google Signup - User saved: ${user.toJson()}");
      print("🔍 Google Signup - Token: $_token");
      print("🔍 Google Signup - Patient ID: ${user.patientId}");

      notifyListeners();
      return true;
    } catch (e) {
      print("Google signup exception: $e");
      return false;
    }
  }
}
