import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/env/env.dart';
import 'core/providers/core_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load runtime config (API base URL, etc.). isOptional so the app still
  // starts with built-in defaults if `.env` is missing.
  await dotenv.load(fileName: Env.fileName, isOptional: true);

  // SharedPreferences is needed synchronously by several controllers
  // (theme, locale, onboarding), so we initialize it before the app starts
  // and bind it into the provider graph.
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const DwellioApp(),
    ),
  );
}
