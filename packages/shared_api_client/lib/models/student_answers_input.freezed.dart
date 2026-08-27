// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_answers_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudentAnswersInput {
  @JsonKey(name: 'student_id')
  String get studentId;
  List<AnswerInput> get answers;

  /// Create a copy of StudentAnswersInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StudentAnswersInputCopyWith<StudentAnswersInput> get copyWith =>
      _$StudentAnswersInputCopyWithImpl<StudentAnswersInput>(
          this as StudentAnswersInput, _$identity);

  /// Serializes this StudentAnswersInput to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StudentAnswersInput &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            const DeepCollectionEquality().equals(other.answers, answers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, studentId, const DeepCollectionEquality().hash(answers));

  @override
  String toString() {
    return 'StudentAnswersInput(studentId: $studentId, answers: $answers)';
  }
}

/// @nodoc
abstract mixin class $StudentAnswersInputCopyWith<$Res> {
  factory $StudentAnswersInputCopyWith(
          StudentAnswersInput value, $Res Function(StudentAnswersInput) _then) =
      _$StudentAnswersInputCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'student_id') String studentId,
      List<AnswerInput> answers});
}

/// @nodoc
class _$StudentAnswersInputCopyWithImpl<$Res>
    implements $StudentAnswersInputCopyWith<$Res> {
  _$StudentAnswersInputCopyWithImpl(this._self, this._then);

  final StudentAnswersInput _self;
  final $Res Function(StudentAnswersInput) _then;

  /// Create a copy of StudentAnswersInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? answers = null,
  }) {
    return _then(_self.copyWith(
      studentId: null == studentId
          ? _self.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _self.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<AnswerInput>,
    ));
  }
}

/// Adds pattern-matching-related methods to [StudentAnswersInput].
extension StudentAnswersInputPatterns on StudentAnswersInput {
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
    TResult Function(_StudentAnswersInput value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StudentAnswersInput() when $default != null:
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
    TResult Function(_StudentAnswersInput value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudentAnswersInput():
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
    TResult? Function(_StudentAnswersInput value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudentAnswersInput() when $default != null:
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
    TResult Function(@JsonKey(name: 'student_id') String studentId,
            List<AnswerInput> answers)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StudentAnswersInput() when $default != null:
        return $default(_that.studentId, _that.answers);
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
    TResult Function(@JsonKey(name: 'student_id') String studentId,
            List<AnswerInput> answers)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudentAnswersInput():
        return $default(_that.studentId, _that.answers);
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
    TResult? Function(@JsonKey(name: 'student_id') String studentId,
            List<AnswerInput> answers)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudentAnswersInput() when $default != null:
        return $default(_that.studentId, _that.answers);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StudentAnswersInput implements StudentAnswersInput {
  const _StudentAnswersInput(
      {@JsonKey(name: 'student_id') required this.studentId,
      required final List<AnswerInput> answers})
      : _answers = answers;
  factory _StudentAnswersInput.fromJson(Map<String, dynamic> json) =>
      _$StudentAnswersInputFromJson(json);

  @override
  @JsonKey(name: 'student_id')
  final String studentId;
  final List<AnswerInput> _answers;
  @override
  List<AnswerInput> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  /// Create a copy of StudentAnswersInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StudentAnswersInputCopyWith<_StudentAnswersInput> get copyWith =>
      __$StudentAnswersInputCopyWithImpl<_StudentAnswersInput>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StudentAnswersInputToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StudentAnswersInput &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            const DeepCollectionEquality().equals(other._answers, _answers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, studentId, const DeepCollectionEquality().hash(_answers));

  @override
  String toString() {
    return 'StudentAnswersInput(studentId: $studentId, answers: $answers)';
  }
}

/// @nodoc
abstract mixin class _$StudentAnswersInputCopyWith<$Res>
    implements $StudentAnswersInputCopyWith<$Res> {
  factory _$StudentAnswersInputCopyWith(_StudentAnswersInput value,
          $Res Function(_StudentAnswersInput) _then) =
      __$StudentAnswersInputCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'student_id') String studentId,
      List<AnswerInput> answers});
}

/// @nodoc
class __$StudentAnswersInputCopyWithImpl<$Res>
    implements _$StudentAnswersInputCopyWith<$Res> {
  __$StudentAnswersInputCopyWithImpl(this._self, this._then);

  final _StudentAnswersInput _self;
  final $Res Function(_StudentAnswersInput) _then;

  /// Create a copy of StudentAnswersInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? studentId = null,
    Object? answers = null,
  }) {
    return _then(_StudentAnswersInput(
      studentId: null == studentId
          ? _self.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _self._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<AnswerInput>,
    ));
  }
}

// dart format on
