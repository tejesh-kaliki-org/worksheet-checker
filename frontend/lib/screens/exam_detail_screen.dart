import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_api_client/export.dart';

import 'package:worksheet_checker/api/rest_client_provider.dart';

part 'exam_detail_screen.g.dart';

@riverpod
Future<List<ExamSubject>> examExamSubjects(Ref ref, String examId) async {
  final result =
      await ref.watch(examsClientProvider).listExamSubjects(examId: examId);
  return result.examSubjects;
}

@riverpod
Future<List<Subject>> examAllSubjects(Ref ref) async {
  final result = await ref.watch(subjectsClientProvider).listSubjects();
  return result.subjects;
}

/// Bare-functional Exam detail: attach Subjects to the Exam. Each attached
/// Subject (Exam Subject) links to its own Question catalogue screen.
class ExamDetailScreen extends ConsumerWidget {
  const ExamDetailScreen({required this.examId, super.key});

  final String examId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examSubjectsAsync = ref.watch(examExamSubjectsProvider(examId));
    final allSubjectsAsync = ref.watch(examAllSubjectsProvider);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                'Exam Subjects',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              switch ((allSubjectsAsync, examSubjectsAsync)) {
                (
                  AsyncData(value: final all),
                  AsyncData(value: final attached)
                ) =>
                  _SubjectAttacher(
                    examId: examId,
                    allSubjects: all,
                    attached: attached,
                  ),
                (AsyncError(:final error), _) ||
                (_, AsyncError(:final error)) =>
                  Text('Error: $error'),
                _ => const CircularProgressIndicator(),
              },
            ],
          ),
        ),
      ),
    );
  }
}

class _SubjectAttacher extends ConsumerWidget {
  const _SubjectAttacher({
    required this.examId,
    required this.allSubjects,
    required this.attached,
  });

  final String examId;
  final List<Subject> allSubjects;
  final List<ExamSubject> attached;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectById = {for (final s in allSubjects) s.id: s};
    return Column(
      children: [
        for (final es in attached)
          ListTile(
            title: Text(subjectById[es.subjectId]?.name ?? es.subjectId),
            subtitle: const Text('Tap to manage its Questions'),
            onTap: () => context.push('/exam-subjects/${es.id}'),
          ),
        const Divider(),
        DropdownButton<String>(
          hint: const Text('Attach a Subject'),
          items: [
            for (final s in allSubjects)
              DropdownMenuItem(value: s.id, child: Text(s.name)),
          ],
          onChanged: (subjectId) async {
            if (subjectId == null) return;
            await ref.read(examsClientProvider).addExamSubject(
                  examId: examId,
                  body: AddExamSubjectRequest(subjectId: subjectId),
                );
            ref.invalidate(examExamSubjectsProvider(examId));
          },
        ),
      ],
    );
  }
}
