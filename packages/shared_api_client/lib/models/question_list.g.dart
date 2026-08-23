// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuestionList _$QuestionListFromJson(Map<String, dynamic> json) =>
    _QuestionList(
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionListToJson(_QuestionList instance) =>
    <String, dynamic>{
      'questions': instance.questions,
    };
