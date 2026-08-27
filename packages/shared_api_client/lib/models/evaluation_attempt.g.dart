// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluation_attempt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EvaluationAttempt _$EvaluationAttemptFromJson(Map<String, dynamic> json) =>
    _EvaluationAttempt(
      id: json['id'] as String,
      answerId: json['answer_id'] as String,
      status: EvaluationAttemptStatus.fromJson(json['status'] as String),
      purpose: EvaluationPurpose.fromJson(json['purpose'] as String),
      error: json['error'] as String?,
      evaluation: json['evaluation'] == null
          ? null
          : Evaluation.fromJson(json['evaluation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EvaluationAttemptToJson(_EvaluationAttempt instance) =>
    <String, dynamic>{
      'id': instance.id,
      'answer_id': instance.answerId,
      'status': _$EvaluationAttemptStatusEnumMap[instance.status]!,
      'purpose': _$EvaluationPurposeEnumMap[instance.purpose]!,
      'error': instance.error,
      'evaluation': instance.evaluation,
    };

const _$EvaluationAttemptStatusEnumMap = {
  EvaluationAttemptStatus.pending: 'pending',
  EvaluationAttemptStatus.running: 'running',
  EvaluationAttemptStatus.succeeded: 'succeeded',
  EvaluationAttemptStatus.failed: 'failed',
  EvaluationAttemptStatus.$unknown: r'$unknown',
};

const _$EvaluationPurposeEnumMap = {
  EvaluationPurpose.scoring: 'scoring',
  EvaluationPurpose.experiment: 'experiment',
  EvaluationPurpose.$unknown: r'$unknown',
};
