// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_evaluation_attempt_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateEvaluationAttemptRequest {
  EvaluationPurpose? get purpose;

  /// Create a copy of CreateEvaluationAttemptRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateEvaluationAttemptRequestCopyWith<CreateEvaluationAttemptRequest>
      get copyWith => _$CreateEvaluationAttemptRequestCopyWithImpl<
              CreateEvaluationAttemptRequest>(
          this as CreateEvaluationAttemptRequest, _$identity);

  /// Serializes this CreateEvaluationAttemptRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateEvaluationAttemptRequest &&
            (identical(other.purpose, purpose) || other.purpose == purpose));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, purpose);

  @override
  String toString() {
    return 'CreateEvaluationAttemptRequest(purpose: $purpose)';
  }
}

/// @nodoc
abstract mixin class $CreateEvaluationAttemptRequestCopyWith<$Res> {
  factory $CreateEvaluationAttemptRequestCopyWith(
          CreateEvaluationAttemptRequest value,
          $Res Function(CreateEvaluationAttemptRequest) _then) =
      _$CreateEvaluationAttemptRequestCopyWithImpl;
  @useResult
  $Res call({EvaluationPurpose? purpose});
}

/// @nodoc
class _$CreateEvaluationAttemptRequestCopyWithImpl<$Res>
    implements $CreateEvaluationAttemptRequestCopyWith<$Res> {
  _$CreateEvaluationAttemptRequestCopyWithImpl(this._self, this._then);

  final CreateEvaluationAttemptRequest _self;
  final $Res Function(CreateEvaluationAttemptRequest) _then;

  /// Create a copy of CreateEvaluationAttemptRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? purpose = freezed,
  }) {
    return _then(_self.copyWith(
      purpose: freezed == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as EvaluationPurpose?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CreateEvaluationAttemptRequest].
extension CreateEvaluationAttemptRequestPatterns
    on CreateEvaluationAttemptRequest {
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
    TResult Function(_CreateEvaluationAttemptRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateEvaluationAttemptRequest() when $default != null:
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
    TResult Function(_CreateEvaluationAttemptRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateEvaluationAttemptRequest():
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
    TResult? Function(_CreateEvaluationAttemptRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateEvaluationAttemptRequest() when $default != null:
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
    TResult Function(EvaluationPurpose? purpose)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateEvaluationAttemptRequest() when $default != null:
        return $default(_that.purpose);
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
    TResult Function(EvaluationPurpose? purpose) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateEvaluationAttemptRequest():
        return $default(_that.purpose);
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
    TResult? Function(EvaluationPurpose? purpose)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateEvaluationAttemptRequest() when $default != null:
        return $default(_that.purpose);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CreateEvaluationAttemptRequest
    implements CreateEvaluationAttemptRequest {
  const _CreateEvaluationAttemptRequest({this.purpose});
  factory _CreateEvaluationAttemptRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateEvaluationAttemptRequestFromJson(json);

  @override
  final EvaluationPurpose? purpose;

  /// Create a copy of CreateEvaluationAttemptRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateEvaluationAttemptRequestCopyWith<_CreateEvaluationAttemptRequest>
      get copyWith => __$CreateEvaluationAttemptRequestCopyWithImpl<
          _CreateEvaluationAttemptRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CreateEvaluationAttemptRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateEvaluationAttemptRequest &&
            (identical(other.purpose, purpose) || other.purpose == purpose));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, purpose);

  @override
  String toString() {
    return 'CreateEvaluationAttemptRequest(purpose: $purpose)';
  }
}

/// @nodoc
abstract mixin class _$CreateEvaluationAttemptRequestCopyWith<$Res>
    implements $CreateEvaluationAttemptRequestCopyWith<$Res> {
  factory _$CreateEvaluationAttemptRequestCopyWith(
          _CreateEvaluationAttemptRequest value,
          $Res Function(_CreateEvaluationAttemptRequest) _then) =
      __$CreateEvaluationAttemptRequestCopyWithImpl;
  @override
  @useResult
  $Res call({EvaluationPurpose? purpose});
}

/// @nodoc
class __$CreateEvaluationAttemptRequestCopyWithImpl<$Res>
    implements _$CreateEvaluationAttemptRequestCopyWith<$Res> {
  __$CreateEvaluationAttemptRequestCopyWithImpl(this._self, this._then);

  final _CreateEvaluationAttemptRequest _self;
  final $Res Function(_CreateEvaluationAttemptRequest) _then;

  /// Create a copy of CreateEvaluationAttemptRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? purpose = freezed,
  }) {
    return _then(_CreateEvaluationAttemptRequest(
      purpose: freezed == purpose
          ? _self.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as EvaluationPurpose?,
    ));
  }
}

// dart format on
