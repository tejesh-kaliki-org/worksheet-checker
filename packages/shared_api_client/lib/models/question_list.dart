// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'question.dart';

part 'question_list.freezed.dart';
part 'question_list.g.dart';

@Freezed()
abstract class QuestionList with _$QuestionList {
  const factory QuestionList({
    required List<Question> questions,
  }) = _QuestionList;
  
  factory QuestionList.fromJson(Map<String, Object?> json) => _$QuestionListFromJson(json);
}
