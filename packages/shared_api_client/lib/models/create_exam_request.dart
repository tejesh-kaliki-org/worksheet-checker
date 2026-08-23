// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_exam_request.freezed.dart';
part 'create_exam_request.g.dart';

@Freezed()
abstract class CreateExamRequest with _$CreateExamRequest {
  const factory CreateExamRequest({
    required String label,
  }) = _CreateExamRequest;
  
  factory CreateExamRequest.fromJson(Map<String, Object?> json) => _$CreateExamRequestFromJson(json);
}
