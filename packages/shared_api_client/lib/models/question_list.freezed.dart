// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestionList {
  List<Question> get questions;

  /// Create a copy of QuestionList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuestionListCopyWith<QuestionList> get copyWith =>
      _$QuestionListCopyWithImpl<QuestionList>(
          this as QuestionList, _$identity);

  /// Serializes this QuestionList to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuestionList &&
            const DeepCollectionEquality().equals(other.questions, questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(questions));

  @override
  String toString() {
    return 'QuestionList(questions: $questions)';
  }
}

/// @nodoc
abstract mixin class $QuestionListCopyWith<$Res> {
  factory $QuestionListCopyWith(
          QuestionList value, $Res Function(QuestionList) _then) =
      _$QuestionListCopyWithImpl;
  @useResult
  $Res call({List<Question> questions});
}

/// @nodoc
class _$QuestionListCopyWithImpl<$Res> implements $QuestionListCopyWith<$Res> {
  _$QuestionListCopyWithImpl(this._self, this._then);

  final QuestionList _self;
  final $Res Function(QuestionList) _then;

  /// Create a copy of QuestionList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
  }) {
    return _then(_self.copyWith(
      questions: null == questions
          ? _self.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
    ));
  }
}

/// Adds pattern-matching-related methods to [QuestionList].
extension QuestionListPatterns on QuestionList {
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
    TResult Function(_QuestionList value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuestionList() when $default != null:
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
    TResult Function(_QuestionList value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuestionList():
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
    TResult? Function(_QuestionList value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuestionList() when $default != null:
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
    TResult Function(List<Question> questions)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuestionList() when $default != null:
        return $default(_that.questions);
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
    TResult Function(List<Question> questions) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuestionList():
        return $default(_that.questions);
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
    TResult? Function(List<Question> questions)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuestionList() when $default != null:
        return $default(_that.questions);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _QuestionList implements QuestionList {
  const _QuestionList({required final List<Question> questions})
      : _questions = questions;
  factory _QuestionList.fromJson(Map<String, dynamic> json) =>
      _$QuestionListFromJson(json);

  final List<Question> _questions;
  @override
  List<Question> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  /// Create a copy of QuestionList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuestionListCopyWith<_QuestionList> get copyWith =>
      __$QuestionListCopyWithImpl<_QuestionList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuestionListToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuestionList &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_questions));

  @override
  String toString() {
    return 'QuestionList(questions: $questions)';
  }
}

/// @nodoc
abstract mixin class _$QuestionListCopyWith<$Res>
    implements $QuestionListCopyWith<$Res> {
  factory _$QuestionListCopyWith(
          _QuestionList value, $Res Function(_QuestionList) _then) =
      __$QuestionListCopyWithImpl;
  @override
  @useResult
  $Res call({List<Question> questions});
}

/// @nodoc
class __$QuestionListCopyWithImpl<$Res>
    implements _$QuestionListCopyWith<$Res> {
  __$QuestionListCopyWithImpl(this._self, this._then);

  final _QuestionList _self;
  final $Res Function(_QuestionList) _then;

  /// Create a copy of QuestionList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? questions = null,
  }) {
    return _then(_QuestionList(
      questions: null == questions
          ? _self._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
    ));
  }
}

// dart format on
