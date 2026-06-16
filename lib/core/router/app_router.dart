import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/account/presentation/account_screen.dart';
import '../../features/account/presentation/my_listings_screen.dart';
import '../../features/account/presentation/settings_screen.dart';
import '../../features/auth/application/auth_controller.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/favorites/presentation/favorites_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/inquiries/presentation/inquiries_screen.dart';
import '../../features/listing/presentation/listing_detail_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/saved_searches/presentation/saved_searches_screen.dart';
import '../../features/search/presentation/search_screen.dart';
import '../../features/sell/presentation/sell_screen.dart';
import '../providers/core_providers.dart';
import '../../shared/widgets/app_scaffold.dart';
import 'routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

const _onboardedKey = 'dwellio.onboarded';

final routerProvider = Provider<GoRouter>((ref) {
  // Rebuild redirects whenever auth changes (sign in / sign out).
  final refresh = ValueNotifier<int>(0);
  ref.onDispose(refresh.dispose);
  ref.listen(authControllerProvider, (_, _) => refresh.value++);

  final onboarded =
      ref.read(sharedPreferencesProvider).getBool(_onboardedKey) ?? false;

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: onboarded ? Routes.homePath : Routes.onboardingPath,
    refreshListenable: refresh,
    redirect: (context, state) {
      final authed = ref.read(isAuthenticatedProvider);
      // Auth-only destinations redirect guests to login, preserving intent.
      const guarded = {Routes.sellPath};
      if (!authed && guarded.contains(state.matchedLocation)) {
        return '${Routes.loginPath}?redirect=${state.matchedLocation}';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.onboardingPath,
        name: Routes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: Routes.loginPath,
        name: Routes.login,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) =>
            LoginScreen(redirect: state.uri.queryParameters['redirect']),
      ),
      GoRoute(
        path: Routes.registerPath,
        name: Routes.register,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: Routes.forgotPasswordPath,
        name: Routes.forgotPassword,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: Routes.listingPath,
        name: Routes.listing,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) =>
            ListingDetailScreen(listingId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: Routes.savedSearchesPath,
        name: Routes.savedSearches,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SavedSearchesScreen(),
      ),
      GoRoute(
        path: Routes.sellPath,
        name: Routes.sell,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SellScreen(),
      ),
      GoRoute(
        path: Routes.notificationsPath,
        name: Routes.notifications,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: Routes.myListingsPath,
        name: Routes.myListings,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const MyListingsScreen(),
      ),
      GoRoute(
        path: Routes.settingsPath,
        name: Routes.settings,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
      ),
      // Main shell: bottom NavigationBar / NavigationRail across 5 sections.
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state, navigationShell) =>
            AppScaffold(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKey,
            routes: [
              GoRoute(
                path: Routes.homePath,
                name: Routes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.searchPath,
              name: Routes.search,
              builder: (context, state) => const SearchScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.favoritesPath,
              name: Routes.favorites,
              builder: (context, state) => const FavoritesScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.inquiriesPath,
              name: Routes.inquiries,
              builder: (context, state) => const InquiriesScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.accountPath,
              name: Routes.account,
              builder: (context, state) => const AccountScreen(),
            ),
          ]),
        ],
      ),
    ],
  );
});

/// Marks onboarding complete so subsequent launches skip it.
Future<void> completeOnboarding(WidgetRef ref) =>
    ref.read(sharedPreferencesProvider).setBool(_onboardedKey, true);
