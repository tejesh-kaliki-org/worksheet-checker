// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_answer_request.freezed.dart';
part 'update_answer_request.g.dart';

@Freezed()
abstract class UpdateAnswerRequest with _$UpdateAnswerRequest {
  const factory UpdateAnswerRequest({
    @JsonKey(name: 'raw_answer')
    required String rawAnswer,
  }) = _UpdateAnswerRequest;
  
  factory UpdateAnswerRequest.fromJson(Map<String, Object?> json) => _$UpdateAnswerRequestFromJson(json);
}
