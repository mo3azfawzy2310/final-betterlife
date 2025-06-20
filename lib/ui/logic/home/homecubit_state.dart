part of 'homecubit_cubit.dart';

abstract class HomecubitState extends Equatable {
  const HomecubitState();

  @override
  List<Object> get props => [];
}

class HomecubitInitial extends HomecubitState {}

class HomecubitSuccess extends HomecubitState {}

class HomecubitFailure extends HomecubitState {
  final String message;

  HomecubitFailure(this.message);
}

class HomecubitLoding extends HomecubitState {}
