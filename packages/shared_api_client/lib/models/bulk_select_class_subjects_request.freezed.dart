// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bulk_select_class_subjects_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BulkSelectClassSubjectsRequest {
  @JsonKey(name: 'subject_ids')
  List<String> get subjectIds;

  /// Create a copy of BulkSelectClassSubjectsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BulkSelectClassSubjectsRequestCopyWith<BulkSelectClassSubjectsRequest>
      get copyWith => _$BulkSelectClassSubjectsRequestCopyWithImpl<
              BulkSelectClassSubjectsRequest>(
          this as BulkSelectClassSubjectsRequest, _$identity);

  /// Serializes this BulkSelectClassSubjectsRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BulkSelectClassSubjectsRequest &&
            const DeepCollectionEquality()
                .equals(other.subjectIds, subjectIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(subjectIds));

  @override
  String toString() {
    return 'BulkSelectClassSubjectsRequest(subjectIds: $subjectIds)';
  }
}

/// @nodoc
abstract mixin class $BulkSelectClassSubjectsRequestCopyWith<$Res> {
  factory $BulkSelectClassSubjectsRequestCopyWith(
          BulkSelectClassSubjectsRequest value,
          $Res Function(BulkSelectClassSubjectsRequest) _then) =
      _$BulkSelectClassSubjectsRequestCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: 'subject_ids') List<String> subjectIds});
}

/// @nodoc
class _$BulkSelectClassSubjectsRequestCopyWithImpl<$Res>
    implements $BulkSelectClassSubjectsRequestCopyWith<$Res> {
  _$BulkSelectClassSubjectsRequestCopyWithImpl(this._self, this._then);

  final BulkSelectClassSubjectsRequest _self;
  final $Res Function(BulkSelectClassSubjectsRequest) _then;

  /// Create a copy of BulkSelectClassSubjectsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subjectIds = null,
  }) {
    return _then(_self.copyWith(
      subjectIds: null == subjectIds
          ? _self.subjectIds
          : subjectIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BulkSelectClassSubjectsRequest].
extension BulkSelectClassSubjectsRequestPatterns
    on BulkSelectClassSubjectsRequest {
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
    TResult Function(_BulkSelectClassSubjectsRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkSelectClassSubjectsRequest() when $default != null:
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
    TResult Function(_BulkSelectClassSubjectsRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkSelectClassSubjectsRequest():
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
    TResult? Function(_BulkSelectClassSubjectsRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkSelectClassSubjectsRequest() when $default != null:
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
    TResult Function(@JsonKey(name: 'subject_ids') List<String> subjectIds)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkSelectClassSubjectsRequest() when $default != null:
        return $default(_that.subjectIds);
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
    TResult Function(@JsonKey(name: 'subject_ids') List<String> subjectIds)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkSelectClassSubjectsRequest():
        return $default(_that.subjectIds);
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
    TResult? Function(@JsonKey(name: 'subject_ids') List<String> subjectIds)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkSelectClassSubjectsRequest() when $default != null:
        return $default(_that.subjectIds);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BulkSelectClassSubjectsRequest
    implements BulkSelectClassSubjectsRequest {
  const _BulkSelectClassSubjectsRequest(
      {@JsonKey(name: 'subject_ids') required final List<String> subjectIds})
      : _subjectIds = subjectIds;
  factory _BulkSelectClassSubjectsRequest.fromJson(Map<String, dynamic> json) =>
      _$BulkSelectClassSubjectsRequestFromJson(json);

  final List<String> _subjectIds;
  @override
  @JsonKey(name: 'subject_ids')
  List<String> get subjectIds {
    if (_subjectIds is EqualUnmodifiableListView) return _subjectIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subjectIds);
  }

  /// Create a copy of BulkSelectClassSubjectsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BulkSelectClassSubjectsRequestCopyWith<_BulkSelectClassSubjectsRequest>
      get copyWith => __$BulkSelectClassSubjectsRequestCopyWithImpl<
          _BulkSelectClassSubjectsRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BulkSelectClassSubjectsRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BulkSelectClassSubjectsRequest &&
            const DeepCollectionEquality()
                .equals(other._subjectIds, _subjectIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_subjectIds));

  @override
  String toString() {
    return 'BulkSelectClassSubjectsRequest(subjectIds: $subjectIds)';
  }
}

/// @nodoc
abstract mixin class _$BulkSelectClassSubjectsRequestCopyWith<$Res>
    implements $BulkSelectClassSubjectsRequestCopyWith<$Res> {
  factory _$BulkSelectClassSubjectsRequestCopyWith(
          _BulkSelectClassSubjectsRequest value,
          $Res Function(_BulkSelectClassSubjectsRequest) _then) =
      __$BulkSelectClassSubjectsRequestCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: 'subject_ids') List<String> subjectIds});
}

/// @nodoc
class __$BulkSelectClassSubjectsRequestCopyWithImpl<$Res>
    implements _$BulkSelectClassSubjectsRequestCopyWith<$Res> {
  __$BulkSelectClassSubjectsRequestCopyWithImpl(this._self, this._then);

  final _BulkSelectClassSubjectsRequest _self;
  final $Res Function(_BulkSelectClassSubjectsRequest) _then;

  /// Create a copy of BulkSelectClassSubjectsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? subjectIds = null,
  }) {
    return _then(_BulkSelectClassSubjectsRequest(
      subjectIds: null == subjectIds
          ? _self._subjectIds
          : subjectIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
