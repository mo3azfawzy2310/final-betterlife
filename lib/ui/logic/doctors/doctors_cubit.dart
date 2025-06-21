import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_life/core/services/doctor_service.dart';
import 'package:better_life/models/doctor_model.dart';
import 'package:better_life/ui/logic/doctors/doctors_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  final DoctorService _doctorService = DoctorService();

  DoctorsCubit() : super(DoctorsInitial());

  // Get all doctors
  Future<void> getAllDoctors() async {
    try {
      emit(DoctorsLoading());
      final doctors = await _doctorService.getAllDoctors();
      emit(DoctorsLoaded(doctors));
    } catch (e) {
      emit(DoctorsError(e.toString()));
    }
  }

  // Get a single doctor
  Future<void> getDoctor(int doctorId) async {
    emit(DoctorLoading());
    try {
      final doctor = await _doctorService.getDoctor(doctorId);
      if (doctor != null) {
        emit(DoctorLoaded(doctor));
      } else {
        emit(DoctorError('Doctor not found'));
      }
    } catch (e) {
      emit(DoctorError(e.toString()));
    }
  }

  // Get favorite doctors
  Future<void> getFavoriteDoctors(int patientId) async {
    emit(FavoriteDoctorsLoading());
    try {
      final doctors = await _doctorService.getFavoriteDoctors(patientId);
      emit(FavoriteDoctorsLoaded(doctors));
    } catch (e) {
      emit(FavoriteDoctorsError(e.toString()));
    }
  }

  // Add doctor to favorites
  Future<void> addFavoriteDoctor(int doctorId, int patientId) async {
    emit(FavoriteDoctorsLoading());
    try {
      await _doctorService.addFavoriteDoctor(doctorId, patientId);
      // Refresh favorite doctors list
      await getFavoriteDoctors(patientId);
    } catch (e) {
      emit(FavoriteDoctorsError(e.toString()));
    }
  }

  // Remove doctor from favorites
  Future<void> removeFavoriteDoctor(int doctorId, int patientId) async {
    emit(FavoriteDoctorsLoading());
    try {
      await _doctorService.removeFavoriteDoctor(doctorId, patientId);
      // Refresh favorite doctors list
      await getFavoriteDoctors(patientId);
    } catch (e) {
      emit(FavoriteDoctorsError(e.toString()));
    }
  }

  // Toggle favorite status
  Future<void> toggleFavorite(int doctorId, int patientId, bool isCurrentlyFavorite) async {
    if (isCurrentlyFavorite) {
      await removeFavoriteDoctor(doctorId, patientId);
    } else {
      await addFavoriteDoctor(doctorId, patientId);
    }
  }

  Future<void> getDoctorsBySpeciality(String speciality) async {
    try {
      emit(DoctorsLoading());
      final doctors = await _doctorService.getDoctorsBySpeciality(speciality);
      emit(DoctorsLoaded(doctors));
    } catch (e) {
      emit(DoctorsError(e.toString()));
    }
  }

  Future<void> getTopDoctors() async {
    try {
      emit(DoctorsLoading());
      final doctors = await _doctorService.getTopDoctors();
      emit(DoctorsLoaded(doctors));
    } catch (e) {
      emit(DoctorsError(e.toString()));
    }
  }

  Future<void> searchDoctors(String query) async {
    try {
      emit(DoctorsLoading());
      final doctors = await _doctorService.searchDoctors(query);
      emit(DoctorsLoaded(doctors));
    } catch (e) {
      emit(DoctorsError(e.toString()));
    }
  }

  Future<void> getDoctorById(int doctorId) async {
    try {
      emit(DoctorsLoading());
      final doctor = await _doctorService.getDoctorById(doctorId);
      if (doctor != null) {
        emit(DoctorsLoaded([doctor]));
      } else {
        emit(DoctorsError('Doctor not found'));
      }
    } catch (e) {
      emit(DoctorsError(e.toString()));
    }
  }
} 