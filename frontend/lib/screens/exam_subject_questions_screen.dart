import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_api_client/export.dart';

import 'package:worksheet_checker/api/rest_client_provider.dart';

part 'exam_subject_questions_screen.g.dart';

@riverpod
Future<List<Question>> examSubjectQuestions(
  Ref ref,
  String examSubjectId,
) async {
  final result = await ref
      .watch(questionsClientProvider)
      .listQuestions(examSubjectId: examSubjectId);
  return result.questions;
}

/// Bare-functional Question catalogue for one Exam Subject: add a Question
/// per Question Type with minimal type-appropriate config inputs, delete.
/// No edit UX beyond what's needed to exercise the flow manually.
class ExamSubjectQuestionsScreen extends ConsumerWidget {
  const ExamSubjectQuestionsScreen({required this.examSubjectId, super.key});

  final String examSubjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(examSubjectQuestionsProvider(examSubjectId));

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text('Questions', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => _addQuestion(context, ref),
                child: const Text('New Question'),
              ),
              const SizedBox(height: 16),
              questions.when(
                data: (list) => list.isEmpty
                    ? const Text('No Questions yet.')
                    : Column(
                        children: [
                          for (final q in list)
                            ListTile(
                              title: Text(
                                  '${q.type.name} — ${q.maximumMarks} marks'),
                              subtitle: Text(q.config.toString()),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () async {
                                  await ref
                                      .read(questionsClientProvider)
                                      .deleteQuestion(
                                        examSubjectId: examSubjectId,
                                        questionId: q.id,
                                      );
                                  ref.invalidate(
                                    examSubjectQuestionsProvider(examSubjectId),
                                  );
                                },
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

  Future<void> _addQuestion(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<_NewQuestionResult>(
      context: context,
      builder: (context) => const _NewQuestionDialog(),
    );
    if (result == null) return;
    await ref.read(questionsClientProvider).createQuestion(
          examSubjectId: examSubjectId,
          body: CreateQuestionRequest(
            type: result.type,
            maximumMarks: result.maximumMarks,
            config: result.config,
          ),
        );
    ref.invalidate(examSubjectQuestionsProvider(examSubjectId));
  }
}

class _NewQuestionResult {
  _NewQuestionResult({
    required this.type,
    required this.maximumMarks,
    required this.config,
  });

  final QuestionType type;
  final double maximumMarks;
  final Map<String, dynamic> config;
}

class _NewQuestionDialog extends StatefulWidget {
  const _NewQuestionDialog();

  @override
  State<_NewQuestionDialog> createState() => _NewQuestionDialogState();
}

class _NewQuestionDialogState extends State<_NewQuestionDialog> {
  QuestionType _type = QuestionType.mcq;
  final _marksController = TextEditingController(text: '1');

  // mcq
  final _optionsController = TextEditingController(text: 'A:one, B:two');
  final _mcqCorrectController = TextEditingController(text: 'A');
  // true_false
  bool _tfCorrect = true;
  // numeric
  final _numericCorrectController = TextEditingController();
  final _toleranceController = TextEditingController(text: '0');
  // fill_in
  final _fillInCorrectController = TextEditingController();
  // open_response
  final _rubricController = TextEditingController(text: 'point one\npoint two');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Question'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<QuestionType>(
              value: _type,
              items: [
                for (final t in QuestionType.values)
                  DropdownMenuItem(value: t, child: Text(t.name)),
              ],
              onChanged: (t) => setState(() => _type = t ?? _type),
            ),
            TextField(
              controller: _marksController,
              decoration: const InputDecoration(labelText: 'Maximum Marks'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            ..._configFields(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _build()),
          child: const Text('Create'),
        ),
      ],
    );
  }

  List<Widget> _configFields() {
    switch (_type) {
      case QuestionType.mcq:
        return [
          TextField(
            controller: _optionsController,
            decoration: const InputDecoration(
              labelText: 'Options (e.g. A:one, B:two)',
            ),
          ),
          TextField(
            controller: _mcqCorrectController,
            decoration: const InputDecoration(labelText: 'Correct option key'),
          ),
        ];
      case QuestionType.trueFalse:
        return [
          SwitchListTile(
            title: const Text('Correct answer'),
            value: _tfCorrect,
            onChanged: (v) => setState(() => _tfCorrect = v),
          ),
        ];
      case QuestionType.numeric:
        return [
          TextField(
            controller: _numericCorrectController,
            decoration: const InputDecoration(labelText: 'Correct answer'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _toleranceController,
            decoration: const InputDecoration(labelText: 'Tolerance'),
            keyboardType: TextInputType.number,
          ),
        ];
      case QuestionType.fillIn:
        return [
          TextField(
            controller: _fillInCorrectController,
            decoration: const InputDecoration(labelText: 'Correct answer'),
          ),
        ];
      case QuestionType.openResponse:
        return [
          TextField(
            controller: _rubricController,
            decoration: const InputDecoration(
              labelText: 'Rubric points (one per line)',
            ),
            maxLines: 4,
          ),
        ];
      case QuestionType.$unknown:
        return const [];
    }
  }

  _NewQuestionResult _build() {
    final marks = double.tryParse(_marksController.text) ?? 0;
    switch (_type) {
      case QuestionType.mcq:
        final options = <String, String>{};
        for (final pair in _optionsController.text.split(',')) {
          final parts = pair.split(':');
          if (parts.length == 2) {
            options[parts[0].trim()] = parts[1].trim();
          }
        }
        return _NewQuestionResult(
          type: _type,
          maximumMarks: marks,
          config: {
            'options': options,
            'correct_answer': _mcqCorrectController.text.trim(),
          },
        );
      case QuestionType.trueFalse:
        return _NewQuestionResult(
          type: _type,
          maximumMarks: marks,
          config: {'correct_answer': _tfCorrect},
        );
      case QuestionType.numeric:
        return _NewQuestionResult(
          type: _type,
          maximumMarks: marks,
          config: {
            'correct_answer':
                double.tryParse(_numericCorrectController.text) ?? 0,
            'tolerance': double.tryParse(_toleranceController.text) ?? 0,
          },
        );
      case QuestionType.fillIn:
        return _NewQuestionResult(
          type: _type,
          maximumMarks: marks,
          config: {'correct_answer': _fillInCorrectController.text.trim()},
        );
      case QuestionType.openResponse:
        return _NewQuestionResult(
          type: _type,
          maximumMarks: marks,
          config: {
            'rubric_points': _rubricController.text
                .split('\n')
                .map((s) => s.trim())
                .where((s) => s.isNotEmpty)
                .toList(),
          },
        );
      case QuestionType.$unknown:
        return _NewQuestionResult(type: _type, maximumMarks: marks, config: {});
    }
  }
}
