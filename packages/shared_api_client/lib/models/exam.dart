// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam.freezed.dart';
part 'exam.g.dart';

@Freezed()
abstract class Exam with _$Exam {
  const factory Exam({
    required String id,
    @JsonKey(name: 'class_id')
    required String classId,
    required String label,
    @JsonKey(name: 'created_at')
    required DateTime createdAt,
  }) = _Exam;
  
  factory Exam.fromJson(Map<String, Object?> json) => _$ExamFromJson(json);
}
