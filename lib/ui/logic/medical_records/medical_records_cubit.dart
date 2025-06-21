import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_life/core/services/user_service.dart';
import 'package:better_life/models/medical_record_model.dart';
import 'package:better_life/models/radiation_model.dart';

part 'medical_records_state.dart';

class MedicalRecordsCubit extends Cubit<MedicalRecordsState> {
  MedicalRecordsCubit() : super(MedicalRecordsInitial());

  // Get medical records
  Future<void> getMedicalRecords(int patientId) async {
    emit(MedicalRecordsLoading());
    try {
      final records = await UserService.getMedicalRecords(patientId);
      emit(MedicalRecordsLoaded(records));
    } catch (e) {
      emit(MedicalRecordsError(e.toString()));
    }
  }

  // Get radiation records
  Future<void> getRadiationRecords(int patientId) async {
    emit(RadiationRecordsLoading());
    try {
      final records = await UserService.getRadiationRecords(patientId);
      emit(RadiationRecordsLoaded(records));
    } catch (e) {
      emit(RadiationRecordsError(e.toString()));
    }
  }

  // Get both medical and radiation records
  Future<void> getAllRecords(int patientId) async {
    emit(AllRecordsLoading());
    try {
      final medicalRecords = await UserService.getMedicalRecords(patientId);
      final radiationRecords = await UserService.getRadiationRecords(patientId);
      emit(AllRecordsLoaded(medicalRecords, radiationRecords));
    } catch (e) {
      emit(AllRecordsError(e.toString()));
    }
  }
} 