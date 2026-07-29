// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';

import 'auth/auth_client.dart';
import 'health_other/health_other_client.dart';

/// Worksheet Checker API `v0.1.0`
class RestClient {
  RestClient(
    Dio dio, {
    String? baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  static String get version => '0.1.0';

  AuthClient? _auth;
  HealthOtherClient? _healthOther;

  AuthClient get auth => _auth ??= AuthClient(_dio, baseUrl: _baseUrl);

  HealthOtherClient get healthOther => _healthOther ??= HealthOtherClient(_dio, baseUrl: _baseUrl);
}
