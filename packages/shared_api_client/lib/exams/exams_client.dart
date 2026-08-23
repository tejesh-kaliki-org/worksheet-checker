// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/add_exam_subject_request.dart';
import '../models/create_exam_request.dart';
import '../models/exam.dart';
import '../models/exam_list.dart';
import '../models/exam_subject.dart';
import '../models/exam_subject_list.dart';

part 'exams_client.g.dart';

@RestApi()
abstract class ExamsClient {
  factory ExamsClient(Dio dio, {String? baseUrl}) = _ExamsClient;

  /// List Exams for a Class
  @GET('/classes/{classId}/exams')
  Future<ExamList> listExams({
    @Path('classId') required String classId,
    @DioOptions() RequestOptions? options,
  });

  /// Create an Exam for a Class
  @POST('/classes/{classId}/exams')
  Future<Exam> createExam({
    @Path('classId') required String classId,
    @Body() required CreateExamRequest body,
    @DioOptions() RequestOptions? options,
  });

  /// Get an Exam in a Class
  @GET('/classes/{classId}/exams/{examId}')
  Future<Exam> getExam({
    @Path('classId') required String classId,
    @Path('examId') required String examId,
    @DioOptions() RequestOptions? options,
  });

  /// List Exam Subjects attached to an Exam
  @GET('/exams/{examId}/subjects')
  Future<ExamSubjectList> listExamSubjects({
    @Path('examId') required String examId,
    @DioOptions() RequestOptions? options,
  });

  /// Attach a Subject to an Exam (creates its Exam Subject)
  @POST('/exams/{examId}/subjects')
  Future<ExamSubject> addExamSubject({
    @Path('examId') required String examId,
    @Body() required AddExamSubjectRequest body,
    @DioOptions() RequestOptions? options,
  });
}
