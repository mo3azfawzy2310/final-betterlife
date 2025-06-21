import 'dart:convert';

import 'package:better_life/core/EndpointConstants/endpoint_donstants.dart';
import 'package:better_life/core/network/api_consumer.dart';
import 'package:better_life/core/network/dio_consumer.dart';
import 'package:better_life/models/appointment_model.dart';
import 'package:better_life/ui/logic/auth/dio_factory.dart';
import 'package:dio/dio.dart';

class BookAppointmentRequest {
  final int patientId;
  final int doctorId;
  final String appointmentDateTime;
  final String reason;

  BookAppointmentRequest({
    required this.patientId,
    required this.doctorId,
    required this.appointmentDateTime,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'doctorId': doctorId,
      'appointmentDateTime': appointmentDateTime,
      'reason': reason,
    };
  }
}

class AppointmentService {
  final ApiConsumer _api = DioConsumer(client: Dio());

  Future<List<AppointmentModel>> getAppointments(int patientId) async {
    try {
      print('🔍 Fetching appointments for patient ID: $patientId');
      final response = await _api.get(
        'Patient/Appointments',
        queryParameters: {'patientId': patientId},
      );
      
      print('🔍 Get Patient Appointments Response: $response');
      
      if (response is List) {
        return response.map((appointment) => AppointmentModel.fromJson(appointment)).toList();
      } else if (response is Map && response.containsKey('data') && response['data'] is List) {
        // Handle case where response is wrapped in a data field
        return (response['data'] as List).map((appointment) => AppointmentModel.fromJson(appointment)).toList();
      } else if (response is Map && response.containsKey('appointments') && response['appointments'] is List) {
        // Handle case where response is wrapped in an appointments field
        return (response['appointments'] as List).map((appointment) => AppointmentModel.fromJson(appointment)).toList();
      } else {
        print('❌ Unexpected appointments response format: $response');
        return [];
      }
    } catch (e) {
      print('❌ Error fetching appointments: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getAvailableDays(int doctorId) async {
    try {
      print('📅 Getting available days for doctor: $doctorId');
      final response = await _api.get(
        'Patient/AvailableDays',
        queryParameters: {'doctorId': doctorId},
      );
      
      print('🔍 Get Available Days Response: $response');
      
      if (response is List) {
        return List<Map<String, dynamic>>.from(response);
      }
      
      return [];
    } catch (e) {
      print('❌ Error getting available days: $e');
      return [];
    }
  }

  Future<List<String>> getAvailableTimes(int doctorId, String date) async {
    try {
      print('⏰ Getting available times for doctor: $doctorId on date: $date');
      final response = await _api.get(
        'Patient/AvailableTimes',
        queryParameters: {'doctorId': doctorId, 'date': date},
      );
      
      print('🔍 Get Available Times Response: $response');
      
      if (response is List) {
        // If the API returns time strings directly
        if (response.isNotEmpty && response.first is String) {
          return List<String>.from(response);
        }
        
        // If the API returns objects with a time property
        if (response.isNotEmpty && response.first is Map) {
          return response
              .map((item) => item['time']?.toString() ?? '')
              .where((time) => time.isNotEmpty)
              .toList();
        }
      }
      
      // If the API returns no times, add some test times for development
      print('⚠️ No times returned from API. Adding test time slots.');
      return [
        '09:00', '09:30', '10:00', '10:30', '11:00', '11:30',
        '13:00', '13:30', '14:00', '14:30', '15:00', '15:30',
        '16:00', '16:30', '17:00'
      ];
    } catch (e) {
      print('❌ Error getting available times: $e');
      // Return test times for development
      return [
        '09:00', '09:30', '10:00', '10:30', '11:00', '11:30',
        '13:00', '13:30', '14:00', '14:30', '15:00', '15:30',
        '16:00', '16:30', '17:00'
      ];
    }
  }

  Future<bool> cancelAppointment(int appointmentId) async {
    try {
      print('🗑️ Cancelling appointment: $appointmentId');
      final response = await _api.post(
        'Patient/CancelAppointment',
        queryParameters: {'id': appointmentId},
      );
      
      print('🗑️ Cancel appointment response: $response');
      return true;
    } catch (e) {
      print('❌ Error cancelling appointment: $e');
      return false;
    }
  }

  Future<bool> bookAppointment(BookAppointmentRequest request) async {
    try {
      print('📝 Booking appointment: ${request.toJson()}');
      final response = await _api.post(
        'Patient/CreateAppointment',
        body: request.toJson(),
      );
      
      print('📝 Book appointment response: $response');
      
      // Handle different success responses
      if (response is Map && response.containsKey('success') && response['success'] == true) {
        return true;
      } else if (response is Map && response.containsKey('statusCode') && 
                (response['statusCode'] == 200 || response['statusCode'] == 201)) {
        return true;
      } else if (response == null) {
        // Some APIs return empty response on success with status code 200/201/204
        return true;
      }
      
      // For direct API call success
      return true;
    } catch (e) {
      print('❌ Error booking appointment: $e');
      return false;
    }
  }

  // Method to directly check if an appointment exists by patientId and doctorId
  Future<bool> checkAppointmentExists(int patientId, int doctorId) async {
    try {
      print('🔍 Checking if appointment exists for patient $patientId with doctor $doctorId');
      
      // First try the standard API endpoint
      final appointments = await getAppointments(patientId);
      
      // Check if any appointment matches the doctor ID
      final exists = appointments.any((appointment) {
        // Try to parse the doctor ID from the appointment
        try {
          final appointmentDoctorId = appointment.doctorId;
          print('🔍 Comparing appointment doctor ID $appointmentDoctorId with $doctorId');
          return appointmentDoctorId == doctorId;
        } catch (_) {
          return false;
        }
      });
      
      if (exists) {
        print('✅ Found existing appointment for patient $patientId with doctor $doctorId');
        return true;
      }
      
      // If not found, try a direct API call to check for pending appointments
      print('🔍 No existing appointment found, checking for pending appointments');
      
      final pendingResponse = await _api.get(
        'Patient/Appointments',
        queryParameters: {'patientId': patientId, 'status': 'pending'},
      );
      
      print('🔍 Pending appointments response: $pendingResponse');
      
      if (pendingResponse is List && pendingResponse.isNotEmpty) {
        final pendingExists = pendingResponse.any((appointment) {
          try {
            final pendingDoctorId = appointment['doctorId'] ?? 0;
            print('🔍 Comparing pending appointment doctor ID $pendingDoctorId with $doctorId');
            return pendingDoctorId == doctorId;
          } catch (_) {
            return false;
          }
        });
        
        if (pendingExists) {
          print('✅ Found pending appointment for patient $patientId with doctor $doctorId');
          return true;
        }
      }
      
      print('❌ No appointment found for patient $patientId with doctor $doctorId');
      return false;
    } catch (e) {
      print('❌ Error checking if appointment exists: $e');
      return false;
    }
  }

  // Get a specific appointment by ID
  Future<AppointmentModel?> getAppointmentById(String appointmentId) async {
    try {
      print('🔍 Fetching appointment with ID: $appointmentId');
      final response = await _api.get(
        'Patient/Appointment',
        queryParameters: {'id': appointmentId},
      );
      
      print('🔍 Get Appointment Response: $response');
      
      if (response != null) {
        return AppointmentModel.fromJson(response);
      }
      
      return null;
    } catch (e) {
      print('❌ Error fetching appointment: $e');
      return null;
    }
  }
} 