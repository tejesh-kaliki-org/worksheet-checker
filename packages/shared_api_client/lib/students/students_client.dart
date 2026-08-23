// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/create_student_request.dart';
import '../models/student.dart';
import '../models/student_list.dart';
import '../models/update_student_request.dart';

part 'students_client.g.dart';

@RestApi()
abstract class StudentsClient {
  factory StudentsClient(Dio dio, {String? baseUrl}) = _StudentsClient;

  /// List Students in a Class
  @GET('/classes/{classId}/students')
  Future<StudentList> listStudents({
    @Path('classId') required String classId,
    @DioOptions() RequestOptions? options,
  });

  /// Add a Student to a Class
  @POST('/classes/{classId}/students')
  Future<Student> createStudent({
    @Path('classId') required String classId,
    @Body() required CreateStudentRequest body,
    @DioOptions() RequestOptions? options,
  });

  /// Get a Student in a Class
  @GET('/classes/{classId}/students/{studentId}')
  Future<Student> getStudent({
    @Path('classId') required String classId,
    @Path('studentId') required String studentId,
    @DioOptions() RequestOptions? options,
  });

  /// Update a Student in a Class
  @PUT('/classes/{classId}/students/{studentId}')
  Future<Student> updateStudent({
    @Path('classId') required String classId,
    @Path('studentId') required String studentId,
    @Body() required UpdateStudentRequest body,
    @DioOptions() RequestOptions? options,
  });

  /// Remove a Student from a Class
  @DELETE('/classes/{classId}/students/{studentId}')
  Future<void> deleteStudent({
    @Path('classId') required String classId,
    @Path('studentId') required String studentId,
    @DioOptions() RequestOptions? options,
  });
}
