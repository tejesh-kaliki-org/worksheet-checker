// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_student_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateStudentRequest _$UpdateStudentRequestFromJson(
        Map<String, dynamic> json) =>
    _UpdateStudentRequest(
      name: json['name'] as String,
      rollNumber: json['roll_number'] as String,
    );

Map<String, dynamic> _$UpdateStudentRequestToJson(
        _UpdateStudentRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'roll_number': instance.rollNumber,
    };
