// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_answer_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateAnswerRequest {
  @JsonKey(name: 'raw_answer')
  String get rawAnswer;

  /// Create a copy of UpdateAnswerRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdateAnswerRequestCopyWith<UpdateAnswerRequest> get copyWith =>
      _$UpdateAnswerRequestCopyWithImpl<UpdateAnswerRequest>(
          this as UpdateAnswerRequest, _$identity);

  /// Serializes this UpdateAnswerRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdateAnswerRequest &&
            (identical(other.rawAnswer, rawAnswer) ||
                other.rawAnswer == rawAnswer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, rawAnswer);

  @override
  String toString() {
    return 'UpdateAnswerRequest(rawAnswer: $rawAnswer)';
  }
}

/// @nodoc
abstract mixin class $UpdateAnswerRequestCopyWith<$Res> {
  factory $UpdateAnswerRequestCopyWith(
          UpdateAnswerRequest value, $Res Function(UpdateAnswerRequest) _then) =
      _$UpdateAnswerRequestCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: 'raw_answer') String rawAnswer});
}

/// @nodoc
class _$UpdateAnswerRequestCopyWithImpl<$Res>
    implements $UpdateAnswerRequestCopyWith<$Res> {
  _$UpdateAnswerRequestCopyWithImpl(this._self, this._then);

  final UpdateAnswerRequest _self;
  final $Res Function(UpdateAnswerRequest) _then;

  /// Create a copy of UpdateAnswerRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rawAnswer = null,
  }) {
    return _then(_self.copyWith(
      rawAnswer: null == rawAnswer
          ? _self.rawAnswer
          : rawAnswer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [UpdateAnswerRequest].
extension UpdateAnswerRequestPatterns on UpdateAnswerRequest {
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
    TResult Function(_UpdateAnswerRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UpdateAnswerRequest() when $default != null:
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
    TResult Function(_UpdateAnswerRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateAnswerRequest():
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
    TResult? Function(_UpdateAnswerRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateAnswerRequest() when $default != null:
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
    TResult Function(@JsonKey(name: 'raw_answer') String rawAnswer)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UpdateAnswerRequest() when $default != null:
        return $default(_that.rawAnswer);
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
    TResult Function(@JsonKey(name: 'raw_answer') String rawAnswer) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateAnswerRequest():
        return $default(_that.rawAnswer);
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
    TResult? Function(@JsonKey(name: 'raw_answer') String rawAnswer)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateAnswerRequest() when $default != null:
        return $default(_that.rawAnswer);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UpdateAnswerRequest implements UpdateAnswerRequest {
  const _UpdateAnswerRequest(
      {@JsonKey(name: 'raw_answer') required this.rawAnswer});
  factory _UpdateAnswerRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateAnswerRequestFromJson(json);

  @override
  @JsonKey(name: 'raw_answer')
  final String rawAnswer;

  /// Create a copy of UpdateAnswerRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateAnswerRequestCopyWith<_UpdateAnswerRequest> get copyWith =>
      __$UpdateAnswerRequestCopyWithImpl<_UpdateAnswerRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UpdateAnswerRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateAnswerRequest &&
            (identical(other.rawAnswer, rawAnswer) ||
                other.rawAnswer == rawAnswer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, rawAnswer);

  @override
  String toString() {
    return 'UpdateAnswerRequest(rawAnswer: $rawAnswer)';
  }
}

/// @nodoc
abstract mixin class _$UpdateAnswerRequestCopyWith<$Res>
    implements $UpdateAnswerRequestCopyWith<$Res> {
  factory _$UpdateAnswerRequestCopyWith(_UpdateAnswerRequest value,
          $Res Function(_UpdateAnswerRequest) _then) =
      __$UpdateAnswerRequestCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: 'raw_answer') String rawAnswer});
}

/// @nodoc
class __$UpdateAnswerRequestCopyWithImpl<$Res>
    implements _$UpdateAnswerRequestCopyWith<$Res> {
  __$UpdateAnswerRequestCopyWithImpl(this._self, this._then);

  final _UpdateAnswerRequest _self;
  final $Res Function(_UpdateAnswerRequest) _then;

  /// Create a copy of UpdateAnswerRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? rawAnswer = null,
  }) {
    return _then(_UpdateAnswerRequest(
      rawAnswer: null == rawAnswer
          ? _self.rawAnswer
          : rawAnswer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
