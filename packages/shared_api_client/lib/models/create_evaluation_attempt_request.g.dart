// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_evaluation_attempt_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateEvaluationAttemptRequest _$CreateEvaluationAttemptRequestFromJson(
        Map<String, dynamic> json) =>
    _CreateEvaluationAttemptRequest(
      purpose: json['purpose'] == null
          ? null
          : EvaluationPurpose.fromJson(json['purpose'] as String),
    );

Map<String, dynamic> _$CreateEvaluationAttemptRequestToJson(
        _CreateEvaluationAttemptRequest instance) =>
    <String, dynamic>{
      'purpose': _$EvaluationPurposeEnumMap[instance.purpose],
    };

const _$EvaluationPurposeEnumMap = {
  EvaluationPurpose.scoring: 'scoring',
  EvaluationPurpose.experiment: 'experiment',
  EvaluationPurpose.$unknown: r'$unknown',
};
