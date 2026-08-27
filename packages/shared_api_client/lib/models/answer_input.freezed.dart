// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'answer_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnswerInput {
  @JsonKey(name: 'question_id')
  String get questionId;
  @JsonKey(name: 'raw_answer')
  String get rawAnswer;

  /// Create a copy of AnswerInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AnswerInputCopyWith<AnswerInput> get copyWith =>
      _$AnswerInputCopyWithImpl<AnswerInput>(this as AnswerInput, _$identity);

  /// Serializes this AnswerInput to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AnswerInput &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.rawAnswer, rawAnswer) ||
                other.rawAnswer == rawAnswer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, questionId, rawAnswer);

  @override
  String toString() {
    return 'AnswerInput(questionId: $questionId, rawAnswer: $rawAnswer)';
  }
}

/// @nodoc
abstract mixin class $AnswerInputCopyWith<$Res> {
  factory $AnswerInputCopyWith(
          AnswerInput value, $Res Function(AnswerInput) _then) =
      _$AnswerInputCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'question_id') String questionId,
      @JsonKey(name: 'raw_answer') String rawAnswer});
}

/// @nodoc
class _$AnswerInputCopyWithImpl<$Res> implements $AnswerInputCopyWith<$Res> {
  _$AnswerInputCopyWithImpl(this._self, this._then);

  final AnswerInput _self;
  final $Res Function(AnswerInput) _then;

  /// Create a copy of AnswerInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? rawAnswer = null,
  }) {
    return _then(_self.copyWith(
      questionId: null == questionId
          ? _self.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      rawAnswer: null == rawAnswer
          ? _self.rawAnswer
          : rawAnswer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [AnswerInput].
extension AnswerInputPatterns on AnswerInput {
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
    TResult Function(_AnswerInput value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AnswerInput() when $default != null:
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
    TResult Function(_AnswerInput value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnswerInput():
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
    TResult? Function(_AnswerInput value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnswerInput() when $default != null:
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
    TResult Function(@JsonKey(name: 'question_id') String questionId,
            @JsonKey(name: 'raw_answer') String rawAnswer)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AnswerInput() when $default != null:
        return $default(_that.questionId, _that.rawAnswer);
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
    TResult Function(@JsonKey(name: 'question_id') String questionId,
            @JsonKey(name: 'raw_answer') String rawAnswer)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnswerInput():
        return $default(_that.questionId, _that.rawAnswer);
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
    TResult? Function(@JsonKey(name: 'question_id') String questionId,
            @JsonKey(name: 'raw_answer') String rawAnswer)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnswerInput() when $default != null:
        return $default(_that.questionId, _that.rawAnswer);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AnswerInput implements AnswerInput {
  const _AnswerInput(
      {@JsonKey(name: 'question_id') required this.questionId,
      @JsonKey(name: 'raw_answer') required this.rawAnswer});
  factory _AnswerInput.fromJson(Map<String, dynamic> json) =>
      _$AnswerInputFromJson(json);

  @override
  @JsonKey(name: 'question_id')
  final String questionId;
  @override
  @JsonKey(name: 'raw_answer')
  final String rawAnswer;

  /// Create a copy of AnswerInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AnswerInputCopyWith<_AnswerInput> get copyWith =>
      __$AnswerInputCopyWithImpl<_AnswerInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AnswerInputToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AnswerInput &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.rawAnswer, rawAnswer) ||
                other.rawAnswer == rawAnswer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, questionId, rawAnswer);

  @override
  String toString() {
    return 'AnswerInput(questionId: $questionId, rawAnswer: $rawAnswer)';
  }
}

/// @nodoc
abstract mixin class _$AnswerInputCopyWith<$Res>
    implements $AnswerInputCopyWith<$Res> {
  factory _$AnswerInputCopyWith(
          _AnswerInput value, $Res Function(_AnswerInput) _then) =
      __$AnswerInputCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'question_id') String questionId,
      @JsonKey(name: 'raw_answer') String rawAnswer});
}

/// @nodoc
class __$AnswerInputCopyWithImpl<$Res> implements _$AnswerInputCopyWith<$Res> {
  __$AnswerInputCopyWithImpl(this._self, this._then);

  final _AnswerInput _self;
  final $Res Function(_AnswerInput) _then;

  /// Create a copy of AnswerInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? questionId = null,
    Object? rawAnswer = null,
  }) {
    return _then(_AnswerInput(
      questionId: null == questionId
          ? _self.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      rawAnswer: null == rawAnswer
          ? _self.rawAnswer
          : rawAnswer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
