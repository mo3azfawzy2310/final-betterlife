part of 'medical_records_cubit.dart';

abstract class MedicalRecordsState {}

class MedicalRecordsInitial extends MedicalRecordsState {}

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

// Medical records states
class MedicalRecordsLoading extends MedicalRecordsState {}
class MedicalRecordsLoaded extends MedicalRecordsState {
  final List<MedicalRecordModel> records;
  MedicalRecordsLoaded(this.records);
}
class MedicalRecordsError extends MedicalRecordsState {
  final String message;
  MedicalRecordsError(this.message);
}

// Single medical record states
class MedicalRecordLoading extends MedicalRecordsState {}
class MedicalRecordLoaded extends MedicalRecordsState {
  final MedicalRecordModel record;
  MedicalRecordLoaded(this.record);
}
class MedicalRecordError extends MedicalRecordsState {
  final String message;
  MedicalRecordError(this.message);
}

// Radiation records states
class RadiationRecordsLoading extends MedicalRecordsState {}
class RadiationRecordsLoaded extends MedicalRecordsState {
  final List<RadiationModel> records;
  RadiationRecordsLoaded(this.records);
}
class RadiationRecordsError extends MedicalRecordsState {
  final String message;
  RadiationRecordsError(this.message);
}

// Single radiation record states
class RadiationRecordLoading extends MedicalRecordsState {}
class RadiationRecordLoaded extends MedicalRecordsState {
  final RadiationModel record;
  RadiationRecordLoaded(this.record);
}
class RadiationRecordError extends MedicalRecordsState {
  final String message;
  RadiationRecordError(this.message);
} 