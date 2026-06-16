import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/application/auth_controller.dart';
import 'routes.dart';

/// Holds an action deferred because the user wasn't signed in. After a
/// successful login the auth flow runs and clears it — this is what makes
/// "favorite → login → resume" work.
class PendingActionHolder {
  Future<void> Function()? action;
}

final pendingActionProvider =
    Provider<PendingActionHolder>((ref) => PendingActionHolder());

/// Runs [action] if signed in; otherwise stashes it and routes to login so it
/// resumes automatically once authentication completes.
class AuthGuard {
  const AuthGuard._();

  static Future<void> run(
    WidgetRef ref,
    BuildContext context,
    Future<void> Function() action,
  ) async {
    if (ref.read(isAuthenticatedProvider)) {
      await action();
      return;
    }
    ref.read(pendingActionProvider).action = action;
    if (context.mounted) context.pushNamed(Routes.login);
  }
}
