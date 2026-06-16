import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/router/auth_guard.dart';
import '../../features/favorites/application/favorites_controller.dart';

/// Heart toggle wired to [FavoritesController]. Favoriting is auth-gated: a
/// guest tap routes to login and the toggle resumes after sign-in.
class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({
    super.key,
    required this.listingId,
    this.filledBackground = false,
  });

  final String listingId;

  /// When true (e.g. over a photo) the button sits on a tonal circle.
  final bool filledBackground;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesControllerProvider);
    final isFav = favorites.value?.contains(listingId) ?? false;
    final scheme = Theme.of(context).colorScheme;

    Future<void> toggle() => AuthGuard.run(ref, context, () async {
          try {
            await ref
                .read(favoritesControllerProvider.notifier)
                .toggle(listingId);
          } catch (_) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Couldn't update favorites")),
              );
            }
          }
        });

    final icon = IconButton(
      isSelected: isFav,
      onPressed: toggle,
      tooltip: isFav ? 'Remove from favorites' : 'Save to favorites',
      icon: Icon(isFav ? Icons.favorite : Icons.favorite_border,
          color: isFav ? scheme.error : null),
    );

    if (!filledBackground) return icon;
    return CircleAvatar(
      backgroundColor: scheme.surface.withValues(alpha: 0.85),
      child: icon,
    );
  }
}
