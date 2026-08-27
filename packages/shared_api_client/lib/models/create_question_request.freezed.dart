// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_question_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateQuestionRequest {
  QuestionType get type;
  dynamic get config;
  @JsonKey(name: 'maximum_marks')
  double get maximumMarks;

  /// Create a copy of CreateQuestionRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateQuestionRequestCopyWith<CreateQuestionRequest> get copyWith =>
      _$CreateQuestionRequestCopyWithImpl<CreateQuestionRequest>(
          this as CreateQuestionRequest, _$identity);

  /// Serializes this CreateQuestionRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateQuestionRequest &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.config, config) &&
            (identical(other.maximumMarks, maximumMarks) ||
                other.maximumMarks == maximumMarks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type,
      const DeepCollectionEquality().hash(config), maximumMarks);

  @override
  String toString() {
    return 'CreateQuestionRequest(type: $type, config: $config, maximumMarks: $maximumMarks)';
  }
}

/// @nodoc
abstract mixin class $CreateQuestionRequestCopyWith<$Res> {
  factory $CreateQuestionRequestCopyWith(CreateQuestionRequest value,
          $Res Function(CreateQuestionRequest) _then) =
      _$CreateQuestionRequestCopyWithImpl;
  @useResult
  $Res call(
      {QuestionType type,
      dynamic config,
      @JsonKey(name: 'maximum_marks') double maximumMarks});
}

/// @nodoc
class _$CreateQuestionRequestCopyWithImpl<$Res>
    implements $CreateQuestionRequestCopyWith<$Res> {
  _$CreateQuestionRequestCopyWithImpl(this._self, this._then);

  final CreateQuestionRequest _self;
  final $Res Function(CreateQuestionRequest) _then;

  /// Create a copy of CreateQuestionRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? config = freezed,
    Object? maximumMarks = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as QuestionType,
      config: freezed == config
          ? _self.config
          : config // ignore: cast_nullable_to_non_nullable
              as dynamic,
      maximumMarks: null == maximumMarks
          ? _self.maximumMarks
          : maximumMarks // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [CreateQuestionRequest].
extension CreateQuestionRequestPatterns on CreateQuestionRequest {
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
    TResult Function(_CreateQuestionRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateQuestionRequest() when $default != null:
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
    TResult Function(_CreateQuestionRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateQuestionRequest():
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
    TResult? Function(_CreateQuestionRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateQuestionRequest() when $default != null:
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
    TResult Function(QuestionType type, dynamic config,
            @JsonKey(name: 'maximum_marks') double maximumMarks)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateQuestionRequest() when $default != null:
        return $default(_that.type, _that.config, _that.maximumMarks);
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
    TResult Function(QuestionType type, dynamic config,
            @JsonKey(name: 'maximum_marks') double maximumMarks)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateQuestionRequest():
        return $default(_that.type, _that.config, _that.maximumMarks);
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
    TResult? Function(QuestionType type, dynamic config,
            @JsonKey(name: 'maximum_marks') double maximumMarks)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateQuestionRequest() when $default != null:
        return $default(_that.type, _that.config, _that.maximumMarks);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CreateQuestionRequest implements CreateQuestionRequest {
  const _CreateQuestionRequest(
      {required this.type,
      required this.config,
      @JsonKey(name: 'maximum_marks') required this.maximumMarks});
  factory _CreateQuestionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateQuestionRequestFromJson(json);

  @override
  final QuestionType type;
  @override
  final dynamic config;
  @override
  @JsonKey(name: 'maximum_marks')
  final double maximumMarks;

  /// Create a copy of CreateQuestionRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateQuestionRequestCopyWith<_CreateQuestionRequest> get copyWith =>
      __$CreateQuestionRequestCopyWithImpl<_CreateQuestionRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CreateQuestionRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateQuestionRequest &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.config, config) &&
            (identical(other.maximumMarks, maximumMarks) ||
                other.maximumMarks == maximumMarks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type,
      const DeepCollectionEquality().hash(config), maximumMarks);

  @override
  String toString() {
    return 'CreateQuestionRequest(type: $type, config: $config, maximumMarks: $maximumMarks)';
  }
}

/// @nodoc
abstract mixin class _$CreateQuestionRequestCopyWith<$Res>
    implements $CreateQuestionRequestCopyWith<$Res> {
  factory _$CreateQuestionRequestCopyWith(_CreateQuestionRequest value,
          $Res Function(_CreateQuestionRequest) _then) =
      __$CreateQuestionRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {QuestionType type,
      dynamic config,
      @JsonKey(name: 'maximum_marks') double maximumMarks});
}

/// @nodoc
class __$CreateQuestionRequestCopyWithImpl<$Res>
    implements _$CreateQuestionRequestCopyWith<$Res> {
  __$CreateQuestionRequestCopyWithImpl(this._self, this._then);

  final _CreateQuestionRequest _self;
  final $Res Function(_CreateQuestionRequest) _then;

  /// Create a copy of CreateQuestionRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? config = freezed,
    Object? maximumMarks = null,
  }) {
    return _then(_CreateQuestionRequest(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as QuestionType,
      config: freezed == config
          ? _self.config
          : config // ignore: cast_nullable_to_non_nullable
              as dynamic,
      maximumMarks: null == maximumMarks
          ? _self.maximumMarks
          : maximumMarks // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
