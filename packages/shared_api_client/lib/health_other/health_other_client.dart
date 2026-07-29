// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/get_health_response.dart';

part 'health_other_client.g.dart';

@RestApi()
abstract class HealthOtherClient {
  factory HealthOtherClient(Dio dio, {String? baseUrl}) = _HealthOtherClient;

  /// Liveness probe
  @GET('/health')
  Future<GetHealthResponse> getHealth({
    @DioOptions() RequestOptions? options,
  });
}
