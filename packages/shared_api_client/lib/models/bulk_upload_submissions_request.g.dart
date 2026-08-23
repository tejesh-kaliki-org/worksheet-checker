// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_upload_submissions_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BulkUploadSubmissionsRequest _$BulkUploadSubmissionsRequestFromJson(
        Map<String, dynamic> json) =>
    _BulkUploadSubmissionsRequest(
      submissions: (json['submissions'] as List<dynamic>)
          .map((e) => StudentAnswersInput.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BulkUploadSubmissionsRequestToJson(
        _BulkUploadSubmissionsRequest instance) =>
    <String, dynamic>{
      'submissions': instance.submissions,
    };
