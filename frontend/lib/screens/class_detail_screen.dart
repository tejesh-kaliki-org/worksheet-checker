import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_api_client/export.dart';

import 'package:worksheet_checker/api/rest_client_provider.dart';

part 'class_detail_screen.g.dart';

@riverpod
Future<List<Student>> classStudents(Ref ref, String classId) async {
  final result =
      await ref.watch(studentsClientProvider).listStudents(classId: classId);
  return result.students;
}

@riverpod
Future<List<Subject>> classSubjects(Ref ref, String classId) async {
  final result = await ref
      .watch(classesClientProvider)
      .listClassSubjects(classId: classId);
  return result.subjects;
}

@riverpod
Future<List<Subject>> allSubjects(Ref ref) async {
  final result = await ref.watch(subjectsClientProvider).listSubjects();
  return result.subjects;
}

/// Bare-functional Class detail: add Students, pick Subjects. No edit/delete
/// UX beyond what's needed to exercise the flow manually.
class ClassDetailScreen extends ConsumerWidget {
  const ClassDetailScreen({required this.classId, super.key});

  final String classId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(classStudentsProvider(classId));
    final classSubjectsAsync = ref.watch(classSubjectsProvider(classId));
    final allSubjectsAsync = ref.watch(allSubjectsProvider);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text('Students', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => _addStudent(context, ref),
                child: const Text('Add Student'),
              ),
              const SizedBox(height: 8),
              students.when(
                data: (list) => list.isEmpty
                    ? const Text('No Students yet.')
                    : Column(
                        children: [
                          for (final s in list)
                            ListTile(
                              title: Text(s.name),
                              subtitle: Text('Roll Number: ${s.rollNumber}'),
                            ),
                        ],
                      ),
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text('Error: $e'),
              ),
              const SizedBox(height: 24),
              Text('Subjects', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              switch ((allSubjectsAsync, classSubjectsAsync)) {
                (
                  AsyncData(value: final all),
                  AsyncData(value: final selected)
                ) =>
                  _SubjectPicker(
                    classId: classId,
                    allSubjects: all,
                    selectedSubjects: selected,
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

  Future<void> _addStudent(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    final rollController = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: rollController,
              decoration: const InputDecoration(labelText: 'Roll Number'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Add'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    final name = nameController.text.trim();
    final roll = rollController.text.trim();
    if (name.isEmpty || roll.isEmpty) return;
    await ref.read(studentsClientProvider).createStudent(
          classId: classId,
          body: CreateStudentRequest(name: name, rollNumber: roll),
        );
    ref.invalidate(classStudentsProvider(classId));
  }
}

class _SubjectPicker extends ConsumerWidget {
  const _SubjectPicker({
    required this.classId,
    required this.allSubjects,
    required this.selectedSubjects,
  });

  final String classId;
  final List<Subject> allSubjects;
  final List<Subject> selectedSubjects;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIds = selectedSubjects.map((s) => s.id).toSet();
    return Column(
      children: [
        for (final subject in allSubjects)
          CheckboxListTile(
            title: Text(subject.name),
            value: selectedIds.contains(subject.id),
            onChanged: (checked) async {
              final client = ref.read(classesClientProvider);
              if (checked ?? false) {
                await client.addClassSubject(
                  classId: classId,
                  body: AddClassSubjectRequest(subjectId: subject.id),
                );
              } else {
                await client.removeClassSubject(
                  classId: classId,
                  subjectId: subject.id,
                );
              }
              ref.invalidate(classSubjectsProvider(classId));
            },
          ),
      ],
    );
  }
}
