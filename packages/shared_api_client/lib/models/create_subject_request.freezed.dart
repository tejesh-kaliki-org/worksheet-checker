// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_subject_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateSubjectRequest {
  String get name;

  /// Create a copy of CreateSubjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateSubjectRequestCopyWith<CreateSubjectRequest> get copyWith =>
      _$CreateSubjectRequestCopyWithImpl<CreateSubjectRequest>(
          this as CreateSubjectRequest, _$identity);

  /// Serializes this CreateSubjectRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateSubjectRequest &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @override
  String toString() {
    return 'CreateSubjectRequest(name: $name)';
  }
}

/// @nodoc
abstract mixin class $CreateSubjectRequestCopyWith<$Res> {
  factory $CreateSubjectRequestCopyWith(CreateSubjectRequest value,
          $Res Function(CreateSubjectRequest) _then) =
      _$CreateSubjectRequestCopyWithImpl;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$CreateSubjectRequestCopyWithImpl<$Res>
    implements $CreateSubjectRequestCopyWith<$Res> {
  _$CreateSubjectRequestCopyWithImpl(this._self, this._then);

  final CreateSubjectRequest _self;
  final $Res Function(CreateSubjectRequest) _then;

  /// Create a copy of CreateSubjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [CreateSubjectRequest].
extension CreateSubjectRequestPatterns on CreateSubjectRequest {
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
    TResult Function(_CreateSubjectRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateSubjectRequest() when $default != null:
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
    TResult Function(_CreateSubjectRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateSubjectRequest():
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
    TResult? Function(_CreateSubjectRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateSubjectRequest() when $default != null:
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
    TResult Function(String name)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateSubjectRequest() when $default != null:
        return $default(_that.name);
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
    TResult Function(String name) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateSubjectRequest():
        return $default(_that.name);
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
    TResult? Function(String name)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateSubjectRequest() when $default != null:
        return $default(_that.name);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CreateSubjectRequest implements CreateSubjectRequest {
  const _CreateSubjectRequest({required this.name});
  factory _CreateSubjectRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSubjectRequestFromJson(json);

  @override
  final String name;

  /// Create a copy of CreateSubjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateSubjectRequestCopyWith<_CreateSubjectRequest> get copyWith =>
      __$CreateSubjectRequestCopyWithImpl<_CreateSubjectRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CreateSubjectRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateSubjectRequest &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @override
  String toString() {
    return 'CreateSubjectRequest(name: $name)';
  }
}

/// @nodoc
abstract mixin class _$CreateSubjectRequestCopyWith<$Res>
    implements $CreateSubjectRequestCopyWith<$Res> {
  factory _$CreateSubjectRequestCopyWith(_CreateSubjectRequest value,
          $Res Function(_CreateSubjectRequest) _then) =
      __$CreateSubjectRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$CreateSubjectRequestCopyWithImpl<$Res>
    implements _$CreateSubjectRequestCopyWith<$Res> {
  __$CreateSubjectRequestCopyWithImpl(this._self, this._then);

  final _CreateSubjectRequest _self;
  final $Res Function(_CreateSubjectRequest) _then;

  /// Create a copy of CreateSubjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
  }) {
    return _then(_CreateSubjectRequest(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
