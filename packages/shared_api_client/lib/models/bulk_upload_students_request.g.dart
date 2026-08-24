// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_upload_students_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BulkUploadStudentsRequest _$BulkUploadStudentsRequestFromJson(
        Map<String, dynamic> json) =>
    _BulkUploadStudentsRequest(
      students: (json['students'] as List<dynamic>)
          .map((e) => CreateStudentRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BulkUploadStudentsRequestToJson(
        _BulkUploadStudentsRequest instance) =>
    <String, dynamic>{
      'students': instance.students,
    };
