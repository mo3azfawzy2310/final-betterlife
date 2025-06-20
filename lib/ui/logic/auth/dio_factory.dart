import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/network/api_consumer.dart';
import '../../../core/network/dio_consumer.dart';

class DioFactory {
  static ApiConsumer getDioConsumer() {
    final Dio dio = Dio();
    return DioConsumer(client: dio);
  }
}
