// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'evaluation_attempt_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EvaluationAttemptList {
  @JsonKey(name: 'evaluation_attempts')
  List<EvaluationAttempt> get evaluationAttempts;

  /// Create a copy of EvaluationAttemptList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EvaluationAttemptListCopyWith<EvaluationAttemptList> get copyWith =>
      _$EvaluationAttemptListCopyWithImpl<EvaluationAttemptList>(
          this as EvaluationAttemptList, _$identity);

  /// Serializes this EvaluationAttemptList to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EvaluationAttemptList &&
            const DeepCollectionEquality()
                .equals(other.evaluationAttempts, evaluationAttempts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(evaluationAttempts));

  @override
  String toString() {
    return 'EvaluationAttemptList(evaluationAttempts: $evaluationAttempts)';
  }
}

/// @nodoc
abstract mixin class $EvaluationAttemptListCopyWith<$Res> {
  factory $EvaluationAttemptListCopyWith(EvaluationAttemptList value,
          $Res Function(EvaluationAttemptList) _then) =
      _$EvaluationAttemptListCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'evaluation_attempts')
      List<EvaluationAttempt> evaluationAttempts});
}

/// @nodoc
class _$EvaluationAttemptListCopyWithImpl<$Res>
    implements $EvaluationAttemptListCopyWith<$Res> {
  _$EvaluationAttemptListCopyWithImpl(this._self, this._then);

  final EvaluationAttemptList _self;
  final $Res Function(EvaluationAttemptList) _then;

  /// Create a copy of EvaluationAttemptList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? evaluationAttempts = null,
  }) {
    return _then(_self.copyWith(
      evaluationAttempts: null == evaluationAttempts
          ? _self.evaluationAttempts
          : evaluationAttempts // ignore: cast_nullable_to_non_nullable
              as List<EvaluationAttempt>,
    ));
  }
}

/// Adds pattern-matching-related methods to [EvaluationAttemptList].
extension EvaluationAttemptListPatterns on EvaluationAttemptList {
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
    TResult Function(_EvaluationAttemptList value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EvaluationAttemptList() when $default != null:
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
    TResult Function(_EvaluationAttemptList value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EvaluationAttemptList():
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
    TResult? Function(_EvaluationAttemptList value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EvaluationAttemptList() when $default != null:
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
            @JsonKey(name: 'evaluation_attempts')
            List<EvaluationAttempt> evaluationAttempts)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EvaluationAttemptList() when $default != null:
        return $default(_that.evaluationAttempts);
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
            @JsonKey(name: 'evaluation_attempts')
            List<EvaluationAttempt> evaluationAttempts)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EvaluationAttemptList():
        return $default(_that.evaluationAttempts);
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
            @JsonKey(name: 'evaluation_attempts')
            List<EvaluationAttempt> evaluationAttempts)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EvaluationAttemptList() when $default != null:
        return $default(_that.evaluationAttempts);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EvaluationAttemptList implements EvaluationAttemptList {
  const _EvaluationAttemptList(
      {@JsonKey(name: 'evaluation_attempts')
      required final List<EvaluationAttempt> evaluationAttempts})
      : _evaluationAttempts = evaluationAttempts;
  factory _EvaluationAttemptList.fromJson(Map<String, dynamic> json) =>
      _$EvaluationAttemptListFromJson(json);

  final List<EvaluationAttempt> _evaluationAttempts;
  @override
  @JsonKey(name: 'evaluation_attempts')
  List<EvaluationAttempt> get evaluationAttempts {
    if (_evaluationAttempts is EqualUnmodifiableListView)
      return _evaluationAttempts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_evaluationAttempts);
  }

  /// Create a copy of EvaluationAttemptList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EvaluationAttemptListCopyWith<_EvaluationAttemptList> get copyWith =>
      __$EvaluationAttemptListCopyWithImpl<_EvaluationAttemptList>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EvaluationAttemptListToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EvaluationAttemptList &&
            const DeepCollectionEquality()
                .equals(other._evaluationAttempts, _evaluationAttempts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_evaluationAttempts));

  @override
  String toString() {
    return 'EvaluationAttemptList(evaluationAttempts: $evaluationAttempts)';
  }
}

/// @nodoc
abstract mixin class _$EvaluationAttemptListCopyWith<$Res>
    implements $EvaluationAttemptListCopyWith<$Res> {
  factory _$EvaluationAttemptListCopyWith(_EvaluationAttemptList value,
          $Res Function(_EvaluationAttemptList) _then) =
      __$EvaluationAttemptListCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'evaluation_attempts')
      List<EvaluationAttempt> evaluationAttempts});
}

/// @nodoc
class __$EvaluationAttemptListCopyWithImpl<$Res>
    implements _$EvaluationAttemptListCopyWith<$Res> {
  __$EvaluationAttemptListCopyWithImpl(this._self, this._then);

  final _EvaluationAttemptList _self;
  final $Res Function(_EvaluationAttemptList) _then;

  /// Create a copy of EvaluationAttemptList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? evaluationAttempts = null,
  }) {
    return _then(_EvaluationAttemptList(
      evaluationAttempts: null == evaluationAttempts
          ? _self._evaluationAttempts
          : evaluationAttempts // ignore: cast_nullable_to_non_nullable
              as List<EvaluationAttempt>,
    ));
  }
}

// dart format on
