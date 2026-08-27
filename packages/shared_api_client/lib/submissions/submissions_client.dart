// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/answer.dart';
import '../models/answer_list.dart';
import '../models/bulk_upload_submissions_request.dart';
import '../models/submission_list.dart';
import '../models/update_answer_request.dart';

part 'submissions_client.g.dart';

@RestApi()
abstract class SubmissionsClient {
  factory SubmissionsClient(Dio dio, {String? baseUrl}) = _SubmissionsClient;

  /// Upload all Students' Answers for all Questions in an Exam Subject in one call. Teacher-driven, not student self-serve (see CONTEXT.md — Submission). Re-uploading is idempotent: an existing Submission for the same Student is reused, and an existing Answer for the same Question is overwritten.
  @POST('/exam-subjects/{examSubjectId}/submissions:bulk-upload')
  Future<SubmissionList> bulkUploadSubmissions({
    @Path('examSubjectId') required String examSubjectId,
    @Body() required BulkUploadSubmissionsRequest body,
    @DioOptions() RequestOptions? options,
  });

  /// List Submissions for an Exam Subject
  @GET('/exam-subjects/{examSubjectId}/submissions')
  Future<SubmissionList> listSubmissions({
    @Path('examSubjectId') required String examSubjectId,
    @DioOptions() RequestOptions? options,
  });

  /// List Answers belonging to a Submission
  @GET('/submissions/{submissionId}/answers')
  Future<AnswerList> listAnswers({
    @Path('submissionId') required String submissionId,
    @DioOptions() RequestOptions? options,
  });

  /// Get a single Answer
  @GET('/submissions/{submissionId}/answers/{answerId}')
  Future<Answer> getAnswer({
    @Path('submissionId') required String submissionId,
    @Path('answerId') required String answerId,
    @DioOptions() RequestOptions? options,
  });

  /// Edit an Answer -- a teacher correcting a mis-entered Answer after bulk upload.
  @PUT('/submissions/{submissionId}/answers/{answerId}')
  Future<Answer> updateAnswer({
    @Path('submissionId') required String submissionId,
    @Path('answerId') required String answerId,
    @Body() required UpdateAnswerRequest body,
    @DioOptions() RequestOptions? options,
  });
}
