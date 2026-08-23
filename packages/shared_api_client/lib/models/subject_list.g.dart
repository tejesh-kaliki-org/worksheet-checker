// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubjectList _$SubjectListFromJson(Map<String, dynamic> json) => _SubjectList(
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => Subject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubjectListToJson(_SubjectList instance) =>
    <String, dynamic>{
      'subjects': instance.subjects,
    };
