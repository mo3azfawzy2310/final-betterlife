import 'package:better_life/core/EndpointConstants/endpoint_donstants.dart';
import 'package:better_life/core/cach_data/app_shared_preferences.dart';
import 'package:better_life/core/network/api_consumer.dart';
import 'package:better_life/core/network/dio_consumer.dart';
import 'package:better_life/models/regester_model.dart';
import 'package:better_life/models/user_model.dart';
import 'package:better_life/ui/logic/auth/dio_factory.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final ApiConsumer _api = DioFactory.getDioConsumer();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  // Regular login
  Future<UserModel> login(String email, String password) async {
    try {
      print('🔑 Attempting login with email: $email');
      
      final response = await _api.post(
        EndpointConstants.login,
        body: {
          "email": email,
          "password": password,
          "role": "Patient"
        },
      );
      
      print('🔑 Login response: $response');
      
      final user = UserModel.fromJson(response);
      
      // Save user to shared preferences
      await AppPreferences().saveModel<UserModel>(
        'userModel',
        user,
        (u) => u.toJson(),
      );
      
      print('✅ Login successful for: ${user.displayName}');
      return user;
    } catch (e) {
      print('❌ Login error: $e');
      throw Exception('Login failed: $e');
    }
  }

  // Register new user
  Future<UserModel> register(RegisterRequestModel registerData) async {
    try {
      print('📝 Registering new user: ${registerData.displayName}');
      
      final response = await _api.post(
        EndpointConstants.register,
        body: registerData.toJson(),
      );
      
      print('📝 Registration response: $response');
      
      final user = UserModel.fromJson(response);
      
      // Save user to shared preferences
      await AppPreferences().saveModel<UserModel>(
        'userModel',
        user,
        (u) => u.toJson(),
      );
      
      print('✅ Registration successful for: ${user.displayName}');
      return user;
    } catch (e) {
      print('❌ Registration error: $e');
      throw Exception('Registration failed: $e');
    }
  }

  // Google Sign In
  Future<UserModel> signInWithGoogle() async {
    try {
      print('🔑 Starting Google Sign In flow');
      
      // Attempt to sign in with Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        throw Exception('Google sign in was cancelled by user');
      }
      
      // Get authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken;
      
      if (idToken == null) {
        throw Exception('Failed to get Google ID token');
      }
      
      print('🔑 Got Google ID token, attempting to authenticate with backend');
      
      // Try login first (for existing users)
      try {
        final response = await _api.get(
          EndpointConstants.googleLogin,
          queryParameters: {'IdToken': idToken},
        );
        
        print('🔑 Google login response: $response');
        
        final user = UserModel.fromJson(response);
        
        // Save user to shared preferences
        await AppPreferences().saveModel<UserModel>(
          'userModel',
          user,
          (u) => u.toJson(),
        );
        
        print('✅ Google login successful for: ${user.displayName}');
        return user;
      } catch (loginError) {
        // If login fails, try registration
        print('⚠️ Google login failed, attempting registration: $loginError');
        
        // Generate a username from email (remove special characters and domain)
        String username = googleUser.email.split('@')[0].replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
        
        final response = await _api.post(
          EndpointConstants.googleSignup,
          body: {
            'IdToken': idToken,
            'username': username,
          },
        );
        
        print('📝 Google registration response: $response');
        
        final user = UserModel.fromJson(response);
        
        // Save user to shared preferences
        await AppPreferences().saveModel<UserModel>(
          'userModel',
          user,
          (u) => u.toJson(),
        );
        
        print('✅ Google registration successful for: ${user.displayName}');
        return user;
      }
    } catch (e) {
      print('❌ Google authentication error: $e');
      throw Exception('Google authentication failed: $e');
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      final user = await AppPreferences().getModel<UserModel>(
        'userModel',
        UserModel.fromJson,
      );
      
      return user != null && user.token.isNotEmpty;
    } catch (e) {
      print('❌ Error checking login status: $e');
      return false;
    }
  }

  // Get current user
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = await AppPreferences().getModel<UserModel>(
        'userModel',
        UserModel.fromJson,
      );
      
      return user;
    } catch (e) {
      print('❌ Error getting current user: $e');
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      // Sign out from Google if signed in with Google
      await _googleSignIn.signOut();
    } catch (e) {
      print('⚠️ Error signing out from Google: $e');
      // Continue with local logout even if Google signout fails
    }
    
    try {
      // Remove user data from shared preferences
      await AppPreferences().removeData('userModel');
      print('✅ Logout successful');
    } catch (e) {
      print('❌ Error during logout: $e');
      throw Exception('Logout failed: $e');
    }
  }

  // Validate token
  Future<bool> validateToken(String token) async {
    try {
      // Add your token validation logic here
      // This could be a call to a specific endpoint that validates tokens
      
      // Example implementation (replace with actual endpoint):
      final response = await _api.get(
        'Authentication/validate-token',
        headers: {'Authorization': 'Bearer $token'},
      );
      
      return response['isValid'] == true;
    } catch (e) {
      print('❌ Token validation error: $e');
      return false;
    }
  }
} 