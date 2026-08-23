// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'evaluation_purpose.dart';

part 'create_evaluation_attempt_request.freezed.dart';
part 'create_evaluation_attempt_request.g.dart';

@Freezed()
abstract class CreateEvaluationAttemptRequest with _$CreateEvaluationAttemptRequest {
  const factory CreateEvaluationAttemptRequest({
    EvaluationPurpose? purpose,
  }) = _CreateEvaluationAttemptRequest;
  
  factory CreateEvaluationAttemptRequest.fromJson(Map<String, Object?> json) => _$CreateEvaluationAttemptRequestFromJson(json);
}
