// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudentList {
  List<Student> get students;

  /// Create a copy of StudentList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StudentListCopyWith<StudentList> get copyWith =>
      _$StudentListCopyWithImpl<StudentList>(this as StudentList, _$identity);

  /// Serializes this StudentList to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StudentList &&
            const DeepCollectionEquality().equals(other.students, students));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(students));

  @override
  String toString() {
    return 'StudentList(students: $students)';
  }
}

/// @nodoc
abstract mixin class $StudentListCopyWith<$Res> {
  factory $StudentListCopyWith(
          StudentList value, $Res Function(StudentList) _then) =
      _$StudentListCopyWithImpl;
  @useResult
  $Res call({List<Student> students});
}

/// @nodoc
class _$StudentListCopyWithImpl<$Res> implements $StudentListCopyWith<$Res> {
  _$StudentListCopyWithImpl(this._self, this._then);

  final StudentList _self;
  final $Res Function(StudentList) _then;

  /// Create a copy of StudentList
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
              as List<Student>,
    ));
  }
}

/// Adds pattern-matching-related methods to [StudentList].
extension StudentListPatterns on StudentList {
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
    TResult Function(_StudentList value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StudentList() when $default != null:
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
    TResult Function(_StudentList value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudentList():
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
    TResult? Function(_StudentList value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudentList() when $default != null:
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
    TResult Function(List<Student> students)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StudentList() when $default != null:
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
    TResult Function(List<Student> students) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudentList():
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
    TResult? Function(List<Student> students)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StudentList() when $default != null:
        return $default(_that.students);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StudentList implements StudentList {
  const _StudentList({required final List<Student> students})
      : _students = students;
  factory _StudentList.fromJson(Map<String, dynamic> json) =>
      _$StudentListFromJson(json);

  final List<Student> _students;
  @override
  List<Student> get students {
    if (_students is EqualUnmodifiableListView) return _students;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_students);
  }

  /// Create a copy of StudentList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StudentListCopyWith<_StudentList> get copyWith =>
      __$StudentListCopyWithImpl<_StudentList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StudentListToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StudentList &&
            const DeepCollectionEquality().equals(other._students, _students));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_students));

  @override
  String toString() {
    return 'StudentList(students: $students)';
  }
}

/// @nodoc
abstract mixin class _$StudentListCopyWith<$Res>
    implements $StudentListCopyWith<$Res> {
  factory _$StudentListCopyWith(
          _StudentList value, $Res Function(_StudentList) _then) =
      __$StudentListCopyWithImpl;
  @override
  @useResult
  $Res call({List<Student> students});
}

/// @nodoc
class __$StudentListCopyWithImpl<$Res> implements _$StudentListCopyWith<$Res> {
  __$StudentListCopyWithImpl(this._self, this._then);

  final _StudentList _self;
  final $Res Function(_StudentList) _then;

  /// Create a copy of StudentList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? students = null,
  }) {
    return _then(_StudentList(
      students: null == students
          ? _self._students
          : students // ignore: cast_nullable_to_non_nullable
              as List<Student>,
    ));
  }
}

// dart format on
