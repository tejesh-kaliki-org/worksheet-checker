// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_subject_request.freezed.dart';
part 'update_subject_request.g.dart';

@Freezed()
abstract class UpdateSubjectRequest with _$UpdateSubjectRequest {
  const factory UpdateSubjectRequest({
    required String name,
  }) = _UpdateSubjectRequest;
  
  factory UpdateSubjectRequest.fromJson(Map<String, Object?> json) => _$UpdateSubjectRequestFromJson(json);
}
