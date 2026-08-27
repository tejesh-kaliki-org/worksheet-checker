import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:worksheet_checker/auth/auth_controller.dart';
import 'package:worksheet_checker/router/app_shell.dart';
import 'package:worksheet_checker/screens/class_detail_screen.dart';
import 'package:worksheet_checker/screens/classes_screen.dart';
import 'package:worksheet_checker/screens/exam_detail_screen.dart';
import 'package:worksheet_checker/screens/exam_subject_questions_screen.dart';
import 'package:worksheet_checker/screens/login_screen.dart';
import 'package:worksheet_checker/screens/otp_screen.dart';
import 'package:worksheet_checker/screens/signup_screen.dart';
import 'package:worksheet_checker/screens/submissions_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  // Bridge the auth state into a Listenable so GoRouter re-evaluates redirects.
  final refresh = ValueNotifier<Object?>(null);
  ref
    ..onDispose(refresh.dispose)
    ..listen(
      authControllerProvider,
      (_, next) => refresh.value = next,
      fireImmediately: true,
    )
    ..listen(
      pendingVerificationControllerProvider,
      (_, next) => refresh.value = next,
      fireImmediately: true,
    );

  return GoRouter(
    initialLocation: '/',
    refreshListenable: refresh,
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      if (auth.isLoading) return null; // wait for the initial load
      final loggedIn = auth.valueOrNull != null;
      final awaitingOtp =
          ref.read(pendingVerificationControllerProvider) != null;
      final onOtpScreen = state.matchedLocation == '/verify';
      if (!loggedIn && awaitingOtp) return onOtpScreen ? null : '/verify';
      if (onOtpScreen) return loggedIn ? '/' : '/login';
      final onAuthScreen = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';

      if (!loggedIn && !onAuthScreen) return '/login';
      if (loggedIn && onAuthScreen) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/signup', builder: (_, __) => const SignupScreen()),
      GoRoute(path: '/verify', builder: (_, __) => const OtpScreen()),
      // Authenticated routes share the AppShell (app bar + sign-out). Add new
      // authed screens as GoRoute entries here.
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: '/', builder: (_, __) => const ClassesScreen()),
          GoRoute(
            path: '/classes/:classId',
            builder: (_, state) => ClassDetailScreen(
              classId: state.pathParameters['classId']!,
            ),
          ),
          GoRoute(
            path: '/exams/:examId',
            builder: (_, state) => ExamDetailScreen(
              examId: state.pathParameters['examId']!,
              classId: state.extra as String?,
            ),
          ),
          GoRoute(
            path: '/exam-subjects/:examSubjectId',
            builder: (_, state) => ExamSubjectQuestionsScreen(
              examSubjectId: state.pathParameters['examSubjectId']!,
              classId: state.extra as String?,
            ),
          ),
          GoRoute(
            path: '/exam-subjects/:examSubjectId/submissions',
            builder: (_, state) => SubmissionsScreen(
              examSubjectId: state.pathParameters['examSubjectId']!,
              classId: state.extra as String? ?? '',
            ),
          ),
        ],
      ),
    ],
  );
}
