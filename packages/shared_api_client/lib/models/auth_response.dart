// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@Freezed()
abstract class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    /// Short-lived access token (JWT).
    required String token,

    /// Long-lived, revocable refresh token. Rotated on each use.
    @JsonKey(name: 'refresh_token')
    required String refreshToken,
    required User user,
  }) = _AuthResponse;
  
  factory AuthResponse.fromJson(Map<String, Object?> json) => _$AuthResponseFromJson(json);
}
