// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// Whether an Evaluation Attempt counts toward a Student's real grade (`scoring`) or exists only for offline comparison (`experiment`) -- see CONTEXT.md.
@JsonEnum()
enum EvaluationPurpose {
  @JsonValue('scoring')
  scoring('scoring'),
  @JsonValue('experiment')
  experiment('experiment'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const EvaluationPurpose(this.json);

  factory EvaluationPurpose.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;

  @override
  String toString() => json?.toString() ?? super.toString();
  /// Returns all defined enum values excluding the $unknown value.
  static List<EvaluationPurpose> get $valuesDefined => values.where((value) => value != $unknown).toList();
}
