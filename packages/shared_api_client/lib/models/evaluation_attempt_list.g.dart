// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluation_attempt_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EvaluationAttemptList _$EvaluationAttemptListFromJson(
        Map<String, dynamic> json) =>
    _EvaluationAttemptList(
      evaluationAttempts: (json['evaluation_attempts'] as List<dynamic>)
          .map((e) => EvaluationAttempt.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EvaluationAttemptListToJson(
        _EvaluationAttemptList instance) =>
    <String, dynamic>{
      'evaluation_attempts': instance.evaluationAttempts,
    };
