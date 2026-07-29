// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_reset_confirm.freezed.dart';
part 'password_reset_confirm.g.dart';

@Freezed()
abstract class PasswordResetConfirm with _$PasswordResetConfirm {
  const factory PasswordResetConfirm({
    required String email,
    required String code,

    /// 8-72 characters with an uppercase letter, a lowercase letter, a digit, and a symbol; no leading or trailing whitespace.
    required String password,
  }) = _PasswordResetConfirm;
  
  factory PasswordResetConfirm.fromJson(Map<String, Object?> json) => _$PasswordResetConfirmFromJson(json);
}
