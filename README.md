# Dwellio 🏡

**Find your Dwellio.** A production-quality, cross-platform real-estate search app
built with Flutter — running from a single codebase on **iOS, Android, Web, macOS,
Windows, and Linux**.

Dwellio is strictly **Material 3 (Material You)**, fully adaptive (phone → tablet →
desktop), and consumes a **mock REST API** through a real networking + repository
layer. Every flow is wired end to end: search → map → detail → favorite → schedule a
tour / contact an agent → it shows up in *My Inquiries*; saved searches and favorites
persist; the *Sell* flow publishes a listing that appears in search.

- **Brand seed color:** estate teal-green `#00696D`
- **Wordmark:** “Dwellio” in M3 `headlineMedium`, house/key glyph for the logo

---

## Tech stack

| Concern        | Choice |
|----------------|--------|
| UI             | Flutter (stable), Material 3, `dynamic_color` |
| State          | Riverpod 3 (`flutter_riverpod` + `riverpod_annotation` codegen) |
| Routing        | `go_router` (shell route, deep links, web URLs, auth redirect) |
| Networking     | `dio` + `retrofit`, `freezed` + `json_serializable` models |
| Map            | `flutter_map` (OpenStreetMap, no API key) + `flutter_map_marker_cluster` |
| Images         | `cached_network_image`, swipeable gallery |
| Storage        | `flutter_secure_storage` (token), `shared_preferences` (theme/locale/onboarding) |
| Formatting     | `intl` |

`flutter_map` is used deliberately instead of `google_maps_flutter` because it renders
and clusters on **all six platforms** (including web and desktop) with no API key.

---

## Project structure

```
lib/
  core/            # env, theme + design tokens, router, dio client, interceptors, utils
  data/            # freezed models, retrofit api client, repositories (+ Riverpod providers)
  features/
    auth/ onboarding/ home/ search/ map/ listing/
    favorites/ saved_searches/ inquiries/ sell/ account/ notifications/
      application/   # Riverpod controllers (state)
      presentation/  # screens + feature widgets
  shared/widgets/  # listing card, filter sheet, adaptive scaffold, loading/empty/error
  app.dart         # MaterialApp.router + theming + dynamic color
  main.dart        # bootstrap (SharedPreferences) + ProviderScope
mock-api/          # json-server: db.json generator, custom server, npm scripts
test/              # mortgage, filter→query mapping, repository (mocked Dio)
```

Repositories expose domain models; controllers hold UI/search/map state and call
repositories. **No JSON shapes or hardcoded business data live in widgets.**

---

## 1. Run the mock API

Requires Node.js 18+.

```bash
cd mock-api
npm install
npm run seed     # (re)generate db.json — 40 listings, 6 agents, etc. (already committed)
npm start        # http://localhost:3000
```

The server (`server.js`) wraps `json-server` and adds:

- `POST /auth/login`, `/auth/register`, `GET /auth/me` (token-based)
- listings filtering: `dealType, q, minPrice, maxPrice, beds, baths, type, minArea, amenities`
- **map-bounds search**: `swLat, swLng, neLat, neLng`
- `sort`, `_page`, `_limit`
- `GET /listings/:id/similar`, `POST /listings`
- favorites as a flat id list, tours, inquiries, notifications

**Demo account** (seeded): `demo@dwellio.app` / `password`
(the login screen is pre-filled with these).

> The network layer injects **300–800 ms latency and occasional failures** by default
> (`ChaosInterceptor`) so loading/error states are real. Disable with
> `--dart-define=DWELLIO_SIMULATE_NETWORK=false`.

---

## 2. Run the app

```bash
flutter pub get
# generate freezed / json / retrofit / riverpod code:
dart run build_runner build --delete-conflicting-outputs

flutter run            # pick a device, or:
flutter run -d chrome
flutter run -d windows
flutter run -d macos
flutter run -d linux
```

### Switching the API base URL

The base URL defaults to `http://localhost:3000`. Override it per run — no code change:

```bash
flutter run --dart-define=DWELLIO_API_BASE_URL=http://localhost:3000
```

Per-platform host values for a locally running mock API:

| Target              | `DWELLIO_API_BASE_URL` |
|---------------------|------------------------|
| Web / desktop       | `http://localhost:3000` |
| Android emulator    | `http://10.0.2.2:3000` |
| iOS simulator       | `http://localhost:3000` |
| Physical device     | `http://<your-machine-LAN-ip>:3000` |

---

## 3. Platform notes

- **Windows desktop builds** require *Developer Mode* enabled (for plugin symlinks):
  run `start ms-settings:developers`.
- **Web/desktop** need network access for OpenStreetMap tiles and `picsum.photos` images.
- On the desktop/web split view the map sits beside a scrollable results list; on phones
  the two swap via a Map/List toggle. Map panning re-queries by bounds; tapping a pin
  highlights and scrolls to its card and vice-versa.

---

## Adaptive layout

| Width            | Navigation                | Search layout                        | Grid |
|------------------|---------------------------|--------------------------------------|------|
| `< 600` compact  | bottom `NavigationBar`    | list **or** full-screen map (toggle) | 1–2 |
| `600–840` medium | `NavigationRail`          | list with map toggle                 | 2–3 |
| `> 840` expanded | extended `NavigationRail` | **split: results ⟷ map**             | 3+  |

Light, dark and platform dynamic color all supported; theme mode and locale (English /
Español) persist across launches.

---

## Tests

```bash
flutter test      # mortgage math, filter→query mapping, repository (mocked Dio)
flutter analyze   # zero issues
```

---

## Key end-to-end flows

1. **Search** (text, filters, sort, map bounds) → results update live.
2. **Map ⟷ list** linking with marker clustering.
3. **Listing detail**: photo gallery, specs, amenities, mini-map, agent card, live
   **mortgage estimator**, similar listings.
4. **Auth gating**: browse as guest; favoriting / tours / messaging / listing require
   login — you’re redirected to sign in and the action **resumes** automatically.
5. **Favorites** & **saved searches** persist; **tours/messages** appear in *My Inquiries*.
6. **Sell** wizard publishes a listing that then appears in search and *My listings*.

---

## Rebranding

To rename (e.g. **Roost**, **Casavia**, **Habita**): update `pubspec.yaml` `name`, the
app title in `lib/app.dart`, the wordmark in `lib/features/auth/.../auth_header.dart`
and `lib/shared/widgets/app_scaffold.dart`, and this README. Change the seed color in
`lib/core/theme/app_theme.dart` (`AppTheme.seedColor`).
