// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'bulk_select_class_subjects_request.freezed.dart';
part 'bulk_select_class_subjects_request.g.dart';

@Freezed()
abstract class BulkSelectClassSubjectsRequest with _$BulkSelectClassSubjectsRequest {
  const factory BulkSelectClassSubjectsRequest({
    @JsonKey(name: 'subject_ids')
    required List<String> subjectIds,
  }) = _BulkSelectClassSubjectsRequest;
  
  factory BulkSelectClassSubjectsRequest.fromJson(Map<String, Object?> json) => _$BulkSelectClassSubjectsRequestFromJson(json);
}
