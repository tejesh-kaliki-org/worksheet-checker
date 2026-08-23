// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExamList {
  List<Exam> get exams;

  /// Create a copy of ExamList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExamListCopyWith<ExamList> get copyWith =>
      _$ExamListCopyWithImpl<ExamList>(this as ExamList, _$identity);

  /// Serializes this ExamList to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExamList &&
            const DeepCollectionEquality().equals(other.exams, exams));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(exams));

  @override
  String toString() {
    return 'ExamList(exams: $exams)';
  }
}

/// @nodoc
abstract mixin class $ExamListCopyWith<$Res> {
  factory $ExamListCopyWith(ExamList value, $Res Function(ExamList) _then) =
      _$ExamListCopyWithImpl;
  @useResult
  $Res call({List<Exam> exams});
}

/// @nodoc
class _$ExamListCopyWithImpl<$Res> implements $ExamListCopyWith<$Res> {
  _$ExamListCopyWithImpl(this._self, this._then);

  final ExamList _self;
  final $Res Function(ExamList) _then;

  /// Create a copy of ExamList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exams = null,
  }) {
    return _then(_self.copyWith(
      exams: null == exams
          ? _self.exams
          : exams // ignore: cast_nullable_to_non_nullable
              as List<Exam>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExamList].
extension ExamListPatterns on ExamList {
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
    TResult Function(_ExamList value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExamList() when $default != null:
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
    TResult Function(_ExamList value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamList():
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
    TResult? Function(_ExamList value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamList() when $default != null:
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
    TResult Function(List<Exam> exams)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExamList() when $default != null:
        return $default(_that.exams);
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
    TResult Function(List<Exam> exams) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamList():
        return $default(_that.exams);
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
    TResult? Function(List<Exam> exams)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamList() when $default != null:
        return $default(_that.exams);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExamList implements ExamList {
  const _ExamList({required final List<Exam> exams}) : _exams = exams;
  factory _ExamList.fromJson(Map<String, dynamic> json) =>
      _$ExamListFromJson(json);

  final List<Exam> _exams;
  @override
  List<Exam> get exams {
    if (_exams is EqualUnmodifiableListView) return _exams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exams);
  }

  /// Create a copy of ExamList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExamListCopyWith<_ExamList> get copyWith =>
      __$ExamListCopyWithImpl<_ExamList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExamListToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExamList &&
            const DeepCollectionEquality().equals(other._exams, _exams));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_exams));

  @override
  String toString() {
    return 'ExamList(exams: $exams)';
  }
}

/// @nodoc
abstract mixin class _$ExamListCopyWith<$Res>
    implements $ExamListCopyWith<$Res> {
  factory _$ExamListCopyWith(_ExamList value, $Res Function(_ExamList) _then) =
      __$ExamListCopyWithImpl;
  @override
  @useResult
  $Res call({List<Exam> exams});
}

/// @nodoc
class __$ExamListCopyWithImpl<$Res> implements _$ExamListCopyWith<$Res> {
  __$ExamListCopyWithImpl(this._self, this._then);

  final _ExamList _self;
  final $Res Function(_ExamList) _then;

  /// Create a copy of ExamList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? exams = null,
  }) {
    return _then(_ExamList(
      exams: null == exams
          ? _self._exams
          : exams // ignore: cast_nullable_to_non_nullable
              as List<Exam>,
    ));
  }
}

// dart format on
