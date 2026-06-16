import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';

part 'settings_controller.g.dart';

/// Supported locales. English and Spanish ("Casavia"/"Habita" markets).
const kSupportedLocales = [Locale('en'), Locale('es')];

class SettingsState {
  const SettingsState({required this.themeMode, this.locale});

  final ThemeMode themeMode;

  /// `null` means "follow the system locale".
  final Locale? locale;

  SettingsState copyWith({ThemeMode? themeMode, Locale? locale, bool clearLocale = false}) =>
      SettingsState(
        themeMode: themeMode ?? this.themeMode,
        locale: clearLocale ? null : (locale ?? this.locale),
      );
}

/// Holds theme mode and locale, persisting both across launches.
@Riverpod(keepAlive: true)
class Settings extends _$Settings {
  static const _themeKey = 'dwellio.themeMode';
  static const _localeKey = 'dwellio.locale';

  @override
  SettingsState build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final themeName = prefs.getString(_themeKey);
    final localeCode = prefs.getString(_localeKey);
    return SettingsState(
      themeMode: ThemeMode.values.firstWhere(
        (m) => m.name == themeName,
        orElse: () => ThemeMode.system,
      ),
      locale: (localeCode == null || localeCode.isEmpty)
          ? null
          : Locale(localeCode),
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await ref.read(sharedPreferencesProvider).setString(_themeKey, mode.name);
    state = state.copyWith(themeMode: mode);
  }

  Future<void> setLocale(Locale? locale) async {
    final prefs = ref.read(sharedPreferencesProvider);
    if (locale == null) {
      await prefs.remove(_localeKey);
    } else {
      await prefs.setString(_localeKey, locale.languageCode);
    }
    state = state.copyWith(locale: locale, clearLocale: locale == null);
  }
}
