import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';

/// Brand lockup shown at the top of auth screens: house/key glyph + the
/// "Dwellio" wordmark in M3 headlineMedium.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(Icons.cottage_rounded, size: 56, color: theme.colorScheme.primary),
        const SizedBox(height: AppSpacing.md),
        Text('Dwellio',
            style: theme.textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: AppSpacing.xs),
        Text(subtitle,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center),
      ],
    );
  }
}
