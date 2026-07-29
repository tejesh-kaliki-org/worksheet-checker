// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Freezed()
abstract class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String name,
    required String role,
    bool? verified,
    @JsonKey(name: 'created_at')
    DateTime? createdAt,
  }) = _User;
  
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
