import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/api/dwellio_api.dart';
import '../network/dio_client.dart';
import '../network/token_holder.dart';
import '../storage/token_store.dart';

/// Bound in [main] once [SharedPreferences] has initialized.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider not overridden'),
);

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

final tokenStoreProvider = Provider<TokenStore>(
  (ref) => TokenStore(ref.watch(secureStorageProvider)),
);

/// Shared, app-lifetime in-memory token holder read by the auth interceptor.
final tokenHolderProvider = Provider<TokenHolder>((ref) => TokenHolder());

final dioProvider = Provider<Dio>(
  (ref) => buildDio(ref.watch(tokenHolderProvider)),
);

final dwellioApiProvider = Provider<DwellioApi>(
  (ref) => DwellioApi(ref.watch(dioProvider)),
);
