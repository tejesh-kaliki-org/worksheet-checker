// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'question_type.dart';

part 'update_question_request.freezed.dart';
part 'update_question_request.g.dart';

@Freezed()
abstract class UpdateQuestionRequest with _$UpdateQuestionRequest {
  const factory UpdateQuestionRequest({
    required QuestionType type,
    required dynamic config,
    @JsonKey(name: 'maximum_marks')
    required double maximumMarks,
  }) = _UpdateQuestionRequest;
  
  factory UpdateQuestionRequest.fromJson(Map<String, Object?> json) => _$UpdateQuestionRequestFromJson(json);
}
