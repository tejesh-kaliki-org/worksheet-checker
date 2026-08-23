// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submissions_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$submissionsClassStudentsHash() =>
    r'cc4467d8bb306ea6fdf5bb7251770284961b383e';

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

/// See also [submissionsClassStudents].
@ProviderFor(submissionsClassStudents)
const submissionsClassStudentsProvider = SubmissionsClassStudentsFamily();

/// See also [submissionsClassStudents].
class SubmissionsClassStudentsFamily extends Family<AsyncValue<List<Student>>> {
  /// See also [submissionsClassStudents].
  const SubmissionsClassStudentsFamily();

  /// See also [submissionsClassStudents].
  SubmissionsClassStudentsProvider call(
    String classId,
  ) {
    return SubmissionsClassStudentsProvider(
      classId,
    );
  }

  @override
  SubmissionsClassStudentsProvider getProviderOverride(
    covariant SubmissionsClassStudentsProvider provider,
  ) {
    return call(
      provider.classId,
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
  String? get name => r'submissionsClassStudentsProvider';
}

/// See also [submissionsClassStudents].
class SubmissionsClassStudentsProvider
    extends AutoDisposeFutureProvider<List<Student>> {
  /// See also [submissionsClassStudents].
  SubmissionsClassStudentsProvider(
    String classId,
  ) : this._internal(
          (ref) => submissionsClassStudents(
            ref as SubmissionsClassStudentsRef,
            classId,
          ),
          from: submissionsClassStudentsProvider,
          name: r'submissionsClassStudentsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$submissionsClassStudentsHash,
          dependencies: SubmissionsClassStudentsFamily._dependencies,
          allTransitiveDependencies:
              SubmissionsClassStudentsFamily._allTransitiveDependencies,
          classId: classId,
        );

  SubmissionsClassStudentsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.classId,
  }) : super.internal();

  final String classId;

  @override
  Override overrideWith(
    FutureOr<List<Student>> Function(SubmissionsClassStudentsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubmissionsClassStudentsProvider._internal(
        (ref) => create(ref as SubmissionsClassStudentsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        classId: classId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Student>> createElement() {
    return _SubmissionsClassStudentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubmissionsClassStudentsProvider &&
        other.classId == classId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, classId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SubmissionsClassStudentsRef
    on AutoDisposeFutureProviderRef<List<Student>> {
  /// The parameter `classId` of this provider.
  String get classId;
}

class _SubmissionsClassStudentsProviderElement
    extends AutoDisposeFutureProviderElement<List<Student>>
    with SubmissionsClassStudentsRef {
  _SubmissionsClassStudentsProviderElement(super.provider);

  @override
  String get classId => (origin as SubmissionsClassStudentsProvider).classId;
}

String _$submissionsExamSubjectQuestionsHash() =>
    r'1f4c431d930e81bbf39c087b3e5c4d6e01ec4de0';

/// See also [submissionsExamSubjectQuestions].
@ProviderFor(submissionsExamSubjectQuestions)
const submissionsExamSubjectQuestionsProvider =
    SubmissionsExamSubjectQuestionsFamily();

/// See also [submissionsExamSubjectQuestions].
class SubmissionsExamSubjectQuestionsFamily
    extends Family<AsyncValue<List<Question>>> {
  /// See also [submissionsExamSubjectQuestions].
  const SubmissionsExamSubjectQuestionsFamily();

  /// See also [submissionsExamSubjectQuestions].
  SubmissionsExamSubjectQuestionsProvider call(
    String examSubjectId,
  ) {
    return SubmissionsExamSubjectQuestionsProvider(
      examSubjectId,
    );
  }

  @override
  SubmissionsExamSubjectQuestionsProvider getProviderOverride(
    covariant SubmissionsExamSubjectQuestionsProvider provider,
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
  String? get name => r'submissionsExamSubjectQuestionsProvider';
}

/// See also [submissionsExamSubjectQuestions].
class SubmissionsExamSubjectQuestionsProvider
    extends AutoDisposeFutureProvider<List<Question>> {
  /// See also [submissionsExamSubjectQuestions].
  SubmissionsExamSubjectQuestionsProvider(
    String examSubjectId,
  ) : this._internal(
          (ref) => submissionsExamSubjectQuestions(
            ref as SubmissionsExamSubjectQuestionsRef,
            examSubjectId,
          ),
          from: submissionsExamSubjectQuestionsProvider,
          name: r'submissionsExamSubjectQuestionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$submissionsExamSubjectQuestionsHash,
          dependencies: SubmissionsExamSubjectQuestionsFamily._dependencies,
          allTransitiveDependencies:
              SubmissionsExamSubjectQuestionsFamily._allTransitiveDependencies,
          examSubjectId: examSubjectId,
        );

  SubmissionsExamSubjectQuestionsProvider._internal(
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
    FutureOr<List<Question>> Function(
            SubmissionsExamSubjectQuestionsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubmissionsExamSubjectQuestionsProvider._internal(
        (ref) => create(ref as SubmissionsExamSubjectQuestionsRef),
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
    return _SubmissionsExamSubjectQuestionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubmissionsExamSubjectQuestionsProvider &&
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
mixin SubmissionsExamSubjectQuestionsRef
    on AutoDisposeFutureProviderRef<List<Question>> {
  /// The parameter `examSubjectId` of this provider.
  String get examSubjectId;
}

class _SubmissionsExamSubjectQuestionsProviderElement
    extends AutoDisposeFutureProviderElement<List<Question>>
    with SubmissionsExamSubjectQuestionsRef {
  _SubmissionsExamSubjectQuestionsProviderElement(super.provider);

  @override
  String get examSubjectId =>
      (origin as SubmissionsExamSubjectQuestionsProvider).examSubjectId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
