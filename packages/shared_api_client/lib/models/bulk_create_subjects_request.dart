// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'bulk_create_subjects_request.freezed.dart';
part 'bulk_create_subjects_request.g.dart';

@Freezed()
abstract class BulkCreateSubjectsRequest with _$BulkCreateSubjectsRequest {
  const factory BulkCreateSubjectsRequest({
    required List<String> names,
  }) = _BulkCreateSubjectsRequest;
  
  factory BulkCreateSubjectsRequest.fromJson(Map<String, Object?> json) => _$BulkCreateSubjectsRequestFromJson(json);
}
