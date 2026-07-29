// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_health_response.freezed.dart';
part 'get_health_response.g.dart';

@Freezed()
abstract class GetHealthResponse with _$GetHealthResponse {
  const factory GetHealthResponse({
    String? status,
  }) = _GetHealthResponse;
  
  factory GetHealthResponse.fromJson(Map<String, Object?> json) => _$GetHealthResponseFromJson(json);
}
