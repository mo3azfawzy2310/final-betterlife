import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_life/core/services/medical_records_service.dart';
import 'package:better_life/models/medical_record_model.dart';
import 'package:better_life/models/radiation_model.dart';

part 'medical_records_state.dart';

class MedicalRecordsCubit extends Cubit<MedicalRecordsState> {
  MedicalRecordsCubit() : super(MedicalRecordsInitial());

  // Get all records (medical + radiation) for a patient
  Future<void> getAllRecords(String patientId) async {
    emit(AllRecordsLoading());
    try {
      final medicalRecords = await MedicalRecordsService.getMedicalRecords(patientId);
      final radiationRecords = await MedicalRecordsService.getRadiationRecords(patientId);
      
      emit(AllRecordsLoaded(medicalRecords, radiationRecords));
    } catch (e) {
      emit(AllRecordsError(e.toString()));
    }
  }

  // Get only medical records
  Future<void> getMedicalRecords(String patientId) async {
    emit(MedicalRecordsLoading());
    try {
      final records = await MedicalRecordsService.getMedicalRecords(patientId);
      emit(MedicalRecordsLoaded(records));
    } catch (e) {
      emit(MedicalRecordsError(e.toString()));
    }
  }

  // Get only radiation records
  Future<void> getRadiationRecords(String patientId) async {
    emit(RadiationRecordsLoading());
    try {
      final records = await MedicalRecordsService.getRadiationRecords(patientId);
      emit(RadiationRecordsLoaded(records));
    } catch (e) {
      emit(RadiationRecordsError(e.toString()));
    }
  }

  // Get a specific medical record by ID
  Future<void> getMedicalRecordById(String recordId) async {
    emit(MedicalRecordLoading());
    try {
      final allRecords = await MedicalRecordsService.getMedicalRecords('1'); // Assuming patient ID 1
      final record = allRecords.firstWhere((record) => record.id == recordId);
      emit(MedicalRecordLoaded(record));
    } catch (e) {
      emit(MedicalRecordError(e.toString()));
    }
  }

  // Get a specific radiation record by ID
  Future<void> getRadiationRecordById(String recordId) async {
    emit(RadiationRecordLoading());
    try {
      final allRecords = await MedicalRecordsService.getRadiationRecords('1'); // Assuming patient ID 1
      final record = allRecords.firstWhere((record) => record.id == recordId);
      emit(RadiationRecordLoaded(record));
    } catch (e) {
      emit(RadiationRecordError(e.toString()));
    }
  }
} 