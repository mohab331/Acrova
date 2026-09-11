# CLAUDE_PROJECT_CONTEXT.md

> **Read this file before implementing ANY feature.** It is the single source of truth for the Acrova
> Flutter codebase — architecture, conventions, available tokens, reusable widgets, and the exact rules
> every new file must follow. Pair it with `CLAUDE_FLUTTER_ENGINEERING_GUIDELINES.md` (the rule set).

---

## 1. Project Snapshot

- **App:** Acrova — premium PropTech mobile client (iOS + Android) for the Saudi architectural-design lifecycle.
- **Stack:** Flutter, `flutter_bloc` (Cubit), `go_router`, `get_it`, `flutter_screenutil`, `dio`, `cached_network_image`, `flutter_secure_storage`, `firebase_messaging`.
- **State:** Backend NOT built — all data comes from **mock data sources**. Toggle via `EnvironmentConfig.enableMock` (reads `.env` `USE_MOCK`).
- **Localization:** English (`en`) + Arabic (`ar`, full RTL). ARB files in `lib/core/l10n/`. Run `flutter gen-l10n` after editing ARBs.
- **Design scale:** ScreenUtil design size 390×884.

---

## 2. Architecture (Clean Architecture — STRICT)

```
lib/
├── core/
│   ├── app_runner/         # AcrovaApp root widget, app_initialization
│   ├── config/             # EnvironmentConfig (mock_config.dart)
│   ├── di/                 # get_it injectors (data_source / repo / cubit / usecase / session)
│   ├── error/              # AppErrorModel, ErrorCodesEnum
│   └── l10n/               # app_en.arb, app_ar.arb, generated AppLocalizations
├── data/
│   ├── data_source/
│   │   ├── base/           # abstract data source contracts
│   │   ├── local/          # SharedPreferences + SecureStorage + image picker
│   │   ├── mock/services/  # MockAuth/Dashboard/Project data sources
│   │   └── remote/         # ApiClient (dio), interceptors, remote data sources
│   ├── models/             # request/ + response/ + project/ + dashboard/
│   └── repository/         # *RepoImpl — implements domain contracts
├── domain/
│   └── repository/         # base_*_repo.dart abstract contracts (NO usecases unless needed)
├── presentation/
│   ├── app/
│   │   ├── navigation/     # app_router.dart (GoRouter), app_route_enum.dart, nav_keys.dart
│   │   └── resources/      # Resources.* design tokens (see §4)
│   └── features/
│       ├── common_widgets/ # shared reusable widgets (see §6)
│       ├── cubit/          # feature cubits + states (auth, dashboard, projects, project_creation, localization)
│       └── ui/             # one folder per screen, each with widgets/ subfolder
└── utils/
    ├── constants/          # app_constants, local_constants, secure_constants
    ├── enums/              # cubit_status, project_status_enum, project_type_enum, language_codes, ...
    ├── extensions/         # see §7
    ├── helpers/            # result, safe_async_call, date_formatter, launcher_service, ...
    ├── logging/            # AppLogger
    └── observers/          # AppBlocObserver
```

### Hard rules
- **NEVER** create folders outside this structure.
- **NEVER** add use cases or entities unless there's real business logic / multiple repos. Repositories return `Result<T>` directly.
- A new screen → `presentation/features/ui/<feature>/` with a `widgets/` subfolder for its private widgets.
- Cubits live in `presentation/features/cubit/<feature>/` (global) OR co-located with the screen (e.g. `phone_input/phone_input_cubit.dart`) when screen-scoped.

---

## 3. Widget Rules (ENFORCED — already refactored to this standard)

1. **One public widget per file.** Private helper widgets (`_Foo`) allowed only if tiny; otherwise extract to `widgets/`.
2. **Max ~200 lines per file.** Page files are thin (20–80 lines) and compose extracted widgets.
3. **Reusable across features** → `common_widgets/<category>/`. **Screen-specific** → `<feature>/widgets/`.
4. Every widget constructor takes `super.key`.
5. Prefer `const` constructors everywhere possible.
6. Use `BlocSelector` / `buildWhen` to minimize rebuilds.

---

## 4. Design Tokens — `Resources.*` (NEVER hardcode)

Access everything via the `Resources` facade (`presentation/app/resources/resources.dart`).
There are **ZERO hardcoded colors, sizes, radii, fonts, shadows, or gradients** in the codebase — keep it that way.

### Colors — `Resources.colors.*`
`white`, `luxuryBackground` `#F8F9FA`, `luxurySurface` `#FFFFFF`, `luxuryInputBg` `#F3F4F5`,
`luxuryInk` `#000615`, `luxuryNavy` `#0B1F3A`, `luxuryGold` `#735B24` (display typography ONLY),
`luxuryGoldLight` (ALL interactive accents), `luxuryGoldOnDark` `#FFDF9F`,
`luxuryBody` `#44474D`, `luxuryBodyMuted`, `luxuryPlaceholder` `#C4C6CE`,
`luxuryBorder` `#EDEEEF`, `luxuryInputBorder`, `luxuryGoldBorder`, `luxuryGoldBottomBorder` `#C8A96A`,
`luxuryProgressTrack` `#E7E8E9`, `luxuryError` `#C0392B`, `luxurySuccess` `#1A7A4A`, `luxuryWarning` `#D4850A`.

> **Gold rule:** `luxuryGold` = display heading accent word ONLY. Everything interactive uses `luxuryGoldLight`.

### Fonts — `Resources.fonts.*`
`manrope` (body/labels EN), `notoSerif` (headings EN), `ibmPlexArabic` (all AR).
Prefer `context.textTheme.*` (locale-aware) over manual `TextStyle`. Only set `fontFamily:` directly when
copying an exact Figma style not covered by the theme.

### Text theme — `context.textTheme.*` (via `theme_extension.dart`)
`displayLarge/Medium/Small`, `headlineLarge/Medium/Small`, `titleLarge/Medium/Small`,
`bodyLarge/Medium/Small`, `labelLarge/Medium/Small`. Auto-swaps fonts per locale.
Raw px sizes live in `AppTextTokens` (app_fonts.dart) if you need them.

### Font sizes — `Resources.fontSizes.$8 … $48` (sp)
### Font weights — `Resources.fontWeights.{light, regular, medium, semiBold, bold, extraBold}`
### Letter spacing — `Resources.letterSpacing.{$n1_2, $n0_9, $n0_6, $n0_5, $n0_4, $0, $0_14, $0_25, $0_3, $0_4, $0_8, $1_0, $1_2, $1_4, $2_38, $6_0}`
### Radius — `Resources.radius.$r0 … $r100` (**buttons/inputs = `$r2`, cards = `$r8`**)
### Horizontal spacing — `Resources.horizontalDims.$0 … $206` (`.w`)
### Vertical spacing — `Resources.verticalDims.$0_13 … $400` (`.h`)
### Icon sizes — `Resources.iconSizes.{$14,$16,$18,$20,$22,$24,$48,$50,$64}` (sp)
### Shadows — `AppShadows.{card, cta, hero, image, goldButton, float, featuredCard, sheet}`
### Gradients — `AppGradients.{heroCardOverlay, gridCardOverlay, detailHeaderScrim, designCardOverlay}` + `_AppGradientColors` (skeleton/brand fades, internal)
### Drawables — `Resources.drawables.{appLogoPNG, appLogoSVG, background, design1, img1, img2}`

> If a needed token is missing, **add it to the Resources class** — do not inline a literal.

---

## 5. State Management — Single State Cubit Pattern

Every cubit has exactly **one** state class: `FeatureCubit` + `FeatureCubitState`.

State requirements:
- `extends Equatable`, immutable, has `copyWith`.
- Holds a `CubitStatus cubitStatus` (`initial / loading / success / error`).
- Holds `AppErrorModel? appErrorModel` for errors.
- Convenience getters: `isLoading`, `isSuccess`, `isError`.

**NEVER** create `LoadingState` / `ErrorState` / `SuccessState` subclasses.

```dart
class FeatureCubitState extends Equatable {
  const FeatureCubitState({
    this.cubitStatus = CubitStatus.initial,
    this.appErrorModel,
    // ...feature fields
  });

  final CubitStatus cubitStatus;
  final AppErrorModel? appErrorModel;

  bool get isLoading => cubitStatus == CubitStatus.loading;
  bool get isSuccess => cubitStatus == CubitStatus.success;
  bool get isError   => cubitStatus == CubitStatus.error;

  FeatureCubitState copyWith({ ... }) => FeatureCubitState( ... );

  @override
  List<Object?> get props => [cubitStatus, appErrorModel, /* ... */];
}
```

Existing cubits: `AuthCubit`, `DashboardCubit`, `ProjectsCubit`, `ProjectCreationCubit`, `LocalizationCubit`,
`PhoneInputCubit` (screen-scoped), `SplashCubit` (screen-scoped).

---

## 6. Reusable Common Widgets (check BEFORE building new)

| Widget | File | Purpose |
|--------|------|---------|
| `AppPrimaryButton` | buttons/app_primary_button.dart | Full-width navy CTA, 2px radius, loading state, `icon`/`child` slots |
| `AppSecondaryButton` | buttons/app_secondary_button.dart | Outlined navy/gold button |
| `AppTextLinkButton` | buttons/app_text_link_button.dart | Inline text link |
| `AppCard` | cards/app_card.dart | White surface, 8px radius, border, `card` shadow, custom padding + onTap |
| `AppStatusChip` | chips/app_status_chip.dart | Project status badge (colored per stage) |
| `FiltersChip` | chips/app_filter_chip.dart | Filter tab (active=navy / inactive=inputBg) |
| `AppEmptyState` | feedback/app_empty_state.dart | Icon + title + subtitle + optional CTA |
| `AppErrorState` | feedback/app_error_state.dart | Error icon + message + retry (l10n defaults) |
| `AppSkeletonLoader` | feedback/app_skeleton_loader.dart | Shimmer wrapper |
| `SkeletonBox` | feedback/skeleton_box.dart | Static placeholder box (wrap in AppSkeletonLoader) |
| `AppSectionHeader` | layout/app_section_header.dart | Title + "VIEW ALL" action link |
| `AppDivider` | layout/app_divider.dart | Thin border divider |
| `AppProgressStepper` | progress/app_progress_stepper.dart | Wizard step indicator |
| `CommonScreen` | common_screen/common_screen.dart | Scaffold wrapper (RTL, padding, tap-to-dismiss) |
| `AppAuthBrandHeader` | app_bar/app_auth_brand_header.dart | "ACROVA" brand AppBar + optional back |
| `AvatarHeader` | app_bar/app_avatar_header.dart | Avatar + greeting + notification bell |
| `AvatarWidget` | app_bar/avatar_widget.dart | Circular avatar (navy fill + gold ring) |
| `NotificationBell` | app_bar/notification_bell.dart | Bell icon + count badge |
| `CustomBackButton` | app_bar/app_back_button.dart | Rounded 2px back button |
| `AppAppBar` | app_bar/app_app_bar.dart | Standard titled AppBar |
| `AppAppBarBackButton` | app_bar/app_app_bar_back_button.dart | AppBar back icon |
| `AppLogo` | app_logo/app_logo.dart | Logo image (navy tint) |
| `AppCachedNetworkImage` | images/app_cached_network_image.dart | Cached image + shimmer placeholder |

> If a widget is partially suitable → add a **named constructor** / params. Only create new if truly unavoidable.

---

## 7. Extensions (use, don't reinvent)

`context.localization` (l10n) · `context.isRtl` · `context.textTheme` / `context.theme` ·
`context.push/pop/goTo/pushReplacement` (navigation_extension) · `context.screenWidth/Height` (media_query) ·
validation_extension · result_x · number_formatting_extension · string_extensions · non_null_extension ·
api_error_l10n_x · primary_button_theme_X.

---

## 8. Data / API Layer Conventions

- **Repository contracts** in `domain/repository/`, impls in `data/repository/`. Inputs = Request models, outputs = `Result<T>` / Response models.
- **Never pass primitives** to repo methods — wrap in a Request model (`extends Equatable`, `toJson()`, `const`).
- **Response models**: `extends Equatable`, `factory fromJson()`, immutable.
- **Async safety:** wrap every async op in `safeAsyncCall(...)` / `safeCall(...)` → returns `Result<T>` (Success/Failure with `AppErrorModel`). No bare try/catch in repos.
- **Mock vs Remote:** the `DataSourcesInjector` picks `Mock*` or `Remote*` based on `EnvironmentConfig.enableMock`. New data sources must register both.
- Constants → `utils/constants/` (e.g. `LocalConstants`, `SecureConstants`). Never inline storage keys.

---

## 9. Navigation (`app_route_enum.dart` + `app_router.dart`)

Routes: `splashPage`, `welcomePage`, `phonePage`, `identityVerificationPage`, `profileSetupPage`, `authPage`,
shell: `homePage` `/home`, `projectsPage` `/projects`, `portfolioPage` `/portfolio`, `messagesPage` `/messages`, `profilePage` `/profile`,
full-screen: `projectCreationPage` `/project-creation`, `portfolioDetailPage` `/portfolio-detail`.

- Bottom-nav shell = `StatefulShellRoute.indexedStack` (5 branches). Add tab routes as branches.
- Full-screen overlays use `rootNavigatorKey` (above the shell).
- Auth redirect driven by `AuthCubit.stream` via `_GoRouterRefreshStream`.

---

## 10. Business Domain — Project Lifecycle (drives everything)

8 stages (`ProjectStatus` enum) in order: `awaitingPricing` → `awaitingPayment` → `paymentUnderReview` →
`awaitingEngineeringAssignment` → `awaitingEngineering` → `deliverablesReady` → `revisionInProgress` → `completed`.
Each has `displayLabel` / `displayLabelAr`, a chip color, and a progress %. `isTerminal` = `completed`.

Project types (`ProjectType`): `residentialVilla`, `commercialBuilding`, `mixedUse` (each has `displayLabel`/`displayLabelAr`).

### Key rules to honor in any feature
- Max **3** concurrent active projects per customer.
- Project ID format `ARC-YYYY-XXXXX`.
- **2–3 free revisions**, paid beyond.
- Payment = **manual bank transfer + receipt upload** (NO payment gateway).
- OTP via custom backend SMS (NOT Firebase Phone Auth); 5-min countdown.
- KYC (name, email, National ID, language) mandatory after first OTP login (new users).
- SBC advisory pre-check: min land 150 m², max 5 floors, warn if width < 10 m (advisory only, non-blocking).
- Hijri calendar default, SAR currency.

---

## 11. Localization Workflow

1. Add key to **both** `lib/core/l10n/app_en.arb` and `app_ar.arb`.
2. Run `flutter gen-l10n`.
3. Use via `context.localization.<key>`.
4. NO hardcoded user-facing strings — ever. Validation messages, button labels, errors all localized.
5. Arabic: no Latin letter-spacing; layout mirrors (RTL handled by `CommonScreen` / `Directionality`).

---

## 12. Build Phases (current → remaining)

**Done:** Phase 0 design system, Phase 1 auth (welcome/phone/OTP/profile setup), Phase 2 dashboard + shell,
Phase 3 project-creation wizard (6 steps), Phase 8 portfolio (list + detail), profile tab, messages stub.

**Remaining (design specs in `STITCH_BRIEF.md`):**
- **Phase 4** — Project Detail + Stage Pipeline (polymorphic per status, vertical timeline, per-stage action panels)
- **Phase 5** — Payment module (quote → bank details → receipt upload → tracking)
- **Phase 6** — Engineering deliverables (grouped list + in-app PDF viewer + download)
- **Phase 7** — Revisions (request form + history + free-revision counter)
- **Phase 9** — Interior design phase gate (Phase II)
- **Phase 10** — Notifications + Settings detail

---

## 13. Pre-Implementation Checklist (run for every feature)

Before writing code:
1. ☐ Read this file + `CLAUDE_FLUTTER_ENGINEERING_GUIDELINES.md`.
2. ☐ Check `common_widgets/` for a reusable widget; reuse or extend with a named constructor.
3. ☐ Check `Resources.*` for needed tokens; add any missing token to the Resources class (never inline).
4. ☐ Check `utils/extensions`, `utils/helpers`, `utils/enums`, `utils/constants` for existing utilities.
5. ☐ Decide cubit scope (global in `cubit/` vs screen-scoped co-located).
6. ☐ Add localization keys to BOTH ARBs + `flutter gen-l10n`.

While writing:
7. ☐ One public widget per file, `widgets/` subfolder for screen-specific pieces, ≤ ~200 lines.
8. ☐ Single-state cubit pattern + `CubitStatus` + `AppErrorModel` + `copyWith` + Equatable.
9. ☐ Request models (`toJson`), Response models (`fromJson`), both Equatable + immutable. and implements baseRequestModel
10. ☐ All async wrapped in `safeAsyncCall` / `safeCall`.
11. ☐ Register new data sources (mock + remote) and repos in the DI injectors.
12. ☐ `const` constructors, `BlocSelector`/`buildWhen` for rebuild control, dispose controllers.

After writing:
13. ☐ `flutter analyze` → **0 errors**.
14. ☐ Null-safe (no force unwraps outside guarded `safeCall`).
15. ☐ RTL verified, no hardcoded strings/colors/sizes/fonts.

---

## 14. Output Format When Implementing (expected from Claude)

Before code, provide: **Architecture Analysis** (files/widgets/resources reviewed) → **Reusable Components Found**
→ **New Files** → **Updated Files** → **New Resources** (l10n keys, tokens) → **Implementation Notes**.
Then deliver production-ready code. Never prototype-quality.
