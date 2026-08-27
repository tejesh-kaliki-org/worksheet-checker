// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'question_type.dart';

part 'create_question_request.freezed.dart';
part 'create_question_request.g.dart';

@Freezed()
abstract class CreateQuestionRequest with _$CreateQuestionRequest {
  const factory CreateQuestionRequest({
    required QuestionType type,
    required dynamic config,
    @JsonKey(name: 'maximum_marks')
    required double maximumMarks,
  }) = _CreateQuestionRequest;
  
  factory CreateQuestionRequest.fromJson(Map<String, Object?> json) => _$CreateQuestionRequestFromJson(json);
}
