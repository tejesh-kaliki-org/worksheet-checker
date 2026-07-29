// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_request.freezed.dart';
part 'signup_request.g.dart';

@Freezed()
abstract class SignupRequest with _$SignupRequest {
  const factory SignupRequest({
    required String email,

    /// 8-72 characters with an uppercase letter, a lowercase letter, a digit, and a symbol; no leading or trailing whitespace.
    required String password,
    String? name,
  }) = _SignupRequest;
  
  factory SignupRequest.fromJson(Map<String, Object?> json) => _$SignupRequestFromJson(json);
}
