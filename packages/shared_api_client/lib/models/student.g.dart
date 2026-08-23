// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Student _$StudentFromJson(Map<String, dynamic> json) => _Student(
      id: json['id'] as String,
      classId: json['class_id'] as String,
      name: json['name'] as String,
      rollNumber: json['roll_number'] as String,
    );

Map<String, dynamic> _$StudentToJson(_Student instance) => <String, dynamic>{
      'id': instance.id,
      'class_id': instance.classId,
      'name': instance.name,
      'roll_number': instance.rollNumber,
    };
