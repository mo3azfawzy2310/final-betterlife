import 'package:better_life/core/EndpointConstants/endpoint_donstants.dart';
import 'package:better_life/core/network/api_consumer.dart';
import 'package:better_life/core/network/dio_consumer.dart';
import 'package:better_life/models/doctor_model.dart';
import 'package:better_life/ui/logic/auth/dio_factory.dart';
import 'package:dio/dio.dart';

class DoctorService {
  final ApiConsumer _api = DioFactory.getDioConsumer();

  // Get a single doctor by ID
  Future<DoctorModel?> getDoctorById(int doctorId) async {
    try {
      final response = await _api.get(
        EndpointConstants.getDoctor,
        queryParameters: {'id': doctorId},
      );
      
      print('🔍 Get Doctor Response: $response');
      return DoctorModel.fromJson(response);
    } catch (e) {
      print('❌ Failed to get doctor: $e');
      return null;
    }
  }

  // For backward compatibility with existing code
  Future<DoctorModel?> getDoctor(int doctorId) async {
    return getDoctorById(doctorId);
  }

  // Get all doctors
  Future<List<DoctorModel>> getAllDoctors() async {
    try {
      final response = await _api.get(EndpointConstants.getAllDoctors);

      print('🔍 Get All Doctors Response: $response');
      
      if (response is List) {
        return response.map((json) => DoctorModel.fromJson(json)).toList();
      } else {
        throw Exception('Expected list of doctors but got: ${response.runtimeType}');
      }
    } catch (e) {
      print('❌ Failed to get all doctors: $e');
      return [];
    }
  }

  // Get favorite doctors for a patient
  Future<List<DoctorModel>> getFavoriteDoctors(int patientId) async {
    try {
      final response = await _api.get(
        'Patient/FavoriteDoctors',
        queryParameters: {'patientId': patientId},
      );
      
      print('🔍 Get Favorite Doctors Response: $response');
      
      if (response is List) {
        return response.map((json) => DoctorModel.fromJson(json)).toList();
      } else {
        throw Exception('Expected list of favorite doctors but got: ${response.runtimeType}');
      }
    } catch (e) {
      throw Exception('Failed to get favorite doctors: $e');
    }
  }

  // Add doctor to favorites
  Future<bool> addFavoriteDoctor(int doctorId, int patientId) async {
    try {
      final response = await _api.post(
        'Patient/AddFavoriteDoctor',
        queryParameters: {
          'DoctorId': doctorId,
          'PatientId': patientId,
        },
      );
      
      print('🔍 Add Favorite Doctor Response: $response');
      
      return true;
    } catch (e) {
      throw Exception('Failed to add favorite doctor: $e');
    }
  }

  // Remove doctor from favorites
  Future<bool> removeFavoriteDoctor(int doctorId, int patientId) async {
    try {
      final response = await _api.delete(
        'Patient/RemoveDoctorFromFavorites',
        queryParameters: {
          'DoctorId': doctorId,
          'PatientId': patientId,
        },
      );
      
      print('🔍 Remove Favorite Doctor Response: $response');
      
      return true;
    } catch (e) {
      throw Exception('Failed to remove favorite doctor: $e');
    }
  }

  // Get doctors by speciality
  Future<List<DoctorModel>> getDoctorsBySpeciality(String speciality) async {
    try {
      // Since your API might not have this endpoint directly,
      // we'll get all doctors and filter them
      final allDoctors = await getAllDoctors();
      return allDoctors.where((doctor) => 
        doctor.speciality.toLowerCase() == speciality.toLowerCase()
      ).toList();
    } catch (e) {
      print('❌ Failed to get doctors by speciality: $e');
      return [];
    }
  }
  
  // Get top-rated doctors
  Future<List<DoctorModel>> getTopDoctors() async {
    try {
      // Since your API might not have this endpoint directly,
      // we'll get all doctors and sort them by rating
      final allDoctors = await getAllDoctors();
      allDoctors.sort((a, b) => b.rating.compareTo(a.rating));
      return allDoctors.take(10).toList(); // Return top 10
    } catch (e) {
      print('❌ Failed to get top doctors: $e');
      return [];
    }
  }
  
  // Search doctors by name or speciality
  Future<List<DoctorModel>> searchDoctors(String query) async {
    try {
      // Get all doctors and filter locally
      final allDoctors = await getAllDoctors();
      
      if (query.isEmpty) {
        return allDoctors;
      }
      
      final searchQuery = query.toLowerCase();
      return allDoctors.where((doctor) {
        final name = doctor.name.toLowerCase();
        final speciality = doctor.speciality.toLowerCase();
        return name.contains(searchQuery) || speciality.contains(searchQuery);
      }).toList();
    } catch (e) {
      print('❌ Failed to search doctors: $e');
      return [];
    }
  }
} 