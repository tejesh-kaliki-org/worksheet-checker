// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/auth_response.dart';
import '../models/login_request.dart';
import '../models/password_reset_confirm.dart';
import '../models/password_reset_request.dart';
import '../models/refresh_request.dart';
import '../models/signup_request.dart';
import '../models/signup_response.dart';
import '../models/user.dart';
import '../models/verify_request.dart';

part 'auth_client.g.dart';

@RestApi()
abstract class AuthClient {
  factory AuthClient(Dio dio, {String? baseUrl}) = _AuthClient;

  @POST('/auth/signup')
  Future<SignupResponse> signup({
    @Body() required SignupRequest body,
    @DioOptions() RequestOptions? options,
  });

  @POST('/auth/login')
  Future<AuthResponse> login({
    @Body() required LoginRequest body,
    @DioOptions() RequestOptions? options,
  });

  @POST('/auth/refresh')
  Future<AuthResponse> refreshToken({
    @Body() required RefreshRequest body,
    @DioOptions() RequestOptions? options,
  });

  @POST('/auth/logout')
  Future<void> logout({
    @Body() required RefreshRequest body,
    @DioOptions() RequestOptions? options,
  });

  @GET('/auth/me')
  Future<User> getCurrentUser({
    @DioOptions() RequestOptions? options,
  });

  @POST('/auth/verify')
  Future<AuthResponse> verifyEmail({
    @Body() required VerifyRequest body,
    @DioOptions() RequestOptions? options,
  });

  @POST('/auth/password-reset/request')
  Future<void> requestPasswordReset({
    @Body() required PasswordResetRequest body,
    @DioOptions() RequestOptions? options,
  });

  @POST('/auth/password-reset/confirm')
  Future<void> confirmPasswordReset({
    @Body() required PasswordResetConfirm body,
    @DioOptions() RequestOptions? options,
  });
}
