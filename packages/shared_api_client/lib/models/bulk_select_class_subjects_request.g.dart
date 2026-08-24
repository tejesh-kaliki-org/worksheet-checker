// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_select_class_subjects_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BulkSelectClassSubjectsRequest _$BulkSelectClassSubjectsRequestFromJson(
        Map<String, dynamic> json) =>
    _BulkSelectClassSubjectsRequest(
      subjectIds: (json['subject_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$BulkSelectClassSubjectsRequestToJson(
        _BulkSelectClassSubjectsRequest instance) =>
    <String, dynamic>{
      'subject_ids': instance.subjectIds,
    };
