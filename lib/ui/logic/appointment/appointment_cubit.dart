import 'package:better_life/core/services/appointment_service.dart';
import 'package:better_life/models/appointment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentService _appointmentService = AppointmentService();

  AppointmentCubit() : super(AppointmentInitial());

  // Get patient appointments
  Future<void> getPatientAppointments(int patientId) async {
    try {
      emit(AppointmentLoading());
      final appointments = await _appointmentService.getAppointments(patientId);
      emit(AppointmentsLoaded(appointments));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  // Book appointment
  Future<void> bookAppointment(BookAppointmentRequest request) async {
    try {
      emit(AppointmentActionLoading());
      final success = await _appointmentService.bookAppointment(request);
      
      if (success) {
        // If booking was successful, refresh the list of appointments
        print('🔄 Refreshing appointments after booking');
        try {
          // Wait a moment to allow the server to process the booking
          await Future.delayed(const Duration(seconds: 1));
          final appointments = await _appointmentService.getAppointments(request.patientId);
          emit(AppointmentsLoaded(appointments));
        } catch (refreshError) {
          print('⚠️ Error refreshing appointments: $refreshError');
          // Still indicate booking was successful even if refresh failed
          emit(AppointmentBooked(success));
        }
      } else {
        emit(AppointmentBooked(success));
      }
    } catch (e) {
      print('❌ Error in bookAppointment cubit: $e');
      emit(AppointmentError(e.toString()));
    }
  }

  // Cancel appointment
  Future<void> cancelAppointment(int appointmentId, int patientId) async {
    try {
      emit(AppointmentActionLoading());
      await _appointmentService.cancelAppointment(appointmentId);
      final appointments = await _appointmentService.getAppointments(patientId);
      emit(AppointmentsLoaded(appointments));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  // Get available days
  Future<void> getAvailableDays(int doctorId) async {
    try {
      emit(AppointmentLoading());
      final days = await _appointmentService.getAvailableDays(doctorId);
      emit(AppointmentActionSuccess('Available days fetched'));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  // Get available times
  Future<void> getAvailableTimes(int doctorId, String date) async {
    try {
      emit(AppointmentLoading());
      final times = await _appointmentService.getAvailableTimes(doctorId, date);
      emit(AppointmentActionSuccess('Available times fetched'));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }
}
