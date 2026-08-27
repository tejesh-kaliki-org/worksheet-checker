// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_subject.freezed.dart';
part 'exam_subject.g.dart';

@Freezed()
abstract class ExamSubject with _$ExamSubject {
  const factory ExamSubject({
    required String id,
    @JsonKey(name: 'exam_id')
    required String examId,
    @JsonKey(name: 'subject_id')
    required String subjectId,
  }) = _ExamSubject;
  
  factory ExamSubject.fromJson(Map<String, Object?> json) => _$ExamSubjectFromJson(json);
}
