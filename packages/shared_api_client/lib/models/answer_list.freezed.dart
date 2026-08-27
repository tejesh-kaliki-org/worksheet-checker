// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'answer_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnswerList {
  List<Answer> get answers;

  /// Create a copy of AnswerList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AnswerListCopyWith<AnswerList> get copyWith =>
      _$AnswerListCopyWithImpl<AnswerList>(this as AnswerList, _$identity);

  /// Serializes this AnswerList to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AnswerList &&
            const DeepCollectionEquality().equals(other.answers, answers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(answers));

  @override
  String toString() {
    return 'AnswerList(answers: $answers)';
  }
}

/// @nodoc
abstract mixin class $AnswerListCopyWith<$Res> {
  factory $AnswerListCopyWith(
          AnswerList value, $Res Function(AnswerList) _then) =
      _$AnswerListCopyWithImpl;
  @useResult
  $Res call({List<Answer> answers});
}

/// @nodoc
class _$AnswerListCopyWithImpl<$Res> implements $AnswerListCopyWith<$Res> {
  _$AnswerListCopyWithImpl(this._self, this._then);

  final AnswerList _self;
  final $Res Function(AnswerList) _then;

  /// Create a copy of AnswerList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answers = null,
  }) {
    return _then(_self.copyWith(
      answers: null == answers
          ? _self.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<Answer>,
    ));
  }
}

/// Adds pattern-matching-related methods to [AnswerList].
extension AnswerListPatterns on AnswerList {
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
    TResult Function(_AnswerList value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AnswerList() when $default != null:
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
    TResult Function(_AnswerList value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnswerList():
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
    TResult? Function(_AnswerList value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnswerList() when $default != null:
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
    TResult Function(List<Answer> answers)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AnswerList() when $default != null:
        return $default(_that.answers);
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
    TResult Function(List<Answer> answers) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnswerList():
        return $default(_that.answers);
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
    TResult? Function(List<Answer> answers)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnswerList() when $default != null:
        return $default(_that.answers);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AnswerList implements AnswerList {
  const _AnswerList({required final List<Answer> answers}) : _answers = answers;
  factory _AnswerList.fromJson(Map<String, dynamic> json) =>
      _$AnswerListFromJson(json);

  final List<Answer> _answers;
  @override
  List<Answer> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  /// Create a copy of AnswerList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AnswerListCopyWith<_AnswerList> get copyWith =>
      __$AnswerListCopyWithImpl<_AnswerList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AnswerListToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AnswerList &&
            const DeepCollectionEquality().equals(other._answers, _answers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_answers));

  @override
  String toString() {
    return 'AnswerList(answers: $answers)';
  }
}

/// @nodoc
abstract mixin class _$AnswerListCopyWith<$Res>
    implements $AnswerListCopyWith<$Res> {
  factory _$AnswerListCopyWith(
          _AnswerList value, $Res Function(_AnswerList) _then) =
      __$AnswerListCopyWithImpl;
  @override
  @useResult
  $Res call({List<Answer> answers});
}

/// @nodoc
class __$AnswerListCopyWithImpl<$Res> implements _$AnswerListCopyWith<$Res> {
  __$AnswerListCopyWithImpl(this._self, this._then);

  final _AnswerList _self;
  final $Res Function(_AnswerList) _then;

  /// Create a copy of AnswerList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? answers = null,
  }) {
    return _then(_AnswerList(
      answers: null == answers
          ? _self._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<Answer>,
    ));
  }
}

// dart format on
