// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClassList _$ClassListFromJson(Map<String, dynamic> json) => _ClassList(
      classes: (json['classes'] as List<dynamic>)
          .map((e) => Class.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClassListToJson(_ClassList instance) =>
    <String, dynamic>{
      'classes': instance.classes,
    };
