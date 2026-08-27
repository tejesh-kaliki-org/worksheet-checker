// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Exam _$ExamFromJson(Map<String, dynamic> json) => _Exam(
      id: json['id'] as String,
      classId: json['class_id'] as String,
      label: json['label'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ExamToJson(_Exam instance) => <String, dynamic>{
      'id': instance.id,
      'class_id': instance.classId,
      'label': instance.label,
      'created_at': instance.createdAt.toIso8601String(),
    };
