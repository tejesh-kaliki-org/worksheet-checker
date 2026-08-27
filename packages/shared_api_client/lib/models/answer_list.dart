// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'answer.dart';

part 'answer_list.freezed.dart';
part 'answer_list.g.dart';

@Freezed()
abstract class AnswerList with _$AnswerList {
  const factory AnswerList({
    required List<Answer> answers,
  }) = _AnswerList;
  
  factory AnswerList.fromJson(Map<String, Object?> json) => _$AnswerListFromJson(json);
}
