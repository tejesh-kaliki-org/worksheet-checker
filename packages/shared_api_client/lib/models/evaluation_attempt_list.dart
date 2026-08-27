// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'evaluation_attempt.dart';

part 'evaluation_attempt_list.freezed.dart';
part 'evaluation_attempt_list.g.dart';

@Freezed()
abstract class EvaluationAttemptList with _$EvaluationAttemptList {
  const factory EvaluationAttemptList({
    @JsonKey(name: 'evaluation_attempts')
    required List<EvaluationAttempt> evaluationAttempts,
  }) = _EvaluationAttemptList;
  
  factory EvaluationAttemptList.fromJson(Map<String, Object?> json) => _$EvaluationAttemptListFromJson(json);
}
