// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnswerInput _$AnswerInputFromJson(Map<String, dynamic> json) => _AnswerInput(
      questionId: json['question_id'] as String,
      rawAnswer: json['raw_answer'] as String,
    );

Map<String, dynamic> _$AnswerInputToJson(_AnswerInput instance) =>
    <String, dynamic>{
      'question_id': instance.questionId,
      'raw_answer': instance.rawAnswer,
    };
