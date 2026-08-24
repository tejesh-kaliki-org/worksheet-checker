// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/bulk_select_class_subjects_request.dart';
import '../models/class.dart';
import '../models/class_list.dart';
import '../models/create_class_request.dart';
import '../models/subject_list.dart';
import '../models/update_class_request.dart';

part 'classes_client.g.dart';

@RestApi()
abstract class ClassesClient {
  factory ClassesClient(Dio dio, {String? baseUrl}) = _ClassesClient;

  /// List Classes owned by the authenticated user
  @GET('/classes')
  Future<ClassList> listClasses({
    @DioOptions() RequestOptions? options,
  });

  /// Create a Class owned by the authenticated user
  @POST('/classes')
  Future<Class> createClass({
    @Body() required CreateClassRequest body,
    @DioOptions() RequestOptions? options,
  });

  /// Get a Class owned by the authenticated user
  @GET('/classes/{classId}')
  Future<Class> getClass({
    @Path('classId') required String classId,
    @DioOptions() RequestOptions? options,
  });

  /// Update a Class owned by the authenticated user
  @PUT('/classes/{classId}')
  Future<Class> updateClass({
    @Path('classId') required String classId,
    @Body() required UpdateClassRequest body,
    @DioOptions() RequestOptions? options,
  });

  /// Delete a Class owned by the authenticated user
  @DELETE('/classes/{classId}')
  Future<void> deleteClass({
    @Path('classId') required String classId,
    @DioOptions() RequestOptions? options,
  });

  /// List Subjects selected for a Class
  @GET('/classes/{classId}/subjects')
  Future<SubjectList> listClassSubjects({
    @Path('classId') required String classId,
    @DioOptions() RequestOptions? options,
  });

  /// Select Subjects for a Class.
  ///
  /// The primary path for choosing a Class's Subjects: submit the whole selection at once. Additive and idempotent — Subjects already selected are left alone, never duplicated or errored on. Deselecting is done with DELETE /classes/{classId}/subjects/{subjectId}. Every id must name a Subject in the caller's own catalogue; otherwise the whole request 404s and nothing is selected.
  @POST('/classes/{classId}/subjects:bulk-select')
  Future<SubjectList> bulkSelectClassSubjects({
    @Path('classId') required String classId,
    @Body() required BulkSelectClassSubjectsRequest body,
    @DioOptions() RequestOptions? options,
  });

  /// Remove a Subject selection from a Class.
  ///
  /// Never cascades. Once downstream Exam Subject / Question / Answer data exists, removing a selection that has such data underneath will return 409; no such table exists yet, so today the operation cannot conflict and 409 is deliberately not declared here.
  @DELETE('/classes/{classId}/subjects/{subjectId}')
  Future<void> removeClassSubject({
    @Path('classId') required String classId,
    @Path('subjectId') required String subjectId,
    @DioOptions() RequestOptions? options,
  });
}
