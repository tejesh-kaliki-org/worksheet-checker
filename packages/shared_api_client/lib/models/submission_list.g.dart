// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubmissionList _$SubmissionListFromJson(Map<String, dynamic> json) =>
    _SubmissionList(
      submissions: (json['submissions'] as List<dynamic>)
          .map((e) => Submission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubmissionListToJson(_SubmissionList instance) =>
    <String, dynamic>{
      'submissions': instance.submissions,
    };
