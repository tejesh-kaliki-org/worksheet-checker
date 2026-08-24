// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_subject_request.freezed.dart';
part 'create_subject_request.g.dart';

@Freezed()
abstract class CreateSubjectRequest with _$CreateSubjectRequest {
  const factory CreateSubjectRequest({
    required String name,
  }) = _CreateSubjectRequest;
  
  factory CreateSubjectRequest.fromJson(Map<String, Object?> json) => _$CreateSubjectRequestFromJson(json);
}
