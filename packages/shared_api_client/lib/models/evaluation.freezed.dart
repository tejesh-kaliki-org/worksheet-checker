// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'evaluation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Evaluation {
  String get id;
  @JsonKey(name: 'evaluation_attempt_id')
  String get evaluationAttemptId;

  /// The AI's normalized judgment of correctness, 0.00-1.00.
  @JsonKey(name: 'raw_score')
  double get rawScore;

  /// raw_score x Question.Maximum Marks.
  double get marks;

  /// Targeted, student-facing prose explaining the score.
  String get feedback;

  /// Create a copy of Evaluation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EvaluationCopyWith<Evaluation> get copyWith =>
      _$EvaluationCopyWithImpl<Evaluation>(this as Evaluation, _$identity);

  /// Serializes this Evaluation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Evaluation &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.evaluationAttemptId, evaluationAttemptId) ||
                other.evaluationAttemptId == evaluationAttemptId) &&
            (identical(other.rawScore, rawScore) ||
                other.rawScore == rawScore) &&
            (identical(other.marks, marks) || other.marks == marks) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, evaluationAttemptId, rawScore, marks, feedback);

  @override
  String toString() {
    return 'Evaluation(id: $id, evaluationAttemptId: $evaluationAttemptId, rawScore: $rawScore, marks: $marks, feedback: $feedback)';
  }
}

/// @nodoc
abstract mixin class $EvaluationCopyWith<$Res> {
  factory $EvaluationCopyWith(
          Evaluation value, $Res Function(Evaluation) _then) =
      _$EvaluationCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'evaluation_attempt_id') String evaluationAttemptId,
      @JsonKey(name: 'raw_score') double rawScore,
      double marks,
      String feedback});
}

/// @nodoc
class _$EvaluationCopyWithImpl<$Res> implements $EvaluationCopyWith<$Res> {
  _$EvaluationCopyWithImpl(this._self, this._then);

  final Evaluation _self;
  final $Res Function(Evaluation) _then;

  /// Create a copy of Evaluation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? evaluationAttemptId = null,
    Object? rawScore = null,
    Object? marks = null,
    Object? feedback = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      evaluationAttemptId: null == evaluationAttemptId
          ? _self.evaluationAttemptId
          : evaluationAttemptId // ignore: cast_nullable_to_non_nullable
              as String,
      rawScore: null == rawScore
          ? _self.rawScore
          : rawScore // ignore: cast_nullable_to_non_nullable
              as double,
      marks: null == marks
          ? _self.marks
          : marks // ignore: cast_nullable_to_non_nullable
              as double,
      feedback: null == feedback
          ? _self.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Evaluation].
extension EvaluationPatterns on Evaluation {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Evaluation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Evaluation() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Evaluation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Evaluation():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Evaluation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Evaluation() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            @JsonKey(name: 'evaluation_attempt_id') String evaluationAttemptId,
            @JsonKey(name: 'raw_score') double rawScore,
            double marks,
            String feedback)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Evaluation() when $default != null:
        return $default(_that.id, _that.evaluationAttemptId, _that.rawScore,
            _that.marks, _that.feedback);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            @JsonKey(name: 'evaluation_attempt_id') String evaluationAttemptId,
            @JsonKey(name: 'raw_score') double rawScore,
            double marks,
            String feedback)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Evaluation():
        return $default(_that.id, _that.evaluationAttemptId, _that.rawScore,
            _that.marks, _that.feedback);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            @JsonKey(name: 'evaluation_attempt_id') String evaluationAttemptId,
            @JsonKey(name: 'raw_score') double rawScore,
            double marks,
            String feedback)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Evaluation() when $default != null:
        return $default(_that.id, _that.evaluationAttemptId, _that.rawScore,
            _that.marks, _that.feedback);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Evaluation implements Evaluation {
  const _Evaluation(
      {required this.id,
      @JsonKey(name: 'evaluation_attempt_id') required this.evaluationAttemptId,
      @JsonKey(name: 'raw_score') required this.rawScore,
      required this.marks,
      required this.feedback});
  factory _Evaluation.fromJson(Map<String, dynamic> json) =>
      _$EvaluationFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'evaluation_attempt_id')
  final String evaluationAttemptId;

  /// The AI's normalized judgment of correctness, 0.00-1.00.
  @override
  @JsonKey(name: 'raw_score')
  final double rawScore;

  /// raw_score x Question.Maximum Marks.
  @override
  final double marks;

  /// Targeted, student-facing prose explaining the score.
  @override
  final String feedback;

  /// Create a copy of Evaluation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EvaluationCopyWith<_Evaluation> get copyWith =>
      __$EvaluationCopyWithImpl<_Evaluation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EvaluationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Evaluation &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.evaluationAttemptId, evaluationAttemptId) ||
                other.evaluationAttemptId == evaluationAttemptId) &&
            (identical(other.rawScore, rawScore) ||
                other.rawScore == rawScore) &&
            (identical(other.marks, marks) || other.marks == marks) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, evaluationAttemptId, rawScore, marks, feedback);

  @override
  String toString() {
    return 'Evaluation(id: $id, evaluationAttemptId: $evaluationAttemptId, rawScore: $rawScore, marks: $marks, feedback: $feedback)';
  }
}

/// @nodoc
abstract mixin class _$EvaluationCopyWith<$Res>
    implements $EvaluationCopyWith<$Res> {
  factory _$EvaluationCopyWith(
          _Evaluation value, $Res Function(_Evaluation) _then) =
      __$EvaluationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'evaluation_attempt_id') String evaluationAttemptId,
      @JsonKey(name: 'raw_score') double rawScore,
      double marks,
      String feedback});
}

/// @nodoc
class __$EvaluationCopyWithImpl<$Res> implements _$EvaluationCopyWith<$Res> {
  __$EvaluationCopyWithImpl(this._self, this._then);

  final _Evaluation _self;
  final $Res Function(_Evaluation) _then;

  /// Create a copy of Evaluation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? evaluationAttemptId = null,
    Object? rawScore = null,
    Object? marks = null,
    Object? feedback = null,
  }) {
    return _then(_Evaluation(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      evaluationAttemptId: null == evaluationAttemptId
          ? _self.evaluationAttemptId
          : evaluationAttemptId // ignore: cast_nullable_to_non_nullable
              as String,
      rawScore: null == rawScore
          ? _self.rawScore
          : rawScore // ignore: cast_nullable_to_non_nullable
              as double,
      marks: null == marks
          ? _self.marks
          : marks // ignore: cast_nullable_to_non_nullable
              as double,
      feedback: null == feedback
          ? _self.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
