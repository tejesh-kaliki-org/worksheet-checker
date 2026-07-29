import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:worksheet_checker/auth/auth_controller.dart';

/// Authenticated landing screen, rendered inside AppShell (see
/// router/app_shell.dart for the shared app bar + sign-out action).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).valueOrNull;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          // min when it is just the status line; the items list below needs
          // Expanded, which requires the column to fill the available height.
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 24),
            const Icon(Icons.check_circle_outline, size: 48),
            const SizedBox(height: 16),
            Text(
              user == null ? 'Signed in' : 'Signed in as ${user.email}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
