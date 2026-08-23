// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'evaluation_attempt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EvaluationAttempt {
  String get id;
  @JsonKey(name: 'answer_id')
  String get answerId;
  EvaluationAttemptStatus get status;
  EvaluationPurpose get purpose;
  String? get error;
  Evaluation? get evaluation;

  /// Create a copy of EvaluationAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EvaluationAttemptCopyWith<EvaluationAttempt> get copyWith =>
      _$EvaluationAttemptCopyWithImpl<EvaluationAttempt>(
          this as EvaluationAttempt, _$identity);

  /// Serializes this EvaluationAttempt to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EvaluationAttempt &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.answerId, answerId) ||
                other.answerId == answerId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.evaluation, evaluation) ||
                other.evaluation == evaluation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, answerId, status, purpose, error, evaluation);

  @override
  String toString() {
    return 'EvaluationAttempt(id: $id, answerId: $answerId, status: $status, purpose: $purpose, error: $error, evaluation: $evaluation)';
  }
}

/// @nodoc
abstract mixin class $EvaluationAttemptCopyWith<$Res> {
  factory $EvaluationAttemptCopyWith(
          EvaluationAttempt value, $Res Function(EvaluationAttempt) _then) =
      _$EvaluationAttemptCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'answer_id') String answerId,
      EvaluationAttemptStatus status,
      EvaluationPurpose purpose,
      String? error,
      Evaluation? evaluation});

  $EvaluationCopyWith<$Res>? get evaluation;
}

/// @nodoc
class _$EvaluationAttemptCopyWithImpl<$Res>
    implements $EvaluationAttemptCopyWith<$Res> {
  _$EvaluationAttemptCopyWithImpl(this._self, this._then);

  final EvaluationAttempt _self;
  final $Res Function(EvaluationAttempt) _then;

  /// Create a copy of EvaluationAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? answerId = null,
    Object? status = null,
    Object? purpose = null,
    Object? error = freezed,
    Object? evaluation = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      answerId: null == answerId
          ? _self.answerId
          : answerId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as EvaluationAttemptStatus,
      purpose: null == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as EvaluationPurpose,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      evaluation: freezed == evaluation
          ? _self.evaluation
          : evaluation // ignore: cast_nullable_to_non_nullable
              as Evaluation?,
    ));
  }

  /// Create a copy of EvaluationAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EvaluationCopyWith<$Res>? get evaluation {
    if (_self.evaluation == null) {
      return null;
    }

    return $EvaluationCopyWith<$Res>(_self.evaluation!, (value) {
      return _then(_self.copyWith(evaluation: value));
    });
  }
}

/// Adds pattern-matching-related methods to [EvaluationAttempt].
extension EvaluationAttemptPatterns on EvaluationAttempt {
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
    TResult Function(_EvaluationAttempt value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EvaluationAttempt() when $default != null:
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
    TResult Function(_EvaluationAttempt value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EvaluationAttempt():
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
    TResult? Function(_EvaluationAttempt value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EvaluationAttempt() when $default != null:
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
            @JsonKey(name: 'answer_id') String answerId,
            EvaluationAttemptStatus status,
            EvaluationPurpose purpose,
            String? error,
            Evaluation? evaluation)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EvaluationAttempt() when $default != null:
        return $default(_that.id, _that.answerId, _that.status, _that.purpose,
            _that.error, _that.evaluation);
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
            @JsonKey(name: 'answer_id') String answerId,
            EvaluationAttemptStatus status,
            EvaluationPurpose purpose,
            String? error,
            Evaluation? evaluation)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EvaluationAttempt():
        return $default(_that.id, _that.answerId, _that.status, _that.purpose,
            _that.error, _that.evaluation);
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
            @JsonKey(name: 'answer_id') String answerId,
            EvaluationAttemptStatus status,
            EvaluationPurpose purpose,
            String? error,
            Evaluation? evaluation)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EvaluationAttempt() when $default != null:
        return $default(_that.id, _that.answerId, _that.status, _that.purpose,
            _that.error, _that.evaluation);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EvaluationAttempt implements EvaluationAttempt {
  const _EvaluationAttempt(
      {required this.id,
      @JsonKey(name: 'answer_id') required this.answerId,
      required this.status,
      required this.purpose,
      this.error,
      this.evaluation});
  factory _EvaluationAttempt.fromJson(Map<String, dynamic> json) =>
      _$EvaluationAttemptFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'answer_id')
  final String answerId;
  @override
  final EvaluationAttemptStatus status;
  @override
  final EvaluationPurpose purpose;
  @override
  final String? error;
  @override
  final Evaluation? evaluation;

  /// Create a copy of EvaluationAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EvaluationAttemptCopyWith<_EvaluationAttempt> get copyWith =>
      __$EvaluationAttemptCopyWithImpl<_EvaluationAttempt>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EvaluationAttemptToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EvaluationAttempt &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.answerId, answerId) ||
                other.answerId == answerId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.evaluation, evaluation) ||
                other.evaluation == evaluation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, answerId, status, purpose, error, evaluation);

  @override
  String toString() {
    return 'EvaluationAttempt(id: $id, answerId: $answerId, status: $status, purpose: $purpose, error: $error, evaluation: $evaluation)';
  }
}

/// @nodoc
abstract mixin class _$EvaluationAttemptCopyWith<$Res>
    implements $EvaluationAttemptCopyWith<$Res> {
  factory _$EvaluationAttemptCopyWith(
          _EvaluationAttempt value, $Res Function(_EvaluationAttempt) _then) =
      __$EvaluationAttemptCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'answer_id') String answerId,
      EvaluationAttemptStatus status,
      EvaluationPurpose purpose,
      String? error,
      Evaluation? evaluation});

  @override
  $EvaluationCopyWith<$Res>? get evaluation;
}

/// @nodoc
class __$EvaluationAttemptCopyWithImpl<$Res>
    implements _$EvaluationAttemptCopyWith<$Res> {
  __$EvaluationAttemptCopyWithImpl(this._self, this._then);

  final _EvaluationAttempt _self;
  final $Res Function(_EvaluationAttempt) _then;

  /// Create a copy of EvaluationAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? answerId = null,
    Object? status = null,
    Object? purpose = null,
    Object? error = freezed,
    Object? evaluation = freezed,
  }) {
    return _then(_EvaluationAttempt(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      answerId: null == answerId
          ? _self.answerId
          : answerId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as EvaluationAttemptStatus,
      purpose: null == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as EvaluationPurpose,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      evaluation: freezed == evaluation
          ? _self.evaluation
          : evaluation // ignore: cast_nullable_to_non_nullable
              as Evaluation?,
    ));
  }

  /// Create a copy of EvaluationAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EvaluationCopyWith<$Res>? get evaluation {
    if (_self.evaluation == null) {
      return null;
    }

    return $EvaluationCopyWith<$Res>(_self.evaluation!, (value) {
      return _then(_self.copyWith(evaluation: value));
    });
  }
}

// dart format on
