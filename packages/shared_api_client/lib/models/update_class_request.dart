// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_class_request.freezed.dart';
part 'update_class_request.g.dart';

@Freezed()
abstract class UpdateClassRequest with _$UpdateClassRequest {
  const factory UpdateClassRequest({
    required String name,
  }) = _UpdateClassRequest;
  
  factory UpdateClassRequest.fromJson(Map<String, Object?> json) => _$UpdateClassRequestFromJson(json);
}
