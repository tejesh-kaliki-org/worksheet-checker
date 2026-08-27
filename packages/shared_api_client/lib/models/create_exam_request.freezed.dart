// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_exam_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateExamRequest {
  String get label;

  /// Create a copy of CreateExamRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateExamRequestCopyWith<CreateExamRequest> get copyWith =>
      _$CreateExamRequestCopyWithImpl<CreateExamRequest>(
          this as CreateExamRequest, _$identity);

  /// Serializes this CreateExamRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateExamRequest &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label);

  @override
  String toString() {
    return 'CreateExamRequest(label: $label)';
  }
}

/// @nodoc
abstract mixin class $CreateExamRequestCopyWith<$Res> {
  factory $CreateExamRequestCopyWith(
          CreateExamRequest value, $Res Function(CreateExamRequest) _then) =
      _$CreateExamRequestCopyWithImpl;
  @useResult
  $Res call({String label});
}

/// @nodoc
class _$CreateExamRequestCopyWithImpl<$Res>
    implements $CreateExamRequestCopyWith<$Res> {
  _$CreateExamRequestCopyWithImpl(this._self, this._then);

  final CreateExamRequest _self;
  final $Res Function(CreateExamRequest) _then;

  /// Create a copy of CreateExamRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
  }) {
    return _then(_self.copyWith(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [CreateExamRequest].
extension CreateExamRequestPatterns on CreateExamRequest {
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
    TResult Function(_CreateExamRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateExamRequest() when $default != null:
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
    TResult Function(_CreateExamRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateExamRequest():
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
    TResult? Function(_CreateExamRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateExamRequest() when $default != null:
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
    TResult Function(String label)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateExamRequest() when $default != null:
        return $default(_that.label);
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
    TResult Function(String label) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateExamRequest():
        return $default(_that.label);
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
    TResult? Function(String label)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateExamRequest() when $default != null:
        return $default(_that.label);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CreateExamRequest implements CreateExamRequest {
  const _CreateExamRequest({required this.label});
  factory _CreateExamRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateExamRequestFromJson(json);

  @override
  final String label;

  /// Create a copy of CreateExamRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateExamRequestCopyWith<_CreateExamRequest> get copyWith =>
      __$CreateExamRequestCopyWithImpl<_CreateExamRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CreateExamRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateExamRequest &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label);

  @override
  String toString() {
    return 'CreateExamRequest(label: $label)';
  }
}

/// @nodoc
abstract mixin class _$CreateExamRequestCopyWith<$Res>
    implements $CreateExamRequestCopyWith<$Res> {
  factory _$CreateExamRequestCopyWith(
          _CreateExamRequest value, $Res Function(_CreateExamRequest) _then) =
      __$CreateExamRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String label});
}

/// @nodoc
class __$CreateExamRequestCopyWithImpl<$Res>
    implements _$CreateExamRequestCopyWith<$Res> {
  __$CreateExamRequestCopyWithImpl(this._self, this._then);

  final _CreateExamRequest _self;
  final $Res Function(_CreateExamRequest) _then;

  /// Create a copy of CreateExamRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? label = null,
  }) {
    return _then(_CreateExamRequest(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
