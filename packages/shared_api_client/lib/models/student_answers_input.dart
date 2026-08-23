// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'answer_input.dart';

part 'student_answers_input.freezed.dart';
part 'student_answers_input.g.dart';

@Freezed()
abstract class StudentAnswersInput with _$StudentAnswersInput {
  const factory StudentAnswersInput({
    @JsonKey(name: 'student_id')
    required String studentId,
    required List<AnswerInput> answers,
  }) = _StudentAnswersInput;
  
  factory StudentAnswersInput.fromJson(Map<String, Object?> json) => _$StudentAnswersInputFromJson(json);
}
