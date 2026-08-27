// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Submission _$SubmissionFromJson(Map<String, dynamic> json) => _Submission(
      id: json['id'] as String,
      examSubjectId: json['exam_subject_id'] as String,
      studentId: json['student_id'] as String,
    );

Map<String, dynamic> _$SubmissionToJson(_Submission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exam_subject_id': instance.examSubjectId,
      'student_id': instance.studentId,
    };
