import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../shared/widgets/listing_card.dart';
import '../../../shared/widgets/state_views.dart';
import '../../sell/application/sell_controller.dart';

class MyListingsScreen extends ConsumerWidget {
  const MyListingsScreen({super.key});

  int _columns(double w) => (w / 340).floor().clamp(1, 4);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listings = ref.watch(myListingsControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My listings')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(Routes.sell),
        icon: const Icon(Icons.add),
        label: const Text('New listing'),
      ),
      body: listings.isEmpty
          ? EmptyView(
              icon: Icons.home_work_outlined,
              title: 'No listings yet',
              message: 'Publish a property and it will appear here and in search.',
              action: FilledButton(
                onPressed: () => context.pushNamed(Routes.sell),
                child: const Text('List a property'),
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) => GridView.builder(
                padding: AppSpacing.pageAll,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _columns(constraints.maxWidth),
                  mainAxisExtent: 300,
                  crossAxisSpacing: AppSpacing.lg,
                  mainAxisSpacing: AppSpacing.lg,
                ),
                itemCount: listings.length,
                itemBuilder: (context, i) => ListingCard(
                  listing: listings[i],
                  onTap: () => context.pushNamed(Routes.listing,
                      pathParameters: {'id': listings[i].id}),
                ),
              ),
            ),
    );
  }
}
