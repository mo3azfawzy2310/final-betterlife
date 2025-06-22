import 'dart:developer';

import 'package:better_life/core/EndpointConstants/endpoint_donstants.dart';
import 'package:better_life/core/cach_data/app_shared_preferences.dart';
import 'package:better_life/core/network/api_consumer.dart';
import 'package:better_life/core/network/dio_consumer.dart';
import 'package:better_life/core/services/auth_service.dart';
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
  final AuthService _authService = AuthService();

  AuthCubit() : super(AuthInitial());

  // Check if user is logged in
  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      final isLoggedIn = await _authService.isLoggedIn();
      
      if (isLoggedIn) {
        final user = await _authService.getCurrentUser();
        if (user != null) {
          emit(AuthSuccess(user));
        } else {
          emit(AuthInitial());
        }
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Register a new user
  Future<Either<String, UserModel>> registerUser(RegisterRequestModel data) async {
    emit(AuthLoading());
    try {
      final user = await _authService.register(data);
      
      // Try to fetch patient ID if missing
      if (user.patientId == null) {
        try {
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
          
          emit(AuthSuccess(updatedUser));
          return Right(updatedUser);
        } catch (e) {
          print('⚠️ Error fetching patient details: $e');
          // Continue with original user if fetch fails
        }
      }
      
      emit(AuthSuccess(user));
      return Right(user);
    } catch (e) {
      log("Error during registration: $e");
      emit(AuthFailure(e.toString()));
      return Left(e.toString());
    }
  }

  // Login with email and password
  Future<Either<String, UserModel>> loginUser({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final user = await _authService.login(email, password);
      
      // Try to fetch patient ID if missing
      if (user.patientId == null) {
        try {
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
          
          emit(AuthSuccess(updatedUser));
          return Right(updatedUser);
        } catch (e) {
          print('⚠️ Error fetching patient details: $e');
          // Continue with original user if fetch fails
        }
      }
      
      emit(AuthSuccess(user));
      return Right(user);
    } catch (e) {
      emit(AuthFailure(e.toString()));
      return Left(e.toString());
    }
  }
  
  // Sign in with Google
  Future<Either<String, UserModel>> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final user = await _authService.signInWithGoogle();
      
      // Try to fetch patient ID if missing
      if (user.patientId == null) {
        try {
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
          
          emit(AuthSuccess(updatedUser));
          return Right(updatedUser);
        } catch (e) {
          print('⚠️ Error fetching patient details: $e');
          // Continue with original user if fetch fails
        }
      }
      
      emit(AuthSuccess(user));
      return Right(user);
    } catch (e) {
      emit(AuthFailure(e.toString()));
      return Left(e.toString());
    }
  }
  
  // Logout
  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _authService.logout();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
