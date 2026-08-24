// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudentList _$StudentListFromJson(Map<String, dynamic> json) => _StudentList(
      students: (json['students'] as List<dynamic>)
          .map((e) => Student.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StudentListToJson(_StudentList instance) =>
    <String, dynamic>{
      'students': instance.students,
    };
