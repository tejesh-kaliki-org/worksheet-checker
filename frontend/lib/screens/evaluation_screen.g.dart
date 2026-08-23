// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluation_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$evaluationAttemptsHash() =>
    r'9b650e387dd3c4e4cb0ea27d8b9767769bddf498';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [evaluationAttempts].
@ProviderFor(evaluationAttempts)
const evaluationAttemptsProvider = EvaluationAttemptsFamily();

/// See also [evaluationAttempts].
class EvaluationAttemptsFamily
    extends Family<AsyncValue<List<EvaluationAttempt>>> {
  /// See also [evaluationAttempts].
  const EvaluationAttemptsFamily();

  /// See also [evaluationAttempts].
  EvaluationAttemptsProvider call(
    String answerId,
  ) {
    return EvaluationAttemptsProvider(
      answerId,
    );
  }

  @override
  EvaluationAttemptsProvider getProviderOverride(
    covariant EvaluationAttemptsProvider provider,
  ) {
    return call(
      provider.answerId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'evaluationAttemptsProvider';
}

/// See also [evaluationAttempts].
class EvaluationAttemptsProvider
    extends AutoDisposeFutureProvider<List<EvaluationAttempt>> {
  /// See also [evaluationAttempts].
  EvaluationAttemptsProvider(
    String answerId,
  ) : this._internal(
          (ref) => evaluationAttempts(
            ref as EvaluationAttemptsRef,
            answerId,
          ),
          from: evaluationAttemptsProvider,
          name: r'evaluationAttemptsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$evaluationAttemptsHash,
          dependencies: EvaluationAttemptsFamily._dependencies,
          allTransitiveDependencies:
              EvaluationAttemptsFamily._allTransitiveDependencies,
          answerId: answerId,
        );

  EvaluationAttemptsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.answerId,
  }) : super.internal();

  final String answerId;

  @override
  Override overrideWith(
    FutureOr<List<EvaluationAttempt>> Function(EvaluationAttemptsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EvaluationAttemptsProvider._internal(
        (ref) => create(ref as EvaluationAttemptsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        answerId: answerId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<EvaluationAttempt>> createElement() {
    return _EvaluationAttemptsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EvaluationAttemptsProvider && other.answerId == answerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, answerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EvaluationAttemptsRef
    on AutoDisposeFutureProviderRef<List<EvaluationAttempt>> {
  /// The parameter `answerId` of this provider.
  String get answerId;
}

class _EvaluationAttemptsProviderElement
    extends AutoDisposeFutureProviderElement<List<EvaluationAttempt>>
    with EvaluationAttemptsRef {
  _EvaluationAttemptsProviderElement(super.provider);

  @override
  String get answerId => (origin as EvaluationAttemptsProvider).answerId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
