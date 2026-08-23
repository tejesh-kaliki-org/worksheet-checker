// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam_subject_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExamSubjectList {
  @JsonKey(name: 'exam_subjects')
  List<ExamSubject> get examSubjects;

  /// Create a copy of ExamSubjectList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExamSubjectListCopyWith<ExamSubjectList> get copyWith =>
      _$ExamSubjectListCopyWithImpl<ExamSubjectList>(
          this as ExamSubjectList, _$identity);

  /// Serializes this ExamSubjectList to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExamSubjectList &&
            const DeepCollectionEquality()
                .equals(other.examSubjects, examSubjects));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(examSubjects));

  @override
  String toString() {
    return 'ExamSubjectList(examSubjects: $examSubjects)';
  }
}

/// @nodoc
abstract mixin class $ExamSubjectListCopyWith<$Res> {
  factory $ExamSubjectListCopyWith(
          ExamSubjectList value, $Res Function(ExamSubjectList) _then) =
      _$ExamSubjectListCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: 'exam_subjects') List<ExamSubject> examSubjects});
}

/// @nodoc
class _$ExamSubjectListCopyWithImpl<$Res>
    implements $ExamSubjectListCopyWith<$Res> {
  _$ExamSubjectListCopyWithImpl(this._self, this._then);

  final ExamSubjectList _self;
  final $Res Function(ExamSubjectList) _then;

  /// Create a copy of ExamSubjectList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? examSubjects = null,
  }) {
    return _then(_self.copyWith(
      examSubjects: null == examSubjects
          ? _self.examSubjects
          : examSubjects // ignore: cast_nullable_to_non_nullable
              as List<ExamSubject>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExamSubjectList].
extension ExamSubjectListPatterns on ExamSubjectList {
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
    TResult Function(_ExamSubjectList value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExamSubjectList() when $default != null:
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
    TResult Function(_ExamSubjectList value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamSubjectList():
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
    TResult? Function(_ExamSubjectList value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamSubjectList() when $default != null:
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
            @JsonKey(name: 'exam_subjects') List<ExamSubject> examSubjects)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExamSubjectList() when $default != null:
        return $default(_that.examSubjects);
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
            @JsonKey(name: 'exam_subjects') List<ExamSubject> examSubjects)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamSubjectList():
        return $default(_that.examSubjects);
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
            @JsonKey(name: 'exam_subjects') List<ExamSubject> examSubjects)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamSubjectList() when $default != null:
        return $default(_that.examSubjects);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExamSubjectList implements ExamSubjectList {
  const _ExamSubjectList(
      {@JsonKey(name: 'exam_subjects')
      required final List<ExamSubject> examSubjects})
      : _examSubjects = examSubjects;
  factory _ExamSubjectList.fromJson(Map<String, dynamic> json) =>
      _$ExamSubjectListFromJson(json);

  final List<ExamSubject> _examSubjects;
  @override
  @JsonKey(name: 'exam_subjects')
  List<ExamSubject> get examSubjects {
    if (_examSubjects is EqualUnmodifiableListView) return _examSubjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_examSubjects);
  }

  /// Create a copy of ExamSubjectList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExamSubjectListCopyWith<_ExamSubjectList> get copyWith =>
      __$ExamSubjectListCopyWithImpl<_ExamSubjectList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExamSubjectListToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExamSubjectList &&
            const DeepCollectionEquality()
                .equals(other._examSubjects, _examSubjects));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_examSubjects));

  @override
  String toString() {
    return 'ExamSubjectList(examSubjects: $examSubjects)';
  }
}

/// @nodoc
abstract mixin class _$ExamSubjectListCopyWith<$Res>
    implements $ExamSubjectListCopyWith<$Res> {
  factory _$ExamSubjectListCopyWith(
          _ExamSubjectList value, $Res Function(_ExamSubjectList) _then) =
      __$ExamSubjectListCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: 'exam_subjects') List<ExamSubject> examSubjects});
}

/// @nodoc
class __$ExamSubjectListCopyWithImpl<$Res>
    implements _$ExamSubjectListCopyWith<$Res> {
  __$ExamSubjectListCopyWithImpl(this._self, this._then);

  final _ExamSubjectList _self;
  final $Res Function(_ExamSubjectList) _then;

  /// Create a copy of ExamSubjectList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? examSubjects = null,
  }) {
    return _then(_ExamSubjectList(
      examSubjects: null == examSubjects
          ? _self._examSubjects
          : examSubjects // ignore: cast_nullable_to_non_nullable
              as List<ExamSubject>,
    ));
  }
}

// dart format on
