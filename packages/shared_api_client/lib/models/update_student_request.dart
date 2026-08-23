// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_student_request.freezed.dart';
part 'update_student_request.g.dart';

@Freezed()
abstract class UpdateStudentRequest with _$UpdateStudentRequest {
  const factory UpdateStudentRequest({
    required String name,
    @JsonKey(name: 'roll_number')
    required String rollNumber,
  }) = _UpdateStudentRequest;
  
  factory UpdateStudentRequest.fromJson(Map<String, Object?> json) => _$UpdateStudentRequestFromJson(json);
}
