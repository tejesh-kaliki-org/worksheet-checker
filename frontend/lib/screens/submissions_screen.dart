import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_api_client/export.dart';

import 'package:worksheet_checker/api/rest_client_provider.dart';

part 'submissions_screen.g.dart';

@riverpod
Future<List<Student>> submissionsClassStudents(
  Ref ref,
  String classId,
) async {
  final result =
      await ref.watch(studentsClientProvider).listStudents(classId: classId);
  return result.students;
}

@riverpod
Future<List<Question>> submissionsExamSubjectQuestions(
  Ref ref,
  String examSubjectId,
) async {
  final result = await ref
      .watch(questionsClientProvider)
      .listQuestions(examSubjectId: examSubjectId);
  return result.questions;
}

/// Bare-functional bulk upload screen: pick the Exam Subject (fixed by
/// route), enter each Student's raw answer for each Question in a simple
/// table, submit in one call. No CSV import / drag-drop, per the issue #6
/// scope -- just enough to exercise the flow manually.
class SubmissionsScreen extends ConsumerStatefulWidget {
  const SubmissionsScreen({
    required this.examSubjectId,
    required this.classId,
    super.key,
  });

  final String examSubjectId;
  final String classId;

  @override
  ConsumerState<SubmissionsScreen> createState() => _SubmissionsScreenState();
}

class _SubmissionsScreenState extends ConsumerState<SubmissionsScreen> {
  final Map<String, Map<String, TextEditingController>> _controllers = {};
  bool _submitting = false;
  String? _message;

  TextEditingController _controllerFor(String studentId, String questionId) {
    final byQuestion = _controllers.putIfAbsent(studentId, () => {});
    return byQuestion.putIfAbsent(questionId, TextEditingController.new);
  }

  Future<void> _submit(List<Student> students, List<Question> questions) async {
    setState(() {
      _submitting = true;
      _message = null;
    });
    try {
      final submissions = <StudentAnswersInput>[
        for (final s in students)
          StudentAnswersInput(
            studentId: s.id,
            answers: [
              for (final q in questions)
                AnswerInput(
                  questionId: q.id,
                  rawAnswer: _controllerFor(s.id, q.id).text,
                ),
            ],
          ),
      ];
      await ref.read(submissionsClientProvider).bulkUploadSubmissions(
            examSubjectId: widget.examSubjectId,
            body: BulkUploadSubmissionsRequest(submissions: submissions),
          );
      setState(() => _message = 'Uploaded.');
    } on Exception catch (e) {
      setState(() => _message = 'Error: $e');
    } finally {
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentsAsync =
        ref.watch(submissionsClassStudentsProvider(widget.classId));
    final questionsAsync = ref
        .watch(submissionsExamSubjectQuestionsProvider(widget.examSubjectId));

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                'Bulk Upload Submissions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              switch ((studentsAsync, questionsAsync)) {
                (
                  AsyncData(value: final students),
                  AsyncData(value: final questions)
                ) =>
                  students.isEmpty || questions.isEmpty
                      ? const Text(
                          'Need at least one Student and one Question.',
                        )
                      : _Table(
                          students: students,
                          questions: questions,
                          controllerFor: _controllerFor,
                        ),
                (AsyncError(:final error), _) ||
                (_, AsyncError(:final error)) =>
                  Text('Error: $error'),
                _ => const CircularProgressIndicator(),
              },
              const SizedBox(height: 16),
              if (_message != null) Text(_message!),
              FilledButton(
                onPressed: _submitting
                    ? null
                    : () {
                        final students = studentsAsync.value;
                        final questions = questionsAsync.value;
                        if (students == null || questions == null) return;
                        unawaited(_submit(students, questions));
                      },
                child: Text(_submitting ? 'Uploading...' : 'Submit'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _Table extends StatelessWidget {
  const _Table({
    required this.students,
    required this.questions,
    required this.controllerFor,
  });

  final List<Student> students;
  final List<Question> questions;
  final TextEditingController Function(String studentId, String questionId)
      controllerFor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          const DataColumn(label: Text('Student')),
          for (final q in questions)
            DataColumn(label: Text('${q.type.name} (${q.maximumMarks})')),
        ],
        rows: [
          for (final s in students)
            DataRow(
              cells: [
                DataCell(Text('${s.name} (${s.rollNumber})')),
                for (final q in questions)
                  DataCell(
                    SizedBox(
                      width: 140,
                      child: TextField(
                        controller: controllerFor(s.id, q.id),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
