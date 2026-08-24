// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClassList {
  List<Class> get classes;

  /// Create a copy of ClassList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClassListCopyWith<ClassList> get copyWith =>
      _$ClassListCopyWithImpl<ClassList>(this as ClassList, _$identity);

  /// Serializes this ClassList to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClassList &&
            const DeepCollectionEquality().equals(other.classes, classes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(classes));

  @override
  String toString() {
    return 'ClassList(classes: $classes)';
  }
}

/// @nodoc
abstract mixin class $ClassListCopyWith<$Res> {
  factory $ClassListCopyWith(ClassList value, $Res Function(ClassList) _then) =
      _$ClassListCopyWithImpl;
  @useResult
  $Res call({List<Class> classes});
}

/// @nodoc
class _$ClassListCopyWithImpl<$Res> implements $ClassListCopyWith<$Res> {
  _$ClassListCopyWithImpl(this._self, this._then);

  final ClassList _self;
  final $Res Function(ClassList) _then;

  /// Create a copy of ClassList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classes = null,
  }) {
    return _then(_self.copyWith(
      classes: null == classes
          ? _self.classes
          : classes // ignore: cast_nullable_to_non_nullable
              as List<Class>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClassList].
extension ClassListPatterns on ClassList {
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
    TResult Function(_ClassList value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClassList() when $default != null:
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
    TResult Function(_ClassList value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassList():
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
    TResult? Function(_ClassList value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassList() when $default != null:
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
    TResult Function(List<Class> classes)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClassList() when $default != null:
        return $default(_that.classes);
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
    TResult Function(List<Class> classes) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassList():
        return $default(_that.classes);
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
    TResult? Function(List<Class> classes)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassList() when $default != null:
        return $default(_that.classes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ClassList implements ClassList {
  const _ClassList({required final List<Class> classes}) : _classes = classes;
  factory _ClassList.fromJson(Map<String, dynamic> json) =>
      _$ClassListFromJson(json);

  final List<Class> _classes;
  @override
  List<Class> get classes {
    if (_classes is EqualUnmodifiableListView) return _classes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_classes);
  }

  /// Create a copy of ClassList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClassListCopyWith<_ClassList> get copyWith =>
      __$ClassListCopyWithImpl<_ClassList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClassListToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClassList &&
            const DeepCollectionEquality().equals(other._classes, _classes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_classes));

  @override
  String toString() {
    return 'ClassList(classes: $classes)';
  }
}

/// @nodoc
abstract mixin class _$ClassListCopyWith<$Res>
    implements $ClassListCopyWith<$Res> {
  factory _$ClassListCopyWith(
          _ClassList value, $Res Function(_ClassList) _then) =
      __$ClassListCopyWithImpl;
  @override
  @useResult
  $Res call({List<Class> classes});
}

/// @nodoc
class __$ClassListCopyWithImpl<$Res> implements _$ClassListCopyWith<$Res> {
  __$ClassListCopyWithImpl(this._self, this._then);

  final _ClassList _self;
  final $Res Function(_ClassList) _then;

  /// Create a copy of ClassList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? classes = null,
  }) {
    return _then(_ClassList(
      classes: null == classes
          ? _self._classes
          : classes // ignore: cast_nullable_to_non_nullable
              as List<Class>,
    ));
  }
}

// dart format on
