// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Answer _$AnswerFromJson(Map<String, dynamic> json) => _Answer(
      id: json['id'] as String,
      submissionId: json['submission_id'] as String,
      questionId: json['question_id'] as String,
      rawAnswer: json['raw_answer'] as String,
    );

Map<String, dynamic> _$AnswerToJson(_Answer instance) => <String, dynamic>{
      'id': instance.id,
      'submission_id': instance.submissionId,
      'question_id': instance.questionId,
      'raw_answer': instance.rawAnswer,
    };
