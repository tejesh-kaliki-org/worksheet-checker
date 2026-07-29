// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) =>
    _SignupResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      verificationToken: json['verification_token'] as String,
    );

Map<String, dynamic> _$SignupResponseToJson(_SignupResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'verification_token': instance.verificationToken,
    };
