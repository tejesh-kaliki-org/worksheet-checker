// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/add_class_subject_request.dart';
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

  /// Select a Subject for a Class
  @POST('/classes/{classId}/subjects')
  Future<SubjectList> addClassSubject({
    @Path('classId') required String classId,
    @Body() required AddClassSubjectRequest body,
    @DioOptions() RequestOptions? options,
  });

  /// Remove a Subject selection from a Class
  @DELETE('/classes/{classId}/subjects/{subjectId}')
  Future<void> removeClassSubject({
    @Path('classId') required String classId,
    @Path('subjectId') required String subjectId,
    @DioOptions() RequestOptions? options,
  });
}
