// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/create_question_request.dart';
import '../models/question.dart';
import '../models/question_list.dart';
import '../models/update_question_request.dart';

part 'questions_client.g.dart';

@RestApi()
abstract class QuestionsClient {
  factory QuestionsClient(Dio dio, {String? baseUrl}) = _QuestionsClient;

  /// List Questions in an Exam Subject's catalogue
  @GET('/exam-subjects/{examSubjectId}/questions')
  Future<QuestionList> listQuestions({
    @Path('examSubjectId') required String examSubjectId,
    @DioOptions() RequestOptions? options,
  });

  /// Author a Question in an Exam Subject's catalogue
  @POST('/exam-subjects/{examSubjectId}/questions')
  Future<Question> createQuestion({
    @Path('examSubjectId') required String examSubjectId,
    @Body() required CreateQuestionRequest body,
    @DioOptions() RequestOptions? options,
  });

  /// Get a Question in an Exam Subject's catalogue
  @GET('/exam-subjects/{examSubjectId}/questions/{questionId}')
  Future<Question> getQuestion({
    @Path('examSubjectId') required String examSubjectId,
    @Path('questionId') required String questionId,
    @DioOptions() RequestOptions? options,
  });

  /// Update a Question in an Exam Subject's catalogue
  @PUT('/exam-subjects/{examSubjectId}/questions/{questionId}')
  Future<Question> updateQuestion({
    @Path('examSubjectId') required String examSubjectId,
    @Path('questionId') required String questionId,
    @Body() required UpdateQuestionRequest body,
    @DioOptions() RequestOptions? options,
  });

  /// Remove a Question from an Exam Subject's catalogue
  @DELETE('/exam-subjects/{examSubjectId}/questions/{questionId}')
  Future<void> deleteQuestion({
    @Path('examSubjectId') required String examSubjectId,
    @Path('questionId') required String questionId,
    @DioOptions() RequestOptions? options,
  });
}
