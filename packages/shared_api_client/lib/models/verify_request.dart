// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_request.freezed.dart';
part 'verify_request.g.dart';

@Freezed()
abstract class VerifyRequest with _$VerifyRequest {
  const factory VerifyRequest({
    /// Short-lived token returned by /auth/signup; scopes the OTP submission.
    @JsonKey(name: 'verification_token')
    required String verificationToken,
    required String code,
  }) = _VerifyRequest;
  
  factory VerifyRequest.fromJson(Map<String, Object?> json) => _$VerifyRequestFromJson(json);
}
