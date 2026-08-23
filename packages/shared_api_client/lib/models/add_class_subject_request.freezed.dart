// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_class_subject_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddClassSubjectRequest {
  @JsonKey(name: 'subject_id')
  String get subjectId;

  /// Create a copy of AddClassSubjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddClassSubjectRequestCopyWith<AddClassSubjectRequest> get copyWith =>
      _$AddClassSubjectRequestCopyWithImpl<AddClassSubjectRequest>(
          this as AddClassSubjectRequest, _$identity);

  /// Serializes this AddClassSubjectRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddClassSubjectRequest &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, subjectId);

  @override
  String toString() {
    return 'AddClassSubjectRequest(subjectId: $subjectId)';
  }
}

/// @nodoc
abstract mixin class $AddClassSubjectRequestCopyWith<$Res> {
  factory $AddClassSubjectRequestCopyWith(AddClassSubjectRequest value,
          $Res Function(AddClassSubjectRequest) _then) =
      _$AddClassSubjectRequestCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: 'subject_id') String subjectId});
}

/// @nodoc
class _$AddClassSubjectRequestCopyWithImpl<$Res>
    implements $AddClassSubjectRequestCopyWith<$Res> {
  _$AddClassSubjectRequestCopyWithImpl(this._self, this._then);

  final AddClassSubjectRequest _self;
  final $Res Function(AddClassSubjectRequest) _then;

  /// Create a copy of AddClassSubjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subjectId = null,
  }) {
    return _then(_self.copyWith(
      subjectId: null == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [AddClassSubjectRequest].
extension AddClassSubjectRequestPatterns on AddClassSubjectRequest {
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
    TResult Function(_AddClassSubjectRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AddClassSubjectRequest() when $default != null:
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
    TResult Function(_AddClassSubjectRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddClassSubjectRequest():
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
    TResult? Function(_AddClassSubjectRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddClassSubjectRequest() when $default != null:
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
    TResult Function(@JsonKey(name: 'subject_id') String subjectId)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AddClassSubjectRequest() when $default != null:
        return $default(_that.subjectId);
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
    TResult Function(@JsonKey(name: 'subject_id') String subjectId) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddClassSubjectRequest():
        return $default(_that.subjectId);
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
    TResult? Function(@JsonKey(name: 'subject_id') String subjectId)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddClassSubjectRequest() when $default != null:
        return $default(_that.subjectId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AddClassSubjectRequest implements AddClassSubjectRequest {
  const _AddClassSubjectRequest(
      {@JsonKey(name: 'subject_id') required this.subjectId});
  factory _AddClassSubjectRequest.fromJson(Map<String, dynamic> json) =>
      _$AddClassSubjectRequestFromJson(json);

  @override
  @JsonKey(name: 'subject_id')
  final String subjectId;

  /// Create a copy of AddClassSubjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddClassSubjectRequestCopyWith<_AddClassSubjectRequest> get copyWith =>
      __$AddClassSubjectRequestCopyWithImpl<_AddClassSubjectRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AddClassSubjectRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddClassSubjectRequest &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, subjectId);

  @override
  String toString() {
    return 'AddClassSubjectRequest(subjectId: $subjectId)';
  }
}

/// @nodoc
abstract mixin class _$AddClassSubjectRequestCopyWith<$Res>
    implements $AddClassSubjectRequestCopyWith<$Res> {
  factory _$AddClassSubjectRequestCopyWith(_AddClassSubjectRequest value,
          $Res Function(_AddClassSubjectRequest) _then) =
      __$AddClassSubjectRequestCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: 'subject_id') String subjectId});
}

/// @nodoc
class __$AddClassSubjectRequestCopyWithImpl<$Res>
    implements _$AddClassSubjectRequestCopyWith<$Res> {
  __$AddClassSubjectRequestCopyWithImpl(this._self, this._then);

  final _AddClassSubjectRequest _self;
  final $Res Function(_AddClassSubjectRequest) _then;

  /// Create a copy of AddClassSubjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? subjectId = null,
  }) {
    return _then(_AddClassSubjectRequest(
      subjectId: null == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
