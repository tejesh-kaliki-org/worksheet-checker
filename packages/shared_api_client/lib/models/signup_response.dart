// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'signup_response.freezed.dart';
part 'signup_response.g.dart';

@Freezed()
abstract class SignupResponse with _$SignupResponse {
  const factory SignupResponse({
    required User user,

    /// Short-lived token identifying the just-created (unverified) account. Submit it with the emailed OTP to POST /auth/verify to obtain a session. No access/refresh token is issued until the email is verified.
    @JsonKey(name: 'verification_token')
    required String verificationToken,
  }) = _SignupResponse;
  
  factory SignupResponse.fromJson(Map<String, Object?> json) => _$SignupResponseFromJson(json);
}
