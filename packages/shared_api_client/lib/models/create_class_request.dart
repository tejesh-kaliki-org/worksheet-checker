// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_class_request.freezed.dart';
part 'create_class_request.g.dart';

@Freezed()
abstract class CreateClassRequest with _$CreateClassRequest {
  const factory CreateClassRequest({
    required String name,
  }) = _CreateClassRequest;
  
  factory CreateClassRequest.fromJson(Map<String, Object?> json) => _$CreateClassRequestFromJson(json);
}
