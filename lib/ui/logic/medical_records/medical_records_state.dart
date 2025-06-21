part of 'medical_records_cubit.dart';

abstract class MedicalRecordsState {}

class MedicalRecordsInitial extends MedicalRecordsState {}

// Medical records states
class MedicalRecordsLoading extends MedicalRecordsState {}

class MedicalRecordsLoaded extends MedicalRecordsState {
  final List<MedicalRecordModel> medicalRecords;
  MedicalRecordsLoaded(this.medicalRecords);
}

class MedicalRecordsError extends MedicalRecordsState {
  final String message;
  MedicalRecordsError(this.message);
}

// Radiation records states
class RadiationRecordsLoading extends MedicalRecordsState {}

class RadiationRecordsLoaded extends MedicalRecordsState {
  final List<RadiationModel> radiationRecords;
  RadiationRecordsLoaded(this.radiationRecords);
}

class RadiationRecordsError extends MedicalRecordsState {
  final String message;
  RadiationRecordsError(this.message);
}

// All records states
class AllRecordsLoading extends MedicalRecordsState {}

class AllRecordsLoaded extends MedicalRecordsState {
  final List<MedicalRecordModel> medicalRecords;
  final List<RadiationModel> radiationRecords;
  AllRecordsLoaded(this.medicalRecords, this.radiationRecords);
}

class AllRecordsError extends MedicalRecordsState {
  final String message;
  AllRecordsError(this.message);
} 