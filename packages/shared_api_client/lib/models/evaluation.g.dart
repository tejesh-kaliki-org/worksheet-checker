// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Evaluation _$EvaluationFromJson(Map<String, dynamic> json) => _Evaluation(
      id: json['id'] as String,
      evaluationAttemptId: json['evaluation_attempt_id'] as String,
      rawScore: (json['raw_score'] as num).toDouble(),
      marks: (json['marks'] as num).toDouble(),
      feedback: json['feedback'] as String,
    );

Map<String, dynamic> _$EvaluationToJson(_Evaluation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'evaluation_attempt_id': instance.evaluationAttemptId,
      'raw_score': instance.rawScore,
      'marks': instance.marks,
      'feedback': instance.feedback,
    };
