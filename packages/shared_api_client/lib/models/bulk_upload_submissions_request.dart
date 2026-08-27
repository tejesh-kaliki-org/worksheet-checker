// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'student_answers_input.dart';

part 'bulk_upload_submissions_request.freezed.dart';
part 'bulk_upload_submissions_request.g.dart';

@Freezed()
abstract class BulkUploadSubmissionsRequest with _$BulkUploadSubmissionsRequest {
  const factory BulkUploadSubmissionsRequest({
    required List<StudentAnswersInput> submissions,
  }) = _BulkUploadSubmissionsRequest;
  
  factory BulkUploadSubmissionsRequest.fromJson(Map<String, Object?> json) => _$BulkUploadSubmissionsRequestFromJson(json);
}
