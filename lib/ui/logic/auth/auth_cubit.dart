import 'dart:developer';

import 'package:better_life/core/EndpointConstants/endpoint_donstants.dart';
import 'package:better_life/core/cach_data/app_shared_preferences.dart';
import 'package:better_life/core/network/api_consumer.dart';
import 'package:better_life/core/network/dio_consumer.dart';
import 'package:better_life/models/regester_model.dart';
import 'package:better_life/models/user_model.dart';
import 'package:better_life/ui/logic/auth/dio_factory.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiConsumer api = DioFactory.getDioConsumer();

  AuthCubit() : super(AuthInitial());

  Future<Either<String, UserModel>> registerUser(
      RegisterRequestModel data) async {
    emit(AuthLoading());
    try {
      final response = await api.post(
        EndpointConstants.register,
        body: data.toJson(),
      );

      final user = UserModel.fromJson(response);
      await AppPreferences().saveModel<UserModel>(
        'userModel',
        user,
        (u) => u.toJson(),
      );
      log("User registered successfully: ${user.toJson()}");
      emit(AuthSuccess(user));
      return Right(user);
    } catch (e) {
      log("Error during registration://///////// $e");
      emit(AuthFailure(e.toString()));

      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> loginUser({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final response = await api.post(
        EndpointConstants.login,
        body: {"email": email, "password": password, "role": "Patient"},
      );

      final user = UserModel.fromJson(response);

      await AppPreferences().saveModel<UserModel>(
        'userModel',
        user,
        (u) => u.toJson(),
      );

      emit(AuthSuccess(user));
      return Right(user);
    } catch (e) {
      emit(AuthFailure(e.toString()));
      return Left(
        e.toString(),
      );
    }
  }
}
