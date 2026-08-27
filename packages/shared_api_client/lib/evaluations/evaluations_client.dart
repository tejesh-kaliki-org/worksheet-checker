// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/create_evaluation_attempt_request.dart';
import '../models/evaluation_attempt.dart';
import '../models/evaluation_attempt_list.dart';

part 'evaluations_client.g.dart';

@RestApi()
abstract class EvaluationsClient {
  factory EvaluationsClient(Dio dio, {String? baseUrl}) = _EvaluationsClient;

  /// Trigger an Evaluation Attempt for an Answer -- one try at having the AI grade it (see CONTEXT.md — Evaluation Attempt). Defaults to `scoring` Purpose; pass `experiment` for offline comparison runs that never affect Effective Marks or Feedback. Runs synchronously for this issue's scope: the response reflects the Attempt's terminal status (`succeeded` or `failed`).
  @POST('/answers/{answerId}/evaluation-attempts')
  Future<EvaluationAttempt> createEvaluationAttempt({
    @Path('answerId') required String answerId,
    @Body() CreateEvaluationAttemptRequest? body,
    @DioOptions() RequestOptions? options,
  });

  /// List Evaluation Attempts for an Answer, most recent first
  @GET('/answers/{answerId}/evaluation-attempts')
  Future<EvaluationAttemptList> listEvaluationAttempts({
    @Path('answerId') required String answerId,
    @DioOptions() RequestOptions? options,
  });

  /// Poll/read a single Evaluation Attempt, including its Evaluation (score, marks, feedback) if it succeeded.
  @GET('/answers/{answerId}/evaluation-attempts/{attemptId}')
  Future<EvaluationAttempt> getEvaluationAttempt({
    @Path('answerId') required String answerId,
    @Path('attemptId') required String attemptId,
    @DioOptions() RequestOptions? options,
  });
}
