// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'class.freezed.dart';
part 'class.g.dart';

@Freezed()
abstract class Class with _$Class {
  const factory Class({
    required String id,
    required String name,
    @JsonKey(name: 'created_by')
    required String createdBy,
    @JsonKey(name: 'created_at')
    required DateTime createdAt,
  }) = _Class;
  
  factory Class.fromJson(Map<String, Object?> json) => _$ClassFromJson(json);
}
