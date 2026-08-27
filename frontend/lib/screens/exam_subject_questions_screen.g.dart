// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_subject_questions_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$examSubjectQuestionsHash() =>
    r'69dfc1a60d33f2c25b6c71021562c8f118708727';

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

/// See also [examSubjectQuestions].
@ProviderFor(examSubjectQuestions)
const examSubjectQuestionsProvider = ExamSubjectQuestionsFamily();

/// See also [examSubjectQuestions].
class ExamSubjectQuestionsFamily extends Family<AsyncValue<List<Question>>> {
  /// See also [examSubjectQuestions].
  const ExamSubjectQuestionsFamily();

  /// See also [examSubjectQuestions].
  ExamSubjectQuestionsProvider call(
    String examSubjectId,
  ) {
    return ExamSubjectQuestionsProvider(
      examSubjectId,
    );
  }

  @override
  ExamSubjectQuestionsProvider getProviderOverride(
    covariant ExamSubjectQuestionsProvider provider,
  ) {
    return call(
      provider.examSubjectId,
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
  String? get name => r'examSubjectQuestionsProvider';
}

/// See also [examSubjectQuestions].
class ExamSubjectQuestionsProvider
    extends AutoDisposeFutureProvider<List<Question>> {
  /// See also [examSubjectQuestions].
  ExamSubjectQuestionsProvider(
    String examSubjectId,
  ) : this._internal(
          (ref) => examSubjectQuestions(
            ref as ExamSubjectQuestionsRef,
            examSubjectId,
          ),
          from: examSubjectQuestionsProvider,
          name: r'examSubjectQuestionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$examSubjectQuestionsHash,
          dependencies: ExamSubjectQuestionsFamily._dependencies,
          allTransitiveDependencies:
              ExamSubjectQuestionsFamily._allTransitiveDependencies,
          examSubjectId: examSubjectId,
        );

  ExamSubjectQuestionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.examSubjectId,
  }) : super.internal();

  final String examSubjectId;

  @override
  Override overrideWith(
    FutureOr<List<Question>> Function(ExamSubjectQuestionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExamSubjectQuestionsProvider._internal(
        (ref) => create(ref as ExamSubjectQuestionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        examSubjectId: examSubjectId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Question>> createElement() {
    return _ExamSubjectQuestionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExamSubjectQuestionsProvider &&
        other.examSubjectId == examSubjectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, examSubjectId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ExamSubjectQuestionsRef on AutoDisposeFutureProviderRef<List<Question>> {
  /// The parameter `examSubjectId` of this provider.
  String get examSubjectId;
}

class _ExamSubjectQuestionsProviderElement
    extends AutoDisposeFutureProviderElement<List<Question>>
    with ExamSubjectQuestionsRef {
  _ExamSubjectQuestionsProviderElement(super.provider);

  @override
  String get examSubjectId =>
      (origin as ExamSubjectQuestionsProvider).examSubjectId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
