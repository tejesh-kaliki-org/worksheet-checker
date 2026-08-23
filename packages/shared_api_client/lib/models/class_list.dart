// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'class.dart';

part 'class_list.freezed.dart';
part 'class_list.g.dart';

@Freezed()
abstract class ClassList with _$ClassList {
  const factory ClassList({
    required List<Class> classes,
  }) = _ClassList;
  
  factory ClassList.fromJson(Map<String, Object?> json) => _$ClassListFromJson(json);
}
