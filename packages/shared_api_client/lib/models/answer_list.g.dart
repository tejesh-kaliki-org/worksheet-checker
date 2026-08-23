// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnswerList _$AnswerListFromJson(Map<String, dynamic> json) => _AnswerList(
      answers: (json['answers'] as List<dynamic>)
          .map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnswerListToJson(_AnswerList instance) =>
    <String, dynamic>{
      'answers': instance.answers,
    };
