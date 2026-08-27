// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'question_type.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@Freezed()
abstract class Question with _$Question {
  const factory Question({
    required String id,
    @JsonKey(name: 'exam_subject_id')
    required String examSubjectId,
    required QuestionType type,

    /// Type-specific shape (see internal/questionconfig on the backend for the validated Go structs this mirrors).
    required dynamic config,
    @JsonKey(name: 'schema_version')
    required int schemaVersion,
    @JsonKey(name: 'maximum_marks')
    required double maximumMarks,
  }) = _Question;
  
  factory Question.fromJson(Map<String, Object?> json) => _$QuestionFromJson(json);
}
