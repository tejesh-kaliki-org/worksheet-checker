// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_detail_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$classStudentsHash() => r'15d822c974113121bd01c468b721e64c3a3f05a6';

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

/// See also [classStudents].
@ProviderFor(classStudents)
const classStudentsProvider = ClassStudentsFamily();

/// See also [classStudents].
class ClassStudentsFamily extends Family<AsyncValue<List<Student>>> {
  /// See also [classStudents].
  const ClassStudentsFamily();

  /// See also [classStudents].
  ClassStudentsProvider call(
    String classId,
  ) {
    return ClassStudentsProvider(
      classId,
    );
  }

  @override
  ClassStudentsProvider getProviderOverride(
    covariant ClassStudentsProvider provider,
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
  String? get name => r'classStudentsProvider';
}

/// See also [classStudents].
class ClassStudentsProvider extends AutoDisposeFutureProvider<List<Student>> {
  /// See also [classStudents].
  ClassStudentsProvider(
    String classId,
  ) : this._internal(
          (ref) => classStudents(
            ref as ClassStudentsRef,
            classId,
          ),
          from: classStudentsProvider,
          name: r'classStudentsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$classStudentsHash,
          dependencies: ClassStudentsFamily._dependencies,
          allTransitiveDependencies:
              ClassStudentsFamily._allTransitiveDependencies,
          classId: classId,
        );

  ClassStudentsProvider._internal(
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
    FutureOr<List<Student>> Function(ClassStudentsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClassStudentsProvider._internal(
        (ref) => create(ref as ClassStudentsRef),
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
    return _ClassStudentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClassStudentsProvider && other.classId == classId;
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
mixin ClassStudentsRef on AutoDisposeFutureProviderRef<List<Student>> {
  /// The parameter `classId` of this provider.
  String get classId;
}

class _ClassStudentsProviderElement
    extends AutoDisposeFutureProviderElement<List<Student>>
    with ClassStudentsRef {
  _ClassStudentsProviderElement(super.provider);

  @override
  String get classId => (origin as ClassStudentsProvider).classId;
}

String _$classSubjectsHash() => r'db5b4d9178437604178f652d3ff7496155fd3b56';

/// See also [classSubjects].
@ProviderFor(classSubjects)
const classSubjectsProvider = ClassSubjectsFamily();

/// See also [classSubjects].
class ClassSubjectsFamily extends Family<AsyncValue<List<Subject>>> {
  /// See also [classSubjects].
  const ClassSubjectsFamily();

  /// See also [classSubjects].
  ClassSubjectsProvider call(
    String classId,
  ) {
    return ClassSubjectsProvider(
      classId,
    );
  }

  @override
  ClassSubjectsProvider getProviderOverride(
    covariant ClassSubjectsProvider provider,
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
  String? get name => r'classSubjectsProvider';
}

/// See also [classSubjects].
class ClassSubjectsProvider extends AutoDisposeFutureProvider<List<Subject>> {
  /// See also [classSubjects].
  ClassSubjectsProvider(
    String classId,
  ) : this._internal(
          (ref) => classSubjects(
            ref as ClassSubjectsRef,
            classId,
          ),
          from: classSubjectsProvider,
          name: r'classSubjectsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$classSubjectsHash,
          dependencies: ClassSubjectsFamily._dependencies,
          allTransitiveDependencies:
              ClassSubjectsFamily._allTransitiveDependencies,
          classId: classId,
        );

  ClassSubjectsProvider._internal(
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
    FutureOr<List<Subject>> Function(ClassSubjectsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClassSubjectsProvider._internal(
        (ref) => create(ref as ClassSubjectsRef),
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
  AutoDisposeFutureProviderElement<List<Subject>> createElement() {
    return _ClassSubjectsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClassSubjectsProvider && other.classId == classId;
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
mixin ClassSubjectsRef on AutoDisposeFutureProviderRef<List<Subject>> {
  /// The parameter `classId` of this provider.
  String get classId;
}

class _ClassSubjectsProviderElement
    extends AutoDisposeFutureProviderElement<List<Subject>>
    with ClassSubjectsRef {
  _ClassSubjectsProviderElement(super.provider);

  @override
  String get classId => (origin as ClassSubjectsProvider).classId;
}

String _$allSubjectsHash() => r'66460417f577a214b5e467555901a709ffbf28f9';

/// See also [allSubjects].
@ProviderFor(allSubjects)
final allSubjectsProvider = AutoDisposeFutureProvider<List<Subject>>.internal(
  allSubjects,
  name: r'allSubjectsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allSubjectsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllSubjectsRef = AutoDisposeFutureProviderRef<List<Subject>>;
String _$classExamsHash() => r'54eeaa1592f98b802ae2575d8eb3e464e83055c6';

/// See also [classExams].
@ProviderFor(classExams)
const classExamsProvider = ClassExamsFamily();

/// See also [classExams].
class ClassExamsFamily extends Family<AsyncValue<List<Exam>>> {
  /// See also [classExams].
  const ClassExamsFamily();

  /// See also [classExams].
  ClassExamsProvider call(
    String classId,
  ) {
    return ClassExamsProvider(
      classId,
    );
  }

  @override
  ClassExamsProvider getProviderOverride(
    covariant ClassExamsProvider provider,
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
  String? get name => r'classExamsProvider';
}

/// See also [classExams].
class ClassExamsProvider extends AutoDisposeFutureProvider<List<Exam>> {
  /// See also [classExams].
  ClassExamsProvider(
    String classId,
  ) : this._internal(
          (ref) => classExams(
            ref as ClassExamsRef,
            classId,
          ),
          from: classExamsProvider,
          name: r'classExamsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$classExamsHash,
          dependencies: ClassExamsFamily._dependencies,
          allTransitiveDependencies:
              ClassExamsFamily._allTransitiveDependencies,
          classId: classId,
        );

  ClassExamsProvider._internal(
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
    FutureOr<List<Exam>> Function(ClassExamsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClassExamsProvider._internal(
        (ref) => create(ref as ClassExamsRef),
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
  AutoDisposeFutureProviderElement<List<Exam>> createElement() {
    return _ClassExamsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClassExamsProvider && other.classId == classId;
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
mixin ClassExamsRef on AutoDisposeFutureProviderRef<List<Exam>> {
  /// The parameter `classId` of this provider.
  String get classId;
}

class _ClassExamsProviderElement
    extends AutoDisposeFutureProviderElement<List<Exam>> with ClassExamsRef {
  _ClassExamsProviderElement(super.provider);

  @override
  String get classId => (origin as ClassExamsProvider).classId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
