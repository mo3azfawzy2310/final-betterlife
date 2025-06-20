import 'dart:developer';

import 'package:better_life/core/EndpointConstants/endpoint_donstants.dart';
import 'package:better_life/core/cach_data/app_shared_preferences.dart';
import 'package:better_life/models/user_model.dart';
import 'package:dio/dio.dart';

import 'api_consumer.dart';
import 'interceptors.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    client.options
      ..baseUrl = EndpointConstants.baseUrl
      ..responseType = ResponseType.json
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30);

    client.interceptors.add(AppInterceptors());

    client.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // options.headers['Content-Type'] = 'application/json';
          final user = await AppPreferences().getModel<UserModel>(
            'userModel',
            UserModel.fromJson,
          );

          final token = user?.token;

          log("Calling: ${options.uri}");

          if (token != null) {
            log("Authorization: Bearer $token");
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await client.get(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      if (response.data == null || response.data.toString().isEmpty) {
////////////
      }

      return response.data;
    } on DioException catch (error) {
/////////////
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await client.post(
        path,
        data: body,
        options: Options(headers: headers),
      );

      if (response.data == null || response.data.toString().isEmpty) {
        //////////
      }

      return response.data;
    } on DioException catch (error) {
      ///////////
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await client.put(
        path,
        data: body,
        options: Options(headers: headers),
      );

      if (response.data == null || response.data.toString().isEmpty) {
        /////////////
      }

      return response.data;
    } on DioException catch (error) {
      ////////////
    }
  }

  @override
  Future<dynamic> delete(String path, {Map<String, dynamic>? headers}) async {
    try {
      final response = await client.delete(
        path,
        options: Options(headers: headers),
      );

      if (response.data == null || response.data.toString().isEmpty) {
///////////////
      }

      return response.data;
    } on DioException catch (error) {
///////////
    }
  }

  String? _extractOrderId(String message) {
    if (message.contains('ID:')) {
      final regex = RegExp(r'ID: (\d+)');
      final match = regex.firstMatch(message);
      if (match != null && match.groupCount > 0) {
        return match.group(1);
      }
    }
    return null;
  }

  // AppException _handleDioError(DioException error) {
  //   final response = error.response;
  //   final statusCode = response?.statusCode ?? 0;

  //   // Check for pending order response first
  //   if (statusCode == 400 && response?.data != null) {
  //     final data = response?.data;
  //     if (data is Map<String, dynamic> &&
  //         (data['code'] == 1005 || data['info'] == 'PendingOrder' ||
  //          (data['message']?.toString().contains('pending order') == true))) {
  //       return PendingOrderException(
  //         message: data['message']?.toString() ?? 'You already have a pending order',
  //         pendingOrderId: _extractOrderId(data['message']?.toString() ?? ''),
  //         statusCode: statusCode
  //       );
  //     }
  //   }

  //   final dynamic rawMessage = response?.data?['message'];
  //   String message;

  //   if (rawMessage is List) {
  //     message = rawMessage.join('\n');
  //   } else if (rawMessage is String) {
  //     message = rawMessage;
  //   } else {
  //     message = 'Unknown Error';
  //   }

  //   switch (error.type) {
  //     case DioExceptionType.connectionTimeout:
  //     case DioExceptionType.sendTimeout:
  //     case DioExceptionType.receiveTimeout:
  //       return ServerException("Connection timeout", statusCode);
  //     case DioExceptionType.badResponse:
  //       return ServerException(message, statusCode);
  //     case DioExceptionType.unknown:
  //       return ServerException("Unexpected error occurred", statusCode);
  //     default:
  //       return ServerException("Something went wrong", statusCode);
  //   }
  // }

  Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await client.patch(
        path,
        data: body,
        options: Options(headers: headers),
      );

      if (response.data == null || response.data.toString().isEmpty) {
////////////
      }

      return response.data;
    } on DioException catch (error) {
      ///////////
    }
  }
}
