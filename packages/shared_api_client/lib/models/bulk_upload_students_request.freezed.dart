// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bulk_upload_students_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BulkUploadStudentsRequest {
  List<CreateStudentRequest> get students;

  /// Create a copy of BulkUploadStudentsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BulkUploadStudentsRequestCopyWith<BulkUploadStudentsRequest> get copyWith =>
      _$BulkUploadStudentsRequestCopyWithImpl<BulkUploadStudentsRequest>(
          this as BulkUploadStudentsRequest, _$identity);

  /// Serializes this BulkUploadStudentsRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BulkUploadStudentsRequest &&
            const DeepCollectionEquality().equals(other.students, students));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(students));

  @override
  String toString() {
    return 'BulkUploadStudentsRequest(students: $students)';
  }
}

/// @nodoc
abstract mixin class $BulkUploadStudentsRequestCopyWith<$Res> {
  factory $BulkUploadStudentsRequestCopyWith(BulkUploadStudentsRequest value,
          $Res Function(BulkUploadStudentsRequest) _then) =
      _$BulkUploadStudentsRequestCopyWithImpl;
  @useResult
  $Res call({List<CreateStudentRequest> students});
}

/// @nodoc
class _$BulkUploadStudentsRequestCopyWithImpl<$Res>
    implements $BulkUploadStudentsRequestCopyWith<$Res> {
  _$BulkUploadStudentsRequestCopyWithImpl(this._self, this._then);

  final BulkUploadStudentsRequest _self;
  final $Res Function(BulkUploadStudentsRequest) _then;

  /// Create a copy of BulkUploadStudentsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? students = null,
  }) {
    return _then(_self.copyWith(
      students: null == students
          ? _self.students
          : students // ignore: cast_nullable_to_non_nullable
              as List<CreateStudentRequest>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BulkUploadStudentsRequest].
extension BulkUploadStudentsRequestPatterns on BulkUploadStudentsRequest {
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
    TResult Function(_BulkUploadStudentsRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkUploadStudentsRequest() when $default != null:
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
    TResult Function(_BulkUploadStudentsRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkUploadStudentsRequest():
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
    TResult? Function(_BulkUploadStudentsRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkUploadStudentsRequest() when $default != null:
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
    TResult Function(List<CreateStudentRequest> students)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkUploadStudentsRequest() when $default != null:
        return $default(_that.students);
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
    TResult Function(List<CreateStudentRequest> students) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkUploadStudentsRequest():
        return $default(_that.students);
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
    TResult? Function(List<CreateStudentRequest> students)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkUploadStudentsRequest() when $default != null:
        return $default(_that.students);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BulkUploadStudentsRequest implements BulkUploadStudentsRequest {
  const _BulkUploadStudentsRequest(
      {required final List<CreateStudentRequest> students})
      : _students = students;
  factory _BulkUploadStudentsRequest.fromJson(Map<String, dynamic> json) =>
      _$BulkUploadStudentsRequestFromJson(json);

  final List<CreateStudentRequest> _students;
  @override
  List<CreateStudentRequest> get students {
    if (_students is EqualUnmodifiableListView) return _students;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_students);
  }

  /// Create a copy of BulkUploadStudentsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BulkUploadStudentsRequestCopyWith<_BulkUploadStudentsRequest>
      get copyWith =>
          __$BulkUploadStudentsRequestCopyWithImpl<_BulkUploadStudentsRequest>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BulkUploadStudentsRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BulkUploadStudentsRequest &&
            const DeepCollectionEquality().equals(other._students, _students));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_students));

  @override
  String toString() {
    return 'BulkUploadStudentsRequest(students: $students)';
  }
}

/// @nodoc
abstract mixin class _$BulkUploadStudentsRequestCopyWith<$Res>
    implements $BulkUploadStudentsRequestCopyWith<$Res> {
  factory _$BulkUploadStudentsRequestCopyWith(_BulkUploadStudentsRequest value,
          $Res Function(_BulkUploadStudentsRequest) _then) =
      __$BulkUploadStudentsRequestCopyWithImpl;
  @override
  @useResult
  $Res call({List<CreateStudentRequest> students});
}

/// @nodoc
class __$BulkUploadStudentsRequestCopyWithImpl<$Res>
    implements _$BulkUploadStudentsRequestCopyWith<$Res> {
  __$BulkUploadStudentsRequestCopyWithImpl(this._self, this._then);

  final _BulkUploadStudentsRequest _self;
  final $Res Function(_BulkUploadStudentsRequest) _then;

  /// Create a copy of BulkUploadStudentsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? students = null,
  }) {
    return _then(_BulkUploadStudentsRequest(
      students: null == students
          ? _self._students
          : students // ignore: cast_nullable_to_non_nullable
              as List<CreateStudentRequest>,
    ));
  }
}

// dart format on
