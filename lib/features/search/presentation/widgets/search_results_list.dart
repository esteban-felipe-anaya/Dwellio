import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../shared/widgets/listing_card.dart';
import '../../../../shared/widgets/state_views.dart';
import '../../application/search_controller.dart';

/// The scrollable results grid. Keeps the map↔list link live: selecting a pin
/// highlights and scrolls to the matching card here.
class SearchResultsList extends ConsumerStatefulWidget {
  const SearchResultsList({super.key, required this.crossAxisCount});

  final int crossAxisCount;

  @override
  ConsumerState<SearchResultsList> createState() => _SearchResultsListState();
}

class _SearchResultsListState extends ConsumerState<SearchResultsList> {
  final _scroll = ScrollController();
  final _itemKeys = <String, GlobalKey>{};

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchControllerProvider);

    // Map → list link: scroll the selected card into view.
    ref.listen(searchControllerProvider.select((s) => s.selectedId),
        (prev, next) {
      if (next == null) return;
      final key = _itemKeys[next];
      final ctx = key?.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(ctx,
            duration: AppDurations.normal, alignment: 0.1);
      }
    });

    return state.results.when(
      loading: () =>
          ListingGridSkeleton(crossAxisCount: widget.crossAxisCount),
      error: (e, _) => ErrorView(
        message: e is ApiException ? e.message : e.toString(),
        onRetry: () => ref.read(searchControllerProvider.notifier).refresh(),
      ),
      data: (listings) {
        if (listings.isEmpty) {
          return EmptyView(
            icon: Icons.search_off,
            title: 'No homes match your search',
            message: 'Try widening your filters or zooming the map out.',
            action: FilledButton.tonal(
              onPressed: () =>
                  ref.read(searchControllerProvider.notifier).clearAll(),
              child: const Text('Clear filters'),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async =>
              ref.read(searchControllerProvider.notifier).refresh(),
          child: GridView.builder(
            controller: _scroll,
            padding: AppSpacing.pageAll,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              mainAxisExtent: 300,
              crossAxisSpacing: AppSpacing.lg,
              mainAxisSpacing: AppSpacing.lg,
            ),
            itemCount: listings.length,
            itemBuilder: (context, i) {
              final listing = listings[i];
              final key = _itemKeys.putIfAbsent(listing.id, () => GlobalKey());
              return KeyedSubtree(
                key: key,
                child: ListingCard(
                  listing: listing,
                  highlighted: listing.id == state.selectedId,
                  onTap: () {
                    ref
                        .read(searchControllerProvider.notifier)
                        .select(listing.id);
                    context.pushNamed(Routes.listing,
                        pathParameters: {'id': listing.id});
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
