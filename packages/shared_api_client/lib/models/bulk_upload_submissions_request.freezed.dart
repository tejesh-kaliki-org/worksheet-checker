// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bulk_upload_submissions_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BulkUploadSubmissionsRequest {
  List<StudentAnswersInput> get submissions;

  /// Create a copy of BulkUploadSubmissionsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BulkUploadSubmissionsRequestCopyWith<BulkUploadSubmissionsRequest>
      get copyWith => _$BulkUploadSubmissionsRequestCopyWithImpl<
              BulkUploadSubmissionsRequest>(
          this as BulkUploadSubmissionsRequest, _$identity);

  /// Serializes this BulkUploadSubmissionsRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BulkUploadSubmissionsRequest &&
            const DeepCollectionEquality()
                .equals(other.submissions, submissions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(submissions));

  @override
  String toString() {
    return 'BulkUploadSubmissionsRequest(submissions: $submissions)';
  }
}

/// @nodoc
abstract mixin class $BulkUploadSubmissionsRequestCopyWith<$Res> {
  factory $BulkUploadSubmissionsRequestCopyWith(
          BulkUploadSubmissionsRequest value,
          $Res Function(BulkUploadSubmissionsRequest) _then) =
      _$BulkUploadSubmissionsRequestCopyWithImpl;
  @useResult
  $Res call({List<StudentAnswersInput> submissions});
}

/// @nodoc
class _$BulkUploadSubmissionsRequestCopyWithImpl<$Res>
    implements $BulkUploadSubmissionsRequestCopyWith<$Res> {
  _$BulkUploadSubmissionsRequestCopyWithImpl(this._self, this._then);

  final BulkUploadSubmissionsRequest _self;
  final $Res Function(BulkUploadSubmissionsRequest) _then;

  /// Create a copy of BulkUploadSubmissionsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? submissions = null,
  }) {
    return _then(_self.copyWith(
      submissions: null == submissions
          ? _self.submissions
          : submissions // ignore: cast_nullable_to_non_nullable
              as List<StudentAnswersInput>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BulkUploadSubmissionsRequest].
extension BulkUploadSubmissionsRequestPatterns on BulkUploadSubmissionsRequest {
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
    TResult Function(_BulkUploadSubmissionsRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkUploadSubmissionsRequest() when $default != null:
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
    TResult Function(_BulkUploadSubmissionsRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkUploadSubmissionsRequest():
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
    TResult? Function(_BulkUploadSubmissionsRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkUploadSubmissionsRequest() when $default != null:
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
    TResult Function(List<StudentAnswersInput> submissions)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkUploadSubmissionsRequest() when $default != null:
        return $default(_that.submissions);
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
    TResult Function(List<StudentAnswersInput> submissions) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkUploadSubmissionsRequest():
        return $default(_that.submissions);
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
    TResult? Function(List<StudentAnswersInput> submissions)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkUploadSubmissionsRequest() when $default != null:
        return $default(_that.submissions);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BulkUploadSubmissionsRequest implements BulkUploadSubmissionsRequest {
  const _BulkUploadSubmissionsRequest(
      {required final List<StudentAnswersInput> submissions})
      : _submissions = submissions;
  factory _BulkUploadSubmissionsRequest.fromJson(Map<String, dynamic> json) =>
      _$BulkUploadSubmissionsRequestFromJson(json);

  final List<StudentAnswersInput> _submissions;
  @override
  List<StudentAnswersInput> get submissions {
    if (_submissions is EqualUnmodifiableListView) return _submissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_submissions);
  }

  /// Create a copy of BulkUploadSubmissionsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BulkUploadSubmissionsRequestCopyWith<_BulkUploadSubmissionsRequest>
      get copyWith => __$BulkUploadSubmissionsRequestCopyWithImpl<
          _BulkUploadSubmissionsRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BulkUploadSubmissionsRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BulkUploadSubmissionsRequest &&
            const DeepCollectionEquality()
                .equals(other._submissions, _submissions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_submissions));

  @override
  String toString() {
    return 'BulkUploadSubmissionsRequest(submissions: $submissions)';
  }
}

/// @nodoc
abstract mixin class _$BulkUploadSubmissionsRequestCopyWith<$Res>
    implements $BulkUploadSubmissionsRequestCopyWith<$Res> {
  factory _$BulkUploadSubmissionsRequestCopyWith(
          _BulkUploadSubmissionsRequest value,
          $Res Function(_BulkUploadSubmissionsRequest) _then) =
      __$BulkUploadSubmissionsRequestCopyWithImpl;
  @override
  @useResult
  $Res call({List<StudentAnswersInput> submissions});
}

/// @nodoc
class __$BulkUploadSubmissionsRequestCopyWithImpl<$Res>
    implements _$BulkUploadSubmissionsRequestCopyWith<$Res> {
  __$BulkUploadSubmissionsRequestCopyWithImpl(this._self, this._then);

  final _BulkUploadSubmissionsRequest _self;
  final $Res Function(_BulkUploadSubmissionsRequest) _then;

  /// Create a copy of BulkUploadSubmissionsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? submissions = null,
  }) {
    return _then(_BulkUploadSubmissionsRequest(
      submissions: null == submissions
          ? _self._submissions
          : submissions // ignore: cast_nullable_to_non_nullable
              as List<StudentAnswersInput>,
    ));
  }
}

// dart format on
