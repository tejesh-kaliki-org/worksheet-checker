import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_api_client/export.dart';

import 'package:worksheet_checker/api/rest_client_provider.dart';

part 'classes_screen.g.dart';

/// Bare-functional Class list: create + list only, no polish. Tapping a
/// Class opens ClassDetailScreen (students + subject selection).
@riverpod
Future<List<Class>> classesList(Ref ref) async {
  final result = await ref.watch(classesClientProvider).listClasses();
  return result.classes;
}

class ClassesScreen extends ConsumerWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classes = ref.watch(classesListProvider);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 24),
            Text('Classes', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => _createClass(context, ref),
              child: const Text('New Class'),
            ),
            const SizedBox(height: 16),
            classes.when(
              data: (list) => list.isEmpty
                  ? const Text('No Classes yet.')
                  : Column(
                      children: [
                        for (final c in list)
                          ListTile(
                            title: Text(c.name),
                            onTap: () => context.push('/classes/${c.id}'),
                          ),
                      ],
                    ),
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Error: $e'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createClass(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Class'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Name'),
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
    if (name == null || name.trim().isEmpty) return;
    await ref
        .read(classesClientProvider)
        .createClass(body: CreateClassRequest(name: name.trim()));
    ref.invalidate(classesListProvider);
  }
}
