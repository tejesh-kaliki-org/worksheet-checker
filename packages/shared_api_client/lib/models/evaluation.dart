// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'evaluation.freezed.dart';
part 'evaluation.g.dart';

@Freezed()
abstract class Evaluation with _$Evaluation {
  const factory Evaluation({
    required String id,
    @JsonKey(name: 'evaluation_attempt_id')
    required String evaluationAttemptId,

    /// The AI's normalized judgment of correctness, 0.00-1.00.
    @JsonKey(name: 'raw_score')
    required double rawScore,

    /// raw_score x Question.Maximum Marks.
    required double marks,

    /// Targeted, student-facing prose explaining the score.
    required String feedback,
  }) = _Evaluation;
  
  factory Evaluation.fromJson(Map<String, Object?> json) => _$EvaluationFromJson(json);
}
