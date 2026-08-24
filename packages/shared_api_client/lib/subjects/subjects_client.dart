// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/bulk_create_subjects_request.dart';
import '../models/create_subject_request.dart';
import '../models/subject.dart';
import '../models/subject_list.dart';
import '../models/update_subject_request.dart';

part 'subjects_client.g.dart';

@RestApi()
abstract class SubjectsClient {
  factory SubjectsClient(Dio dio, {String? baseUrl}) = _SubjectsClient;

  /// List the authenticated User's Subject catalogue
  @GET('/subjects')
  Future<SubjectList> listSubjects({
    @DioOptions() RequestOptions? options,
  });

  /// Add a Subject to the authenticated User's catalogue
  @POST('/subjects')
  Future<Subject> createSubject({
    @Body() required CreateSubjectRequest body,
    @DioOptions() RequestOptions? options,
  });

  /// Add several Subjects to the authenticated User's catalogue.
  ///
  /// Idempotent by name: names the User already has are skipped rather than rejected, so re-submitting the same list never errors. The response is the User's full catalogue after the operation.
  @POST('/subjects:bulk-create')
  Future<SubjectList> bulkCreateSubjects({
    @Body() required BulkCreateSubjectsRequest body,
    @DioOptions() RequestOptions? options,
  });

  /// Rename a Subject in the authenticated User's catalogue
  @PUT('/subjects/{subjectId}')
  Future<Subject> updateSubject({
    @Path('subjectId') required String subjectId,
    @Body() required UpdateSubjectRequest body,
    @DioOptions() RequestOptions? options,
  });

  /// Remove a Subject from the authenticated User's catalogue.
  ///
  /// Never cascades. A Subject still selected by any Class (or referenced by downstream Exam Subject / Question / Answer data) returns 409; remove those references first.
  @DELETE('/subjects/{subjectId}')
  Future<void> deleteSubject({
    @Path('subjectId') required String subjectId,
    @DioOptions() RequestOptions? options,
  });
}
