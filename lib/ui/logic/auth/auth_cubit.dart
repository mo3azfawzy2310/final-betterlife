import 'dart:developer';

import 'package:better_life/core/EndpointConstants/endpoint_donstants.dart';
import 'package:better_life/core/cach_data/app_shared_preferences.dart';
import 'package:better_life/core/network/api_consumer.dart';
import 'package:better_life/core/network/dio_consumer.dart';
import 'package:better_life/models/regester_model.dart';
import 'package:better_life/models/user_model.dart';
import 'package:better_life/ui/logic/auth/dio_factory.dart';
import 'package:better_life/core/services/user_service.dart';
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

      // Debug: Print the signup response
      print('🔍 Signup Response:');
      print('  - Response: $response');
      print('  - Response type: ${response.runtimeType}');

      final user = UserModel.fromJson(response);
      
      // Debug: Print the created user model
      print('🔍 Created User Model:');
      print('  - User: ${user.toJson()}');
      print('  - Patient ID: ${user.patientId}');
      
      // Fetch patient details if patientId is null
      if (user.patientId == null && user.email.isNotEmpty) {
        try {
          // Get patient details by username
          final patientDetails = await UserService.getPatientByUsername(user.displayName);
          
          // Create updated user with patientId
          final updatedUser = UserModel(
            displayName: user.displayName,
            email: user.email,
            token: user.token,
            patientId: patientDetails.patientId,
          );
          
          // Save updated user model
          await AppPreferences().saveModel<UserModel>(
            'userModel',
            updatedUser,
            (u) => u.toJson(),
          );
          
          // Debug: Verify the user was saved
          print('🔍 Updated User saved to preferences with Patient ID: ${updatedUser.patientId}');
          await UserService.debugUserData();
          
          emit(AuthSuccess(updatedUser));
          return Right(updatedUser);
        } catch (e) {
          print('⚠️ Error fetching patient details: $e');
          // Continue with original user if fetch fails
        }
      }
      
      await AppPreferences().saveModel<UserModel>(
        'userModel',
        user,
        (u) => u.toJson(),
      );
      
      // Debug: Verify the user was saved
      print('🔍 User saved to preferences');
      await UserService.debugUserData();
      
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
      
      // Fetch patient details if patientId is null
      if (user.patientId == null && user.displayName.isNotEmpty) {
        try {
          // Get patient details by username
          final patientDetails = await UserService.getPatientByUsername(user.displayName);
          
          // Create updated user with patientId
          final updatedUser = UserModel(
            displayName: user.displayName,
            email: user.email,
            token: user.token,
            patientId: patientDetails.patientId,
          );
          
          // Save updated user model
          await AppPreferences().saveModel<UserModel>(
            'userModel',
            updatedUser,
            (u) => u.toJson(),
          );
          
          // Debug: Verify the user was saved with patient ID
          print('🔍 Updated User saved to preferences with Patient ID: ${updatedUser.patientId}');
          await UserService.debugUserData();
          
          emit(AuthSuccess(updatedUser));
          return Right(updatedUser);
        } catch (e) {
          print('⚠️ Error fetching patient details: $e');
          // Continue with original user if fetch fails
        }
      }

      await AppPreferences().saveModel<UserModel>(
        'userModel',
        user,
        (u) => u.toJson(),
      );
      
      // Debug: Verify the user was saved
      print('🔍 User saved to preferences');
      await UserService.debugUserData();

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
