import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/account/application/settings_controller.dart';

/// Root widget. Wires Material 3 theming (with platform dynamic color),
/// persisted theme mode + locale, and the go_router configuration.
class DwellioApp extends ConsumerWidget {
  const DwellioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final router = ref.watch(routerProvider);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        // Use platform dynamic color where available; otherwise fall back to
        // the Dwellio brand seed scheme.
        final lightScheme = lightDynamic?.harmonized() ??
            AppTheme.fallbackScheme(Brightness.light);
        final darkScheme = darkDynamic?.harmonized() ??
            AppTheme.fallbackScheme(Brightness.dark);

        return MaterialApp.router(
          title: 'Dwellio',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(lightScheme),
          darkTheme: AppTheme.dark(darkScheme),
          themeMode: settings.themeMode,
          locale: settings.locale,
          supportedLocales: kSupportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: router,
        );
      },
    );
  }
}
