part of 'appointment_cubit.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object?> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentActionLoading extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final List<AppointmentModel> appointments;

  const AppointmentLoaded(this.appointments);

  @override
  List<Object?> get props => [appointments];
}

// For backward compatibility
class AppointmentsLoaded extends AppointmentState {
  final List<AppointmentModel> appointments;

  const AppointmentsLoaded(this.appointments);

  @override
  List<Object?> get props => [appointments];
}

class AppointmentBooked extends AppointmentState {
  final bool success;

  const AppointmentBooked(this.success);

  @override
  List<Object?> get props => [success];
}

class AppointmentActionSuccess extends AppointmentState {
  final String message;

  const AppointmentActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError(this.message);

  @override
  List<Object?> get props => [message];
}
