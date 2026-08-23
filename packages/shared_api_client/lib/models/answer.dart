// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer.freezed.dart';
part 'answer.g.dart';

@Freezed()
abstract class Answer with _$Answer {
  const factory Answer({
    required String id,
    @JsonKey(name: 'submission_id')
    required String submissionId,
    @JsonKey(name: 'question_id')
    required String questionId,

    /// The Student's raw answer text/data for this Question, verbatim as entered by the teacher.
    @JsonKey(name: 'raw_answer')
    required String rawAnswer,
  }) = _Answer;
  
  factory Answer.fromJson(Map<String, Object?> json) => _$AnswerFromJson(json);
}
