// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'subject.dart';

part 'subject_list.freezed.dart';
part 'subject_list.g.dart';

@Freezed()
abstract class SubjectList with _$SubjectList {
  const factory SubjectList({
    required List<Subject> subjects,
  }) = _SubjectList;
  
  factory SubjectList.fromJson(Map<String, Object?> json) => _$SubjectListFromJson(json);
}
