// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_subject_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExamSubjectList _$ExamSubjectListFromJson(Map<String, dynamic> json) =>
    _ExamSubjectList(
      examSubjects: (json['exam_subjects'] as List<dynamic>)
          .map((e) => ExamSubject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamSubjectListToJson(_ExamSubjectList instance) =>
    <String, dynamic>{
      'exam_subjects': instance.examSubjects,
    };
