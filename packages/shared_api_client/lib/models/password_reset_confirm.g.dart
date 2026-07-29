// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_confirm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PasswordResetConfirm _$PasswordResetConfirmFromJson(
        Map<String, dynamic> json) =>
    _PasswordResetConfirm(
      email: json['email'] as String,
      code: json['code'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$PasswordResetConfirmToJson(
        _PasswordResetConfirm instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
      'password': instance.password,
    };
