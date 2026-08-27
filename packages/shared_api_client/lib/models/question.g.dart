// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Question _$QuestionFromJson(Map<String, dynamic> json) => _Question(
      id: json['id'] as String,
      examSubjectId: json['exam_subject_id'] as String,
      type: QuestionType.fromJson(json['type'] as String),
      config: json['config'],
      schemaVersion: (json['schema_version'] as num).toInt(),
      maximumMarks: (json['maximum_marks'] as num).toDouble(),
    );

Map<String, dynamic> _$QuestionToJson(_Question instance) => <String, dynamic>{
      'id': instance.id,
      'exam_subject_id': instance.examSubjectId,
      'type': _$QuestionTypeEnumMap[instance.type]!,
      'config': instance.config,
      'schema_version': instance.schemaVersion,
      'maximum_marks': instance.maximumMarks,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.mcq: 'mcq',
  QuestionType.trueFalse: 'true_false',
  QuestionType.numeric: 'numeric',
  QuestionType.fillIn: 'fill_in',
  QuestionType.openResponse: 'open_response',
  QuestionType.$unknown: r'$unknown',
};
