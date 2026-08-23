// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_student_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateStudentRequest _$CreateStudentRequestFromJson(
        Map<String, dynamic> json) =>
    _CreateStudentRequest(
      name: json['name'] as String,
      rollNumber: json['roll_number'] as String,
    );

Map<String, dynamic> _$CreateStudentRequestToJson(
        _CreateStudentRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'roll_number': instance.rollNumber,
    };
