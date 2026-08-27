// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_input.freezed.dart';
part 'answer_input.g.dart';

@Freezed()
abstract class AnswerInput with _$AnswerInput {
  const factory AnswerInput({
    @JsonKey(name: 'question_id')
    required String questionId,
    @JsonKey(name: 'raw_answer')
    required String rawAnswer,
  }) = _AnswerInput;
  
  factory AnswerInput.fromJson(Map<String, Object?> json) => _$AnswerInputFromJson(json);
}
