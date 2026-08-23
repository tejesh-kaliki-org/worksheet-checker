// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/subject_list.dart';

part 'subjects_client.g.dart';

@RestApi()
abstract class SubjectsClient {
  factory SubjectsClient(Dio dio, {String? baseUrl}) = _SubjectsClient;

  /// List the global Subject catalogue
  @GET('/subjects')
  Future<SubjectList> listSubjects({
    @DioOptions() RequestOptions? options,
  });
}
