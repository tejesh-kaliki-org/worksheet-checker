import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_api_client/export.dart';

import 'package:worksheet_checker/api/rest_client_provider.dart';

part 'evaluation_screen.g.dart';

@riverpod
Future<List<EvaluationAttempt>> evaluationAttempts(
  Ref ref,
  String answerId,
) async {
  final result =
      await ref.watch(evaluationsClientProvider).listEvaluationAttempts(
            answerId: answerId,
          );
  return result.evaluationAttempts;
}

/// Bare-functional screen for issue #7: trigger the AI grading pipeline for
/// a single Answer and display its Evaluation Attempts (score, marks,
/// feedback). Deliberately unpolished -- no styling beyond a plain list, per
/// the issue's scope.
class EvaluationScreen extends ConsumerStatefulWidget {
  const EvaluationScreen({required this.answerId, super.key});

  final String answerId;

  @override
  ConsumerState<EvaluationScreen> createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends ConsumerState<EvaluationScreen> {
  bool _submitting = false;
  String? _message;

  Future<void> _trigger() async {
    setState(() {
      _submitting = true;
      _message = null;
    });
    try {
      await ref.read(evaluationsClientProvider).createEvaluationAttempt(
            answerId: widget.answerId,
          );
      ref.invalidate(evaluationAttemptsProvider(widget.answerId));
    } on Exception catch (e) {
      setState(() => _message = 'Error: $e');
    } finally {
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final attemptsAsync =
        ref.watch(evaluationAttemptsProvider(widget.answerId));

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                'Evaluation for Answer ${widget.answerId}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _submitting ? null : () => unawaited(_trigger()),
                child: Text(_submitting ? 'Grading...' : 'Trigger grading'),
              ),
              const SizedBox(height: 16),
              if (_message != null) Text(_message!),
              const SizedBox(height: 16),
              switch (attemptsAsync) {
                AsyncData(value: final attempts) => attempts.isEmpty
                    ? const Text('No Evaluation Attempts yet.')
                    : _AttemptList(attempts: attempts),
                AsyncError(:final error) => Text('Error: $error'),
                _ => const CircularProgressIndicator(),
              },
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _AttemptList extends StatelessWidget {
  const _AttemptList({required this.attempts});

  final List<EvaluationAttempt> attempts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final attempt in attempts) _AttemptTile(attempt: attempt),
      ],
    );
  }
}

class _AttemptTile extends StatelessWidget {
  const _AttemptTile({required this.attempt});

  final EvaluationAttempt attempt;

  @override
  Widget build(BuildContext context) {
    final eval = attempt.evaluation;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Attempt ${attempt.id}'),
            Text('Status: ${attempt.status.name}  '
                'Purpose: ${attempt.purpose.name}'),
            if (attempt.error != null) Text('Error: ${attempt.error}'),
            if (eval != null) ...[
              const SizedBox(height: 8),
              Text('Raw score: ${eval.rawScore.toStringAsFixed(2)}'),
              Text('Marks: ${eval.marks.toStringAsFixed(2)}'),
              Text('Feedback: ${eval.feedback}'),
            ],
          ],
        ),
      ),
    );
  }
}
