// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'create_student_request.dart';

part 'bulk_upload_students_request.freezed.dart';
part 'bulk_upload_students_request.g.dart';

@Freezed()
abstract class BulkUploadStudentsRequest with _$BulkUploadStudentsRequest {
  const factory BulkUploadStudentsRequest({
    required List<CreateStudentRequest> students,
  }) = _BulkUploadStudentsRequest;
  
  factory BulkUploadStudentsRequest.fromJson(Map<String, Object?> json) => _$BulkUploadStudentsRequestFromJson(json);
}
