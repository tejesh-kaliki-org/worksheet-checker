// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExamSubject _$ExamSubjectFromJson(Map<String, dynamic> json) => _ExamSubject(
      id: json['id'] as String,
      examId: json['exam_id'] as String,
      subjectId: json['subject_id'] as String,
    );

Map<String, dynamic> _$ExamSubjectToJson(_ExamSubject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exam_id': instance.examId,
      'subject_id': instance.subjectId,
    };
