// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'student.dart';

part 'student_list.freezed.dart';
part 'student_list.g.dart';

@Freezed()
abstract class StudentList with _$StudentList {
  const factory StudentList({
    required List<Student> students,
  }) = _StudentList;
  
  factory StudentList.fromJson(Map<String, Object?> json) => _$StudentListFromJson(json);
}
