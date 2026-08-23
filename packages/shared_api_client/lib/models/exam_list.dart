// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'exam.dart';

part 'exam_list.freezed.dart';
part 'exam_list.g.dart';

@Freezed()
abstract class ExamList with _$ExamList {
  const factory ExamList({
    required List<Exam> exams,
  }) = _ExamList;
  
  factory ExamList.fromJson(Map<String, Object?> json) => _$ExamListFromJson(json);
}
