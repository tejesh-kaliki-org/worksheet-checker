// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignupResponse {
  User get user;

  /// Short-lived token identifying the just-created (unverified) account. Submit it with the emailed OTP to POST /auth/verify to obtain a session. No access/refresh token is issued until the email is verified.
  @JsonKey(name: 'verification_token')
  String get verificationToken;

  /// Create a copy of SignupResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignupResponseCopyWith<SignupResponse> get copyWith =>
      _$SignupResponseCopyWithImpl<SignupResponse>(
          this as SignupResponse, _$identity);

  /// Serializes this SignupResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignupResponse &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.verificationToken, verificationToken) ||
                other.verificationToken == verificationToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, verificationToken);

  @override
  String toString() {
    return 'SignupResponse(user: $user, verificationToken: $verificationToken)';
  }
}

/// @nodoc
abstract mixin class $SignupResponseCopyWith<$Res> {
  factory $SignupResponseCopyWith(
          SignupResponse value, $Res Function(SignupResponse) _then) =
      _$SignupResponseCopyWithImpl;
  @useResult
  $Res call(
      {User user,
      @JsonKey(name: 'verification_token') String verificationToken});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$SignupResponseCopyWithImpl<$Res>
    implements $SignupResponseCopyWith<$Res> {
  _$SignupResponseCopyWithImpl(this._self, this._then);

  final SignupResponse _self;
  final $Res Function(SignupResponse) _then;

  /// Create a copy of SignupResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? verificationToken = null,
  }) {
    return _then(_self.copyWith(
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      verificationToken: null == verificationToken
          ? _self.verificationToken
          : verificationToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of SignupResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SignupResponse].
extension SignupResponsePatterns on SignupResponse {
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
    TResult Function(_SignupResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SignupResponse() when $default != null:
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
    TResult Function(_SignupResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignupResponse():
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
    TResult? Function(_SignupResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignupResponse() when $default != null:
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
    TResult Function(User user,
            @JsonKey(name: 'verification_token') String verificationToken)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SignupResponse() when $default != null:
        return $default(_that.user, _that.verificationToken);
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
    TResult Function(User user,
            @JsonKey(name: 'verification_token') String verificationToken)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignupResponse():
        return $default(_that.user, _that.verificationToken);
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
    TResult? Function(User user,
            @JsonKey(name: 'verification_token') String verificationToken)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignupResponse() when $default != null:
        return $default(_that.user, _that.verificationToken);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SignupResponse implements SignupResponse {
  const _SignupResponse(
      {required this.user,
      @JsonKey(name: 'verification_token') required this.verificationToken});
  factory _SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  @override
  final User user;

  /// Short-lived token identifying the just-created (unverified) account. Submit it with the emailed OTP to POST /auth/verify to obtain a session. No access/refresh token is issued until the email is verified.
  @override
  @JsonKey(name: 'verification_token')
  final String verificationToken;

  /// Create a copy of SignupResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SignupResponseCopyWith<_SignupResponse> get copyWith =>
      __$SignupResponseCopyWithImpl<_SignupResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SignupResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignupResponse &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.verificationToken, verificationToken) ||
                other.verificationToken == verificationToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, verificationToken);

  @override
  String toString() {
    return 'SignupResponse(user: $user, verificationToken: $verificationToken)';
  }
}

/// @nodoc
abstract mixin class _$SignupResponseCopyWith<$Res>
    implements $SignupResponseCopyWith<$Res> {
  factory _$SignupResponseCopyWith(
          _SignupResponse value, $Res Function(_SignupResponse) _then) =
      __$SignupResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {User user,
      @JsonKey(name: 'verification_token') String verificationToken});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$SignupResponseCopyWithImpl<$Res>
    implements _$SignupResponseCopyWith<$Res> {
  __$SignupResponseCopyWithImpl(this._self, this._then);

  final _SignupResponse _self;
  final $Res Function(_SignupResponse) _then;

  /// Create a copy of SignupResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = null,
    Object? verificationToken = null,
  }) {
    return _then(_SignupResponse(
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      verificationToken: null == verificationToken
          ? _self.verificationToken
          : verificationToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of SignupResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

// dart format on
