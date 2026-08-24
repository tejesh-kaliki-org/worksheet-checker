// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_student_request.freezed.dart';
part 'create_student_request.g.dart';

@Freezed()
abstract class CreateStudentRequest with _$CreateStudentRequest {
  const factory CreateStudentRequest({
    required String name,
    @JsonKey(name: 'roll_number')
    required String rollNumber,
  }) = _CreateStudentRequest;
  
  factory CreateStudentRequest.fromJson(Map<String, Object?> json) => _$CreateStudentRequestFromJson(json);
}
