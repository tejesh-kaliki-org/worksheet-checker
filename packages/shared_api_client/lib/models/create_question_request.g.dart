// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_question_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateQuestionRequest _$CreateQuestionRequestFromJson(
        Map<String, dynamic> json) =>
    _CreateQuestionRequest(
      type: QuestionType.fromJson(json['type'] as String),
      config: json['config'],
      maximumMarks: (json['maximum_marks'] as num).toDouble(),
    );

Map<String, dynamic> _$CreateQuestionRequestToJson(
        _CreateQuestionRequest instance) =>
    <String, dynamic>{
      'type': _$QuestionTypeEnumMap[instance.type]!,
      'config': instance.config,
      'maximum_marks': instance.maximumMarks,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.mcq: 'mcq',
  QuestionType.trueFalse: 'true_false',
  QuestionType.numeric: 'numeric',
  QuestionType.fillIn: 'fill_in',
  QuestionType.openResponse: 'open_response',
  QuestionType.$unknown: r'$unknown',
};
