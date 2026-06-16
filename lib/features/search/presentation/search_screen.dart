import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/auth_guard.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../data/models/search_filters.dart';
import '../../../shared/widgets/filter_sheet.dart';
import '../../map/presentation/listings_map.dart';
import '../../saved_searches/application/saved_searches_controller.dart';
import '../application/search_controller.dart';
import 'widgets/search_results_list.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  int _columnsFor(double width) => (width / 340).floor().clamp(1, 4);

  Future<void> _openFilters(WidgetRef ref, BuildContext context) async {
    final current = ref.read(searchControllerProvider).filters;
    final result = await FilterSheet.show(context, current);
    if (result != null) {
      ref.read(searchControllerProvider.notifier).applyFilters(result);
    }
  }

  Future<void> _saveSearch(WidgetRef ref, BuildContext context) async {
    final filters = ref.read(searchControllerProvider).filters;
    final controller = TextEditingController(
        text: '${filters.dealType == 'rent' ? 'Rentals' : 'For sale'}'
            '${filters.q != null ? ' in ${filters.q}' : ''}');
    final label = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save this search'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (label == null || label.isEmpty) return;
    try {
      await ref.read(savedSearchesControllerProvider.notifier).save(label, filters);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Search saved'),
            action: SnackBarAction(
              label: 'View',
              onPressed: () => context.pushNamed(Routes.savedSearches),
            ),
          ),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Couldn't save search")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchControllerProvider);
    final filters = state.filters;
    final count = state.results.value?.length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _Toolbar(
              filters: filters,
              resultCount: count,
              onQuery: (q) =>
                  ref.read(searchControllerProvider.notifier).setQuery(q),
              onDealType: (d) =>
                  ref.read(searchControllerProvider.notifier).setDealType(d),
              onFilters: () => _openFilters(ref, context),
              onSort: (s) =>
                  ref.read(searchControllerProvider.notifier).setSort(s.value),
              onSave: () => AuthGuard.run(
                  ref, context, () async => _saveSearch(ref, context)),
            ),
            const Divider(height: 1),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  if (Breakpoints.isExpanded(width)) {
                    // Desktop/web split: results | map.
                    final listWidth = (width * 0.42).clamp(360.0, 560.0);
                    return Row(
                      children: [
                        SizedBox(
                          width: listWidth,
                          child: SearchResultsList(
                              crossAxisCount: _columnsFor(listWidth)),
                        ),
                        const VerticalDivider(width: 1),
                        const Expanded(child: ListingsMap()),
                      ],
                    );
                  }
                  // Compact/medium: toggle between list and full-screen map.
                  return Stack(
                    children: [
                      Offstage(
                        offstage: state.view == SearchView.map,
                        child: SearchResultsList(
                            crossAxisCount: _columnsFor(width)),
                      ),
                      Offstage(
                        offstage: state.view == SearchView.list,
                        child: const ListingsMap(),
                      ),
                      Positioned(
                        bottom: AppSpacing.lg,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: _ViewToggleFab(
                            view: state.view,
                            onToggle: () => ref
                                .read(searchControllerProvider.notifier)
                                .setView(state.view == SearchView.list
                                    ? SearchView.map
                                    : SearchView.list),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Toolbar extends StatefulWidget {
  const _Toolbar({
    required this.filters,
    required this.resultCount,
    required this.onQuery,
    required this.onDealType,
    required this.onFilters,
    required this.onSort,
    required this.onSave,
  });

  final SearchFilters filters;
  final int? resultCount;
  final ValueChanged<String> onQuery;
  final ValueChanged<String> onDealType;
  final VoidCallback onFilters;
  final ValueChanged<SortOption> onSort;
  final VoidCallback onSave;

  @override
  State<_Toolbar> createState() => _ToolbarState();
}

class _ToolbarState extends State<_Toolbar> {
  late final TextEditingController _searchText =
      TextEditingController(text: widget.filters.q ?? '');

  @override
  void didUpdateWidget(_Toolbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Keep the field in sync when the query changes elsewhere (e.g. cleared).
    final external = widget.filters.q ?? '';
    if (external != _searchText.text) _searchText.text = external;
  }

  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filters = widget.filters;
    final activeCount = filters.activeCount;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.sm),
      child: Column(
        children: [
          SearchBar(
            hintText: 'City, neighborhood or address',
            leading: const Icon(Icons.search),
            controller: _searchText,
            trailing: [
              if (_searchText.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchText.clear();
                    widget.onQuery('');
                  },
                ),
            ],
            onSubmitted: widget.onQuery,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              SegmentedButton<String>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: 'buy', label: Text('Buy')),
                  ButtonSegment(value: 'rent', label: Text('Rent')),
                ],
                selected: {filters.dealType},
                onSelectionChanged: (s) => widget.onDealType(s.first),
              ),
              const Spacer(),
              Badge.count(
                count: activeCount,
                isLabelVisible: activeCount > 0,
                child: IconButton.filledTonal(
                  tooltip: 'Filters',
                  onPressed: widget.onFilters,
                  icon: const Icon(Icons.tune),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              PopupMenuButton<SortOption>(
                tooltip: 'Sort',
                icon: const Icon(Icons.sort),
                onSelected: widget.onSort,
                itemBuilder: (context) => [
                  for (final option in SortOption.values)
                    PopupMenuItem(
                      value: option,
                      child: Row(
                        children: [
                          if (filters.sort == option.value)
                            const Icon(Icons.check, size: 18)
                          else
                            const SizedBox(width: 18),
                          const SizedBox(width: AppSpacing.sm),
                          Text(option.label),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                widget.resultCount == null
                    ? 'Searching…'
                    : '${widget.resultCount} '
                        '${widget.resultCount == 1 ? 'home' : 'homes'}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: widget.onSave,
                icon: const Icon(Icons.bookmark_add_outlined, size: 18),
                label: const Text('Save search'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ViewToggleFab extends StatelessWidget {
  const _ViewToggleFab({required this.view, required this.onToggle});
  final SearchView view;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final isList = view == SearchView.list;
    return FloatingActionButton.extended(
      onPressed: onToggle,
      icon: Icon(isList ? Icons.map_outlined : Icons.view_list_outlined),
      label: Text(isList ? 'Map' : 'List'),
    );
  }
}
