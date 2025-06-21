import 'package:better_life/core/cach_data/app_shared_preferences.dart';
import 'package:better_life/core/network/api_consumer.dart';
import 'package:better_life/core/network/dio_consumer.dart';
import 'package:better_life/models/user_model.dart';
import 'package:better_life/models/medical_record_model.dart';
import 'package:better_life/models/radiation_model.dart';
import 'package:better_life/models/notification_model.dart';
import 'package:better_life/ui/logic/auth/dio_factory.dart';

class UserService {
  static final ApiConsumer _api = DioFactory.getDioConsumer();

  // Get current user from shared preferences
  static Future<UserModel?> getCurrentUser() async {
    try {
      final user = await AppPreferences().getModel<UserModel>(
        'userModel',
        UserModel.fromJson,
      );
      
      // Debug: Print user data to see what we're getting
      print('🔍 Current User Data:');
      print('  - User: ${user?.toJson()}');
      print('  - Patient ID: ${user?.patientId}');
      print('  - Token: ${user?.token}');
      
      return user;
    } catch (e) {
      print('❌ Error getting current user: $e');
      return null;
    }
  }

  static Future<int?> getCurrentPatientId() async {
    final user = await getCurrentUser();
    final patientId = user?.patientId;
    
    print('🔍 Patient ID: $patientId');
    
    return patientId;
  }

  static Future<String?> getCurrentUserToken() async {
    final user = await getCurrentUser();
    return user?.token;
  }

  // Debug method to check if user is properly saved
  static Future<void> debugUserData() async {
    try {
      final user = await getCurrentUser();
      print('🔍 DEBUG - User Data Check:');
      print('  - User exists: ${user != null}');
      if (user != null) {
        print('  - Display Name: ${user.displayName}');
        print('  - Email: ${user.email}');
        print('  - Token: ${user.token}');
        print('  - Patient ID: ${user.patientId}');
      }
    } catch (e) {
      print('❌ DEBUG - Error: $e');
    }
  }

  // Get patient by ID
  static Future<UserModel> getPatientById(int patientId) async {
    try {
      final response = await _api.get(
        'Patient/Patient',
        queryParameters: {'id': patientId},
      );
      
      print('🔍 Get Patient by ID Response: $response');
      
      final user = UserModel.fromJson(response);
      return user;
    } catch (e) {
      throw Exception('Failed to get patient by ID: $e');
    }
  }

  // Get patient by username
  static Future<UserModel> getPatientByUsername(String username) async {
    try {
      final response = await _api.get(
        'Patient/Patient/userName',
        queryParameters: {'userName': username},
      );
      
      print('🔍 Get Patient by Username Response: $response');
      
      final user = UserModel.fromJson(response);
      return user;
    } catch (e) {
      print('⚠️ Failed to get patient by username: $e');
      throw Exception('Failed to get patient by username: $e');
    }
  }
  
  // Get patient by email
  static Future<UserModel> getPatientByEmail(String email) async {
    try {
      // Try to get patient info using email
      // Note: This endpoint might not exist in your API
      // You may need to adjust this based on your backend API structure
      final response = await _api.get(
        'Patient/PatientByEmail',
        queryParameters: {'email': email},
      );
      
      print('🔍 Get Patient by Email Response: $response');
      
      final user = UserModel.fromJson(response);
      return user;
    } catch (e) {
      print('⚠️ Failed to get patient by email: $e');
      throw Exception('Failed to get patient by email: $e');
    }
  }

  // Update patient
  static Future<bool> updatePatient(UserModel patient) async {
    try {
      final response = await _api.put(
        'Patient/UpdatePatient',
        body: patient.toJson(),
      );
      
      print('🔍 Update Patient Response: $response');
      
      return true;
    } catch (e) {
      throw Exception('Failed to update patient: $e');
    }
  }

  // Get medical records
  static Future<List<MedicalRecordModel>> getMedicalRecords(int patientId) async {
    try {
      final response = await _api.get(
        'Patient/MedicalRecord',
        queryParameters: {'id': patientId.toString()},
      );
      
      print('🔍 Get Medical Records Response: $response');
      
      if (response is List) {
        return response.map((json) => MedicalRecordModel.fromJson(json)).toList();
      } else {
        throw Exception('Expected list of medical records but got: ${response.runtimeType}');
      }
    } catch (e) {
      throw Exception('Failed to get medical records: $e');
    }
  }

  // Get radiation records
  static Future<List<RadiationModel>> getRadiationRecords(int patientId) async {
    try {
      final response = await _api.get(
        'Patient/Radiation',
        queryParameters: {'id': patientId.toString()},
      );
      
      print('🔍 Get Radiation Records Response: $response');
      
      if (response is List) {
        return response.map((json) => RadiationModel.fromJson(json)).toList();
      } else {
        throw Exception('Expected list of radiation records but got: ${response.runtimeType}');
      }
    } catch (e) {
      throw Exception('Failed to get radiation records: $e');
    }
  }

  // Get all notifications
  static Future<List<NotificationModel>> getAllNotifications(int patientId) async {
    try {
      final response = await _api.get(
        'Patient/Notifications',
        queryParameters: {'patientId': patientId},
      );
      
      print('🔍 Get All Notifications Response: $response');
      
      if (response is List) {
        return response.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        throw Exception('Expected list of notifications but got: ${response.runtimeType}');
      }
    } catch (e) {
      throw Exception('Failed to get notifications: $e');
    }
  }

  // Get notification by ID
  static Future<NotificationModel> getNotificationById(int notificationId) async {
    try {
      final response = await _api.get(
        'Patient/Notification',
        queryParameters: {'id': notificationId},
      );
      
      print('🔍 Get Notification by ID Response: $response');
      
      final notification = NotificationModel.fromJson(response);
      return notification;
    } catch (e) {
      throw Exception('Failed to get notification: $e');
    }
  }

  // Read notification
  static Future<bool> readNotification(int notificationId) async {
    try {
      final response = await _api.put(
        'Patient/ReadNotification',
        queryParameters: {'id': notificationId},
      );
      
      print('🔍 Read Notification Response: $response');
      
      return true;
    } catch (e) {
      throw Exception('Failed to read notification: $e');
    }
  }

  // Delete notification
  static Future<bool> deleteNotification(int notificationId) async {
    try {
      final response = await _api.delete(
        'Patient/DeleteNotification',
        queryParameters: {'id': notificationId},
      );
      
      print('🔍 Delete Notification Response: $response');
      
      return true;
    } catch (e) {
      throw Exception('Failed to delete notification: $e');
    }
  }

  // Rate doctor
  static Future<bool> rateDoctor(int doctorId, int rating) async {
    try {
      final response = await _api.put(
        'Patient/RateDoctor',
        queryParameters: {
          'doctorId': doctorId,
          'rate': rating,
        },
      );
      
      print('🔍 Rate Doctor Response: $response');
      
      return true;
    } catch (e) {
      throw Exception('Failed to rate doctor: $e');
    }
  }
} 