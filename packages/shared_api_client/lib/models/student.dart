// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'student.freezed.dart';
part 'student.g.dart';

@Freezed()
abstract class Student with _$Student {
  const factory Student({
    required String id,
    @JsonKey(name: 'class_id')
    required String classId,
    required String name,
    @JsonKey(name: 'roll_number')
    required String rollNumber,
  }) = _Student;
  
  factory Student.fromJson(Map<String, Object?> json) => _$StudentFromJson(json);
}
