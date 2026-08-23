// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_answers_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudentAnswersInput _$StudentAnswersInputFromJson(Map<String, dynamic> json) =>
    _StudentAnswersInput(
      studentId: json['student_id'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnswerInput.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StudentAnswersInputToJson(
        _StudentAnswersInput instance) =>
    <String, dynamic>{
      'student_id': instance.studentId,
      'answers': instance.answers,
    };
