// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_detail_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$examExamSubjectsHash() => r'731448bdaa44e56737e7d421ea64617bde9b46cd';

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

/// See also [examExamSubjects].
@ProviderFor(examExamSubjects)
const examExamSubjectsProvider = ExamExamSubjectsFamily();

/// See also [examExamSubjects].
class ExamExamSubjectsFamily extends Family<AsyncValue<List<ExamSubject>>> {
  /// See also [examExamSubjects].
  const ExamExamSubjectsFamily();

  /// See also [examExamSubjects].
  ExamExamSubjectsProvider call(
    String examId,
  ) {
    return ExamExamSubjectsProvider(
      examId,
    );
  }

  @override
  ExamExamSubjectsProvider getProviderOverride(
    covariant ExamExamSubjectsProvider provider,
  ) {
    return call(
      provider.examId,
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
  String? get name => r'examExamSubjectsProvider';
}

/// See also [examExamSubjects].
class ExamExamSubjectsProvider
    extends AutoDisposeFutureProvider<List<ExamSubject>> {
  /// See also [examExamSubjects].
  ExamExamSubjectsProvider(
    String examId,
  ) : this._internal(
          (ref) => examExamSubjects(
            ref as ExamExamSubjectsRef,
            examId,
          ),
          from: examExamSubjectsProvider,
          name: r'examExamSubjectsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$examExamSubjectsHash,
          dependencies: ExamExamSubjectsFamily._dependencies,
          allTransitiveDependencies:
              ExamExamSubjectsFamily._allTransitiveDependencies,
          examId: examId,
        );

  ExamExamSubjectsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.examId,
  }) : super.internal();

  final String examId;

  @override
  Override overrideWith(
    FutureOr<List<ExamSubject>> Function(ExamExamSubjectsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExamExamSubjectsProvider._internal(
        (ref) => create(ref as ExamExamSubjectsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        examId: examId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ExamSubject>> createElement() {
    return _ExamExamSubjectsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExamExamSubjectsProvider && other.examId == examId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, examId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ExamExamSubjectsRef on AutoDisposeFutureProviderRef<List<ExamSubject>> {
  /// The parameter `examId` of this provider.
  String get examId;
}

class _ExamExamSubjectsProviderElement
    extends AutoDisposeFutureProviderElement<List<ExamSubject>>
    with ExamExamSubjectsRef {
  _ExamExamSubjectsProviderElement(super.provider);

  @override
  String get examId => (origin as ExamExamSubjectsProvider).examId;
}

String _$examAllSubjectsHash() => r'45cfb450ffbc27ca0ab252f9c65cd3e84480be09';

/// See also [examAllSubjects].
@ProviderFor(examAllSubjects)
final examAllSubjectsProvider =
    AutoDisposeFutureProvider<List<Subject>>.internal(
  examAllSubjects,
  name: r'examAllSubjectsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$examAllSubjectsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExamAllSubjectsRef = AutoDisposeFutureProviderRef<List<Subject>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
