// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'submission.freezed.dart';
part 'submission.g.dart';

@Freezed()
abstract class Submission with _$Submission {
  const factory Submission({
    required String id,
    @JsonKey(name: 'exam_subject_id')
    required String examSubjectId,
    @JsonKey(name: 'student_id')
    required String studentId,
  }) = _Submission;
  
  factory Submission.fromJson(Map<String, Object?> json) => _$SubmissionFromJson(json);
}
