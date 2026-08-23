// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExamList _$ExamListFromJson(Map<String, dynamic> json) => _ExamList(
      exams: (json['exams'] as List<dynamic>)
          .map((e) => Exam.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamListToJson(_ExamList instance) => <String, dynamic>{
      'exams': instance.exams,
    };
