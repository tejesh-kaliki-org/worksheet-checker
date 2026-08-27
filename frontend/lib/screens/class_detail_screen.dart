import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

@riverpod
Future<List<Exam>> classExams(Ref ref, String classId) async {
  final result =
      await ref.watch(examsClientProvider).listExams(classId: classId);
  return result.exams;
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
              OutlinedButton(
                onPressed: () => _bulkUploadStudents(context, ref),
                child: const Text('Bulk Upload Students'),
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
              const _AddSubjectsField(),
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
              const SizedBox(height: 24),
              Text('Exams', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => _createExam(context, ref),
                child: const Text('New Exam'),
              ),
              const SizedBox(height: 8),
              ref.watch(classExamsProvider(classId)).when(
                    data: (list) => list.isEmpty
                        ? const Text('No Exams yet.')
                        : Column(
                            children: [
                              for (final e in list)
                                ListTile(
                                  title: Text(e.label),
                                  onTap: () => context.push(
                                    '/exams/${e.id}',
                                    extra: classId,
                                  ),
                                ),
                            ],
                          ),
                    loading: () => const CircularProgressIndicator(),
                    error: (e, _) => Text('Error: $e'),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createExam(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final label = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Exam'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Label'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Create'),
          ),
        ],
      ),
    );
    if (label == null || label.trim().isEmpty) return;
    await ref.read(examsClientProvider).createExam(
          classId: classId,
          body: CreateExamRequest(label: label.trim()),
        );
    ref.invalidate(classExamsProvider(classId));
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

  /// Bare-functional roster upload: one "Name, Roll Number" per line, sent as a
  /// single all-or-nothing :bulk-upload request.
  Future<void> _bulkUploadStudents(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bulk Upload Students'),
        content: TextField(
          controller: controller,
          maxLines: 8,
          decoration: const InputDecoration(
            labelText: 'One per line: Name, Roll Number',
            hintText: 'Asha, 1\nBala, 2',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Upload'),
          ),
        ],
      ),
    );
    if (ok != true) return;

    final entries = <CreateStudentRequest>[];
    for (final line in controller.text.split('\n')) {
      if (line.trim().isEmpty) continue;
      final parts = line.split(',');
      if (parts.length != 2) continue;
      entries.add(
        CreateStudentRequest(
          name: parts[0].trim(),
          rollNumber: parts[1].trim(),
        ),
      );
    }
    if (entries.isEmpty) return;

    await ref.read(studentsClientProvider).bulkUploadStudents(
          classId: classId,
          body: BulkUploadStudentsRequest(students: entries),
        );
    ref.invalidate(classStudentsProvider(classId));
  }
}

/// Comma-separated entry for adding Subjects to the User's own catalogue.
/// Sent as one :bulk-create request, which is idempotent by name, so
/// re-submitting an existing Subject is a no-op rather than an error.
class _AddSubjectsField extends ConsumerStatefulWidget {
  const _AddSubjectsField();

  @override
  ConsumerState<_AddSubjectsField> createState() => _AddSubjectsFieldState();
}

class _AddSubjectsFieldState extends ConsumerState<_AddSubjectsField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final names = _controller.text
        .split(',')
        .map((n) => n.trim())
        .where((n) => n.isNotEmpty)
        .toList();
    if (names.isEmpty) return;
    await ref
        .read(subjectsClientProvider)
        .bulkCreateSubjects(body: BulkCreateSubjectsRequest(names: names));
    _controller.clear();
    ref.invalidate(allSubjectsProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Add Subjects (comma separated)',
              hintText: 'Music, Art',
            ),
            onSubmitted: (_) => _submit(),
          ),
        ),
        const SizedBox(width: 8),
        FilledButton(onPressed: _submit, child: const Text('Add')),
      ],
    );
  }
}

/// Checkbox multi-select over the User's whole catalogue. The selection is
/// staged locally and applied in one go: newly ticked Subjects go out as a
/// single :bulk-select request, unticked ones are removed individually (there
/// is no bulk deselect endpoint).
class _SubjectPicker extends ConsumerStatefulWidget {
  const _SubjectPicker({
    required this.classId,
    required this.allSubjects,
    required this.selectedSubjects,
  });

  final String classId;
  final List<Subject> allSubjects;
  final List<Subject> selectedSubjects;

  @override
  ConsumerState<_SubjectPicker> createState() => _SubjectPickerState();
}

class _SubjectPickerState extends ConsumerState<_SubjectPicker> {
  late Set<String> _staged = widget.selectedSubjects.map((s) => s.id).toSet();

  @override
  void didUpdateWidget(_SubjectPicker old) {
    super.didUpdateWidget(old);
    if (old.selectedSubjects != widget.selectedSubjects) {
      _staged = widget.selectedSubjects.map((s) => s.id).toSet();
    }
  }

  Future<void> _save() async {
    final client = ref.read(classesClientProvider);
    final current = widget.selectedSubjects.map((s) => s.id).toSet();
    final added = _staged.difference(current).toList();
    final removed = current.difference(_staged);

    if (added.isNotEmpty) {
      await client.bulkSelectClassSubjects(
        classId: widget.classId,
        body: BulkSelectClassSubjectsRequest(subjectIds: added),
      );
    }
    for (final id in removed) {
      await client.removeClassSubject(
        classId: widget.classId,
        subjectId: id,
      );
    }
    ref.invalidate(classSubjectsProvider(widget.classId));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final subject in widget.allSubjects)
          CheckboxListTile(
            title: Text(subject.name),
            value: _staged.contains(subject.id),
            onChanged: (checked) => setState(() {
              if (checked ?? false) {
                _staged.add(subject.id);
              } else {
                _staged.remove(subject.id);
              }
            }),
          ),
        FilledButton(
          onPressed: _save,
          child: const Text('Save Subject Selection'),
        ),
      ],
    );
  }
}
