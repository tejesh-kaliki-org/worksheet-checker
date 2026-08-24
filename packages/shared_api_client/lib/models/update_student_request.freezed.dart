// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_student_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateStudentRequest {
  String get name;
  @JsonKey(name: 'roll_number')
  String get rollNumber;

  /// Create a copy of UpdateStudentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdateStudentRequestCopyWith<UpdateStudentRequest> get copyWith =>
      _$UpdateStudentRequestCopyWithImpl<UpdateStudentRequest>(
          this as UpdateStudentRequest, _$identity);

  /// Serializes this UpdateStudentRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdateStudentRequest &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rollNumber, rollNumber) ||
                other.rollNumber == rollNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, rollNumber);

  @override
  String toString() {
    return 'UpdateStudentRequest(name: $name, rollNumber: $rollNumber)';
  }
}

/// @nodoc
abstract mixin class $UpdateStudentRequestCopyWith<$Res> {
  factory $UpdateStudentRequestCopyWith(UpdateStudentRequest value,
          $Res Function(UpdateStudentRequest) _then) =
      _$UpdateStudentRequestCopyWithImpl;
  @useResult
  $Res call({String name, @JsonKey(name: 'roll_number') String rollNumber});
}

/// @nodoc
class _$UpdateStudentRequestCopyWithImpl<$Res>
    implements $UpdateStudentRequestCopyWith<$Res> {
  _$UpdateStudentRequestCopyWithImpl(this._self, this._then);

  final UpdateStudentRequest _self;
  final $Res Function(UpdateStudentRequest) _then;

  /// Create a copy of UpdateStudentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? rollNumber = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rollNumber: null == rollNumber
          ? _self.rollNumber
          : rollNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [UpdateStudentRequest].
extension UpdateStudentRequestPatterns on UpdateStudentRequest {
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
    TResult Function(_UpdateStudentRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UpdateStudentRequest() when $default != null:
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
    TResult Function(_UpdateStudentRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateStudentRequest():
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
    TResult? Function(_UpdateStudentRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateStudentRequest() when $default != null:
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
            String name, @JsonKey(name: 'roll_number') String rollNumber)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UpdateStudentRequest() when $default != null:
        return $default(_that.name, _that.rollNumber);
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
            String name, @JsonKey(name: 'roll_number') String rollNumber)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateStudentRequest():
        return $default(_that.name, _that.rollNumber);
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
            String name, @JsonKey(name: 'roll_number') String rollNumber)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpdateStudentRequest() when $default != null:
        return $default(_that.name, _that.rollNumber);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UpdateStudentRequest implements UpdateStudentRequest {
  const _UpdateStudentRequest(
      {required this.name,
      @JsonKey(name: 'roll_number') required this.rollNumber});
  factory _UpdateStudentRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateStudentRequestFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'roll_number')
  final String rollNumber;

  /// Create a copy of UpdateStudentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateStudentRequestCopyWith<_UpdateStudentRequest> get copyWith =>
      __$UpdateStudentRequestCopyWithImpl<_UpdateStudentRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UpdateStudentRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateStudentRequest &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rollNumber, rollNumber) ||
                other.rollNumber == rollNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, rollNumber);

  @override
  String toString() {
    return 'UpdateStudentRequest(name: $name, rollNumber: $rollNumber)';
  }
}

/// @nodoc
abstract mixin class _$UpdateStudentRequestCopyWith<$Res>
    implements $UpdateStudentRequestCopyWith<$Res> {
  factory _$UpdateStudentRequestCopyWith(_UpdateStudentRequest value,
          $Res Function(_UpdateStudentRequest) _then) =
      __$UpdateStudentRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String name, @JsonKey(name: 'roll_number') String rollNumber});
}

/// @nodoc
class __$UpdateStudentRequestCopyWithImpl<$Res>
    implements _$UpdateStudentRequestCopyWith<$Res> {
  __$UpdateStudentRequestCopyWithImpl(this._self, this._then);

  final _UpdateStudentRequest _self;
  final $Res Function(_UpdateStudentRequest) _then;

  /// Create a copy of UpdateStudentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? rollNumber = null,
  }) {
    return _then(_UpdateStudentRequest(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rollNumber: null == rollNumber
          ? _self.rollNumber
          : rollNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
