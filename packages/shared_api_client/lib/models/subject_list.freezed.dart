// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubjectList {
  List<Subject> get subjects;

  /// Create a copy of SubjectList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubjectListCopyWith<SubjectList> get copyWith =>
      _$SubjectListCopyWithImpl<SubjectList>(this as SubjectList, _$identity);

  /// Serializes this SubjectList to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubjectList &&
            const DeepCollectionEquality().equals(other.subjects, subjects));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(subjects));

  @override
  String toString() {
    return 'SubjectList(subjects: $subjects)';
  }
}

/// @nodoc
abstract mixin class $SubjectListCopyWith<$Res> {
  factory $SubjectListCopyWith(
          SubjectList value, $Res Function(SubjectList) _then) =
      _$SubjectListCopyWithImpl;
  @useResult
  $Res call({List<Subject> subjects});
}

/// @nodoc
class _$SubjectListCopyWithImpl<$Res> implements $SubjectListCopyWith<$Res> {
  _$SubjectListCopyWithImpl(this._self, this._then);

  final SubjectList _self;
  final $Res Function(SubjectList) _then;

  /// Create a copy of SubjectList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subjects = null,
  }) {
    return _then(_self.copyWith(
      subjects: null == subjects
          ? _self.subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as List<Subject>,
    ));
  }
}

/// Adds pattern-matching-related methods to [SubjectList].
extension SubjectListPatterns on SubjectList {
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
    TResult Function(_SubjectList value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubjectList() when $default != null:
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
    TResult Function(_SubjectList value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubjectList():
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
    TResult? Function(_SubjectList value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubjectList() when $default != null:
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
    TResult Function(List<Subject> subjects)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubjectList() when $default != null:
        return $default(_that.subjects);
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
    TResult Function(List<Subject> subjects) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubjectList():
        return $default(_that.subjects);
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
    TResult? Function(List<Subject> subjects)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubjectList() when $default != null:
        return $default(_that.subjects);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SubjectList implements SubjectList {
  const _SubjectList({required final List<Subject> subjects})
      : _subjects = subjects;
  factory _SubjectList.fromJson(Map<String, dynamic> json) =>
      _$SubjectListFromJson(json);

  final List<Subject> _subjects;
  @override
  List<Subject> get subjects {
    if (_subjects is EqualUnmodifiableListView) return _subjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subjects);
  }

  /// Create a copy of SubjectList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubjectListCopyWith<_SubjectList> get copyWith =>
      __$SubjectListCopyWithImpl<_SubjectList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubjectListToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubjectList &&
            const DeepCollectionEquality().equals(other._subjects, _subjects));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_subjects));

  @override
  String toString() {
    return 'SubjectList(subjects: $subjects)';
  }
}

/// @nodoc
abstract mixin class _$SubjectListCopyWith<$Res>
    implements $SubjectListCopyWith<$Res> {
  factory _$SubjectListCopyWith(
          _SubjectList value, $Res Function(_SubjectList) _then) =
      __$SubjectListCopyWithImpl;
  @override
  @useResult
  $Res call({List<Subject> subjects});
}

/// @nodoc
class __$SubjectListCopyWithImpl<$Res> implements _$SubjectListCopyWith<$Res> {
  __$SubjectListCopyWithImpl(this._self, this._then);

  final _SubjectList _self;
  final $Res Function(_SubjectList) _then;

  /// Create a copy of SubjectList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? subjects = null,
  }) {
    return _then(_SubjectList(
      subjects: null == subjects
          ? _self._subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as List<Subject>,
    ));
  }
}

// dart format on
