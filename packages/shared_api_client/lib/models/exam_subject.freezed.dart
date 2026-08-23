// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam_subject.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExamSubject {
  String get id;
  @JsonKey(name: 'exam_id')
  String get examId;
  @JsonKey(name: 'subject_id')
  String get subjectId;

  /// Create a copy of ExamSubject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExamSubjectCopyWith<ExamSubject> get copyWith =>
      _$ExamSubjectCopyWithImpl<ExamSubject>(this as ExamSubject, _$identity);

  /// Serializes this ExamSubject to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExamSubject &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.examId, examId) || other.examId == examId) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, examId, subjectId);

  @override
  String toString() {
    return 'ExamSubject(id: $id, examId: $examId, subjectId: $subjectId)';
  }
}

/// @nodoc
abstract mixin class $ExamSubjectCopyWith<$Res> {
  factory $ExamSubjectCopyWith(
          ExamSubject value, $Res Function(ExamSubject) _then) =
      _$ExamSubjectCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'exam_id') String examId,
      @JsonKey(name: 'subject_id') String subjectId});
}

/// @nodoc
class _$ExamSubjectCopyWithImpl<$Res> implements $ExamSubjectCopyWith<$Res> {
  _$ExamSubjectCopyWithImpl(this._self, this._then);

  final ExamSubject _self;
  final $Res Function(ExamSubject) _then;

  /// Create a copy of ExamSubject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? examId = null,
    Object? subjectId = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      examId: null == examId
          ? _self.examId
          : examId // ignore: cast_nullable_to_non_nullable
              as String,
      subjectId: null == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExamSubject].
extension ExamSubjectPatterns on ExamSubject {
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
    TResult Function(_ExamSubject value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExamSubject() when $default != null:
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
    TResult Function(_ExamSubject value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamSubject():
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
    TResult? Function(_ExamSubject value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamSubject() when $default != null:
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
    TResult Function(String id, @JsonKey(name: 'exam_id') String examId,
            @JsonKey(name: 'subject_id') String subjectId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExamSubject() when $default != null:
        return $default(_that.id, _that.examId, _that.subjectId);
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
    TResult Function(String id, @JsonKey(name: 'exam_id') String examId,
            @JsonKey(name: 'subject_id') String subjectId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamSubject():
        return $default(_that.id, _that.examId, _that.subjectId);
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
    TResult? Function(String id, @JsonKey(name: 'exam_id') String examId,
            @JsonKey(name: 'subject_id') String subjectId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExamSubject() when $default != null:
        return $default(_that.id, _that.examId, _that.subjectId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExamSubject implements ExamSubject {
  const _ExamSubject(
      {required this.id,
      @JsonKey(name: 'exam_id') required this.examId,
      @JsonKey(name: 'subject_id') required this.subjectId});
  factory _ExamSubject.fromJson(Map<String, dynamic> json) =>
      _$ExamSubjectFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'exam_id')
  final String examId;
  @override
  @JsonKey(name: 'subject_id')
  final String subjectId;

  /// Create a copy of ExamSubject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExamSubjectCopyWith<_ExamSubject> get copyWith =>
      __$ExamSubjectCopyWithImpl<_ExamSubject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExamSubjectToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExamSubject &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.examId, examId) || other.examId == examId) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, examId, subjectId);

  @override
  String toString() {
    return 'ExamSubject(id: $id, examId: $examId, subjectId: $subjectId)';
  }
}

/// @nodoc
abstract mixin class _$ExamSubjectCopyWith<$Res>
    implements $ExamSubjectCopyWith<$Res> {
  factory _$ExamSubjectCopyWith(
          _ExamSubject value, $Res Function(_ExamSubject) _then) =
      __$ExamSubjectCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'exam_id') String examId,
      @JsonKey(name: 'subject_id') String subjectId});
}

/// @nodoc
class __$ExamSubjectCopyWithImpl<$Res> implements _$ExamSubjectCopyWith<$Res> {
  __$ExamSubjectCopyWithImpl(this._self, this._then);

  final _ExamSubject _self;
  final $Res Function(_ExamSubject) _then;

  /// Create a copy of ExamSubject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? examId = null,
    Object? subjectId = null,
  }) {
    return _then(_ExamSubject(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      examId: null == examId
          ? _self.examId
          : examId // ignore: cast_nullable_to_non_nullable
              as String,
      subjectId: null == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
