// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'evaluation.dart';
import 'evaluation_attempt_status.dart';
import 'evaluation_purpose.dart';

part 'evaluation_attempt.freezed.dart';
part 'evaluation_attempt.g.dart';

@Freezed()
abstract class EvaluationAttempt with _$EvaluationAttempt {
  const factory EvaluationAttempt({
    required String id,
    @JsonKey(name: 'answer_id')
    required String answerId,
    required EvaluationAttemptStatus status,
    required EvaluationPurpose purpose,
    String? error,
    Evaluation? evaluation,
  }) = _EvaluationAttempt;
  
  factory EvaluationAttempt.fromJson(Map<String, Object?> json) => _$EvaluationAttemptFromJson(json);
}
