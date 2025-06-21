import 'package:better_life/core/network/api_consumer.dart';
import 'package:better_life/core/network/dio_consumer.dart';
import 'package:better_life/models/user_model.dart';
import 'package:better_life/ui/logic/auth/dio_factory.dart';

class GoogleAuthService {
  final ApiConsumer _api = DioFactory.getDioConsumer();

  // Google Login
  Future<UserModel> googleLogin(String idToken) async {
    try {
      final response = await _api.get(
        'Authentication/google-login',
        queryParameters: {'IdToken': idToken},
      );
      
      print('🔍 Google Login Response: $response');
      
      final user = UserModel.fromJson(response);
      return user;
    } catch (e) {
      throw Exception('Failed to login with Google: $e');
    }
  }

  // Google Signup
  Future<UserModel> googleSignup(String idToken, String username) async {
    try {
      final response = await _api.post(
        'Authentication/RegisterPatientByGoogle',
        body: {
          'IdToken': idToken,
          'username': username,
        },
      );
      
      print('🔍 Google Signup Response: $response');
      
      final user = UserModel.fromJson(response);
      return user;
    } catch (e) {
      throw Exception('Failed to signup with Google: $e');
    }
  }
} 