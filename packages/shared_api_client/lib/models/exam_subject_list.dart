// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'exam_subject.dart';

part 'exam_subject_list.freezed.dart';
part 'exam_subject_list.g.dart';

@Freezed()
abstract class ExamSubjectList with _$ExamSubjectList {
  const factory ExamSubjectList({
    @JsonKey(name: 'exam_subjects')
    required List<ExamSubject> examSubjects,
  }) = _ExamSubjectList;
  
  factory ExamSubjectList.fromJson(Map<String, Object?> json) => _$ExamSubjectListFromJson(json);
}
