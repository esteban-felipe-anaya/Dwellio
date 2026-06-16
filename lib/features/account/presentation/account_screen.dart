import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../shared/widgets/app_network_image.dart';
import '../../auth/application/auth_controller.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final user = auth.value;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        children: [
          if (user == null)
            Padding(
              padding: AppSpacing.pageAll,
              child: Card(
                child: Padding(
                  padding: AppSpacing.pageAll,
                  child: Column(
                    children: [
                      const Icon(Icons.account_circle_outlined, size: 56),
                      const SizedBox(height: AppSpacing.sm),
                      Text("You're browsing as a guest",
                          style: theme.textTheme.titleMedium),
                      const SizedBox(height: AppSpacing.xs),
                      Text('Sign in to save homes, schedule tours and list properties.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant)),
                      const SizedBox(height: AppSpacing.md),
                      FilledButton(
                        onPressed: () => context.pushNamed(Routes.login),
                        child: const Text('Sign in or register'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            Padding(
              padding: AppSpacing.pageAll,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: ClipOval(
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: AppNetworkImage(url: user.photo ?? ''),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name, style: theme.textTheme.titleLarge),
                        Text(user.email,
                            style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const Divider(),
          _Tile(
            icon: Icons.add_home_work_outlined,
            label: 'List a property',
            onTap: () => context.pushNamed(Routes.sell),
          ),
          _Tile(
            icon: Icons.home_work_outlined,
            label: 'My listings',
            onTap: () => context.pushNamed(Routes.myListings),
          ),
          _Tile(
            icon: Icons.bookmark_border,
            label: 'Saved searches',
            onTap: () => context.pushNamed(Routes.savedSearches),
          ),
          _Tile(
            icon: Icons.favorite_border,
            label: 'Saved homes',
            onTap: () => context.goNamed(Routes.favorites),
          ),
          _Tile(
            icon: Icons.notifications_outlined,
            label: 'Notifications',
            onTap: () => context.pushNamed(Routes.notifications),
          ),
          const Divider(),
          _Tile(
            icon: Icons.settings_outlined,
            label: 'Settings',
            onTap: () => context.pushNamed(Routes.settings),
          ),
          if (user != null)
            _Tile(
              icon: Icons.logout,
              label: 'Sign out',
              onTap: () => ref.read(authControllerProvider.notifier).logout(),
            ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
