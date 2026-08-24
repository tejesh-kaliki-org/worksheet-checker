// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_student_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateStudentRequest {
  String get name;
  @JsonKey(name: 'roll_number')
  String get rollNumber;

  /// Create a copy of CreateStudentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateStudentRequestCopyWith<CreateStudentRequest> get copyWith =>
      _$CreateStudentRequestCopyWithImpl<CreateStudentRequest>(
          this as CreateStudentRequest, _$identity);

  /// Serializes this CreateStudentRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateStudentRequest &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rollNumber, rollNumber) ||
                other.rollNumber == rollNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, rollNumber);

  @override
  String toString() {
    return 'CreateStudentRequest(name: $name, rollNumber: $rollNumber)';
  }
}

/// @nodoc
abstract mixin class $CreateStudentRequestCopyWith<$Res> {
  factory $CreateStudentRequestCopyWith(CreateStudentRequest value,
          $Res Function(CreateStudentRequest) _then) =
      _$CreateStudentRequestCopyWithImpl;
  @useResult
  $Res call({String name, @JsonKey(name: 'roll_number') String rollNumber});
}

/// @nodoc
class _$CreateStudentRequestCopyWithImpl<$Res>
    implements $CreateStudentRequestCopyWith<$Res> {
  _$CreateStudentRequestCopyWithImpl(this._self, this._then);

  final CreateStudentRequest _self;
  final $Res Function(CreateStudentRequest) _then;

  /// Create a copy of CreateStudentRequest
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

/// Adds pattern-matching-related methods to [CreateStudentRequest].
extension CreateStudentRequestPatterns on CreateStudentRequest {
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
    TResult Function(_CreateStudentRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateStudentRequest() when $default != null:
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
    TResult Function(_CreateStudentRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateStudentRequest():
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
    TResult? Function(_CreateStudentRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateStudentRequest() when $default != null:
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
      case _CreateStudentRequest() when $default != null:
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
      case _CreateStudentRequest():
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
      case _CreateStudentRequest() when $default != null:
        return $default(_that.name, _that.rollNumber);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CreateStudentRequest implements CreateStudentRequest {
  const _CreateStudentRequest(
      {required this.name,
      @JsonKey(name: 'roll_number') required this.rollNumber});
  factory _CreateStudentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateStudentRequestFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'roll_number')
  final String rollNumber;

  /// Create a copy of CreateStudentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateStudentRequestCopyWith<_CreateStudentRequest> get copyWith =>
      __$CreateStudentRequestCopyWithImpl<_CreateStudentRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CreateStudentRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateStudentRequest &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rollNumber, rollNumber) ||
                other.rollNumber == rollNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, rollNumber);

  @override
  String toString() {
    return 'CreateStudentRequest(name: $name, rollNumber: $rollNumber)';
  }
}

/// @nodoc
abstract mixin class _$CreateStudentRequestCopyWith<$Res>
    implements $CreateStudentRequestCopyWith<$Res> {
  factory _$CreateStudentRequestCopyWith(_CreateStudentRequest value,
          $Res Function(_CreateStudentRequest) _then) =
      __$CreateStudentRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String name, @JsonKey(name: 'roll_number') String rollNumber});
}

/// @nodoc
class __$CreateStudentRequestCopyWithImpl<$Res>
    implements _$CreateStudentRequestCopyWith<$Res> {
  __$CreateStudentRequestCopyWithImpl(this._self, this._then);

  final _CreateStudentRequest _self;
  final $Res Function(_CreateStudentRequest) _then;

  /// Create a copy of CreateStudentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? rollNumber = null,
  }) {
    return _then(_CreateStudentRequest(
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
