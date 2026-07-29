// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pendingVerificationControllerHash() =>
    r'5d93ad956d3affa4d8c85fa0ad264b81add993a4';

/// Holds the pending verification between the signup and OTP screens. Null when
/// nothing is awaiting verification.
///
/// Copied from [PendingVerificationController].
@ProviderFor(PendingVerificationController)
final pendingVerificationControllerProvider = NotifierProvider<
    PendingVerificationController, PendingVerification?>.internal(
  PendingVerificationController.new,
  name: r'pendingVerificationControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pendingVerificationControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PendingVerificationController = Notifier<PendingVerification?>;
String _$authControllerHash() => r'ecc3924c2e90f908fd2422d611c7290a82808fd6';

/// Holds the authenticated [User] (or null when signed out). On startup it
/// tries to load the current user from a persisted token.
///
/// Copied from [AuthController].
@ProviderFor(AuthController)
final authControllerProvider =
    AsyncNotifierProvider<AuthController, User?>.internal(
  AuthController.new,
  name: r'authControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthController = AsyncNotifier<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
