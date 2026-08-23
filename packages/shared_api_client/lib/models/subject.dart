// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject.freezed.dart';
part 'subject.g.dart';

@Freezed()
abstract class Subject with _$Subject {
  const factory Subject({
    required String id,
    required String name,
  }) = _Subject;
  
  factory Subject.fromJson(Map<String, Object?> json) => _$SubjectFromJson(json);
}
