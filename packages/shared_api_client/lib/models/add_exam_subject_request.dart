// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_exam_subject_request.freezed.dart';
part 'add_exam_subject_request.g.dart';

@Freezed()
abstract class AddExamSubjectRequest with _$AddExamSubjectRequest {
  const factory AddExamSubjectRequest({
    @JsonKey(name: 'subject_id')
    required String subjectId,
  }) = _AddExamSubjectRequest;
  
  factory AddExamSubjectRequest.fromJson(Map<String, Object?> json) => _$AddExamSubjectRequestFromJson(json);
}
