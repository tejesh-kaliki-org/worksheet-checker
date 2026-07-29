// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_health_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetHealthResponse {
  String? get status;

  /// Create a copy of GetHealthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GetHealthResponseCopyWith<GetHealthResponse> get copyWith =>
      _$GetHealthResponseCopyWithImpl<GetHealthResponse>(
          this as GetHealthResponse, _$identity);

  /// Serializes this GetHealthResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GetHealthResponse &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  String toString() {
    return 'GetHealthResponse(status: $status)';
  }
}

/// @nodoc
abstract mixin class $GetHealthResponseCopyWith<$Res> {
  factory $GetHealthResponseCopyWith(
          GetHealthResponse value, $Res Function(GetHealthResponse) _then) =
      _$GetHealthResponseCopyWithImpl;
  @useResult
  $Res call({String? status});
}

/// @nodoc
class _$GetHealthResponseCopyWithImpl<$Res>
    implements $GetHealthResponseCopyWith<$Res> {
  _$GetHealthResponseCopyWithImpl(this._self, this._then);

  final GetHealthResponse _self;
  final $Res Function(GetHealthResponse) _then;

  /// Create a copy of GetHealthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_self.copyWith(
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [GetHealthResponse].
extension GetHealthResponsePatterns on GetHealthResponse {
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
    TResult Function(_GetHealthResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GetHealthResponse() when $default != null:
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
    TResult Function(_GetHealthResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GetHealthResponse():
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
    TResult? Function(_GetHealthResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GetHealthResponse() when $default != null:
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
    TResult Function(String? status)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GetHealthResponse() when $default != null:
        return $default(_that.status);
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
    TResult Function(String? status) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GetHealthResponse():
        return $default(_that.status);
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
    TResult? Function(String? status)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GetHealthResponse() when $default != null:
        return $default(_that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GetHealthResponse implements GetHealthResponse {
  const _GetHealthResponse({this.status});
  factory _GetHealthResponse.fromJson(Map<String, dynamic> json) =>
      _$GetHealthResponseFromJson(json);

  @override
  final String? status;

  /// Create a copy of GetHealthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GetHealthResponseCopyWith<_GetHealthResponse> get copyWith =>
      __$GetHealthResponseCopyWithImpl<_GetHealthResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GetHealthResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GetHealthResponse &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  String toString() {
    return 'GetHealthResponse(status: $status)';
  }
}

/// @nodoc
abstract mixin class _$GetHealthResponseCopyWith<$Res>
    implements $GetHealthResponseCopyWith<$Res> {
  factory _$GetHealthResponseCopyWith(
          _GetHealthResponse value, $Res Function(_GetHealthResponse) _then) =
      __$GetHealthResponseCopyWithImpl;
  @override
  @useResult
  $Res call({String? status});
}

/// @nodoc
class __$GetHealthResponseCopyWithImpl<$Res>
    implements _$GetHealthResponseCopyWith<$Res> {
  __$GetHealthResponseCopyWithImpl(this._self, this._then);

  final _GetHealthResponse _self;
  final $Res Function(_GetHealthResponse) _then;

  /// Create a copy of GetHealthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_GetHealthResponse(
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
