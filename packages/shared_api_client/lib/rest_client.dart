// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';

import 'auth/auth_client.dart';
import 'classes/classes_client.dart';
import 'health_other/health_other_client.dart';
import 'students/students_client.dart';
import 'subjects/subjects_client.dart';

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
  ClassesClient? _classes;
  HealthOtherClient? _healthOther;
  StudentsClient? _students;
  SubjectsClient? _subjects;

  AuthClient get auth => _auth ??= AuthClient(_dio, baseUrl: _baseUrl);

  ClassesClient get classes => _classes ??= ClassesClient(_dio, baseUrl: _baseUrl);

  HealthOtherClient get healthOther => _healthOther ??= HealthOtherClient(_dio, baseUrl: _baseUrl);

  StudentsClient get students => _students ??= StudentsClient(_dio, baseUrl: _baseUrl);

  SubjectsClient get subjects => _subjects ??= SubjectsClient(_dio, baseUrl: _baseUrl);
}
