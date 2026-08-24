// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_create_subjects_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BulkCreateSubjectsRequest _$BulkCreateSubjectsRequestFromJson(
        Map<String, dynamic> json) =>
    _BulkCreateSubjectsRequest(
      names: (json['names'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BulkCreateSubjectsRequestToJson(
        _BulkCreateSubjectsRequest instance) =>
    <String, dynamic>{
      'names': instance.names,
    };
