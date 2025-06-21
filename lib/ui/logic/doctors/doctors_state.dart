import 'package:better_life/models/doctor_model.dart';
import 'package:equatable/equatable.dart';

abstract class DoctorsState extends Equatable {
  const DoctorsState();

  @override
  List<Object> get props => [];
}

class DoctorsInitial extends DoctorsState {}

// States for multiple doctors
class DoctorsLoading extends DoctorsState {}

class DoctorsLoaded extends DoctorsState {
  final List<DoctorModel> doctors;

  const DoctorsLoaded(this.doctors);

  @override
  List<Object> get props => [doctors];
}

class DoctorsError extends DoctorsState {
  final String message;

  const DoctorsError(this.message);

  @override
  List<Object> get props => [message];
}

// States for a single doctor
class DoctorLoading extends DoctorsState {}

class DoctorLoaded extends DoctorsState {
  final DoctorModel doctor;

  const DoctorLoaded(this.doctor);

  @override
  List<Object> get props => [doctor];
}

class DoctorError extends DoctorsState {
  final String message;

  const DoctorError(this.message);

  @override
  List<Object> get props => [message];
}

// States for favorite doctors
class FavoriteDoctorsLoading extends DoctorsState {}

class FavoriteDoctorsLoaded extends DoctorsState {
  final List<DoctorModel> doctors;

  const FavoriteDoctorsLoaded(this.doctors);

  @override
  List<Object> get props => [doctors];
}

class FavoriteDoctorsError extends DoctorsState {
  final String message;

  const FavoriteDoctorsError(this.message);

  @override
  List<Object> get props => [message];
}
