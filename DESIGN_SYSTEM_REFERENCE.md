# Acrova Design System Reference

This document extracts the complete design language implemented in the Acrova Flutter codebase. It serves as the canonical reference for generating visually identical AI screens.

---

## 1. Theme Architecture

- **Theme Mode:** Light Theme primarily configured.
- **Material Version:** Material 3 (`useMaterial3: true`).
- **Entry Point:** `_AppTheme.lightTheme(Locale locale)` in `lib/presentation/app/resources/app_theme.dart`.

The system defines custom tokens in an abstract `Resources` class wrapper containing fonts, colors, dimensions, and shadows.

---

## 2. Color System

*Defined in `colors.dart`*

| Token | Hex/RGBA | Usage |
|--------|------|-------|
| **Base** |
| `white` | `#FFFFFF` | Standard white |
| **Backgrounds** |
| `luxuryBackground` | `#F8F9FA` | Screen / scaffold background |
| `luxurySurface` | `#FFFFFF` | Card / surface background |
| `luxuryInputBg` | `#F3F4F5` | OTP boxes / input fills |
| **Primary Palette** |
| `luxuryInk` | `#000615` | Deepest text, logo background |
| `luxuryNavy` | `#0B1F3A` | Primary CTA button, hero card bg, headings |
| `luxuryGold` | `#735B24` | Display heading accent (typography only) |
| `luxuryGoldLight` | `#735B24` | Interactive accents: progress, links, borders |
| `luxuryGoldOnDark`| `#FFDF9F` | Gold text overlaying dark backgrounds |
| **Text** |
| `luxuryBody` | `#44474D` | Body text, subtitles |
| `luxuryBodyMuted` | `rgba(68,71,77,0.7)` | Secondary / muted body text |
| `luxuryPlaceholder`| `#C4C6CE` | Input placeholder text |
| **Borders** |
| `luxuryBorder` | `#EDEEEF` | Card borders, dividers |
| `luxuryInputBorder`| `rgba(196,198,206,0.3)` | Input fields |

---

## 3. Typography System

*Defined in `app_fonts.dart`*

**Font Families:**
- Heading: `NotoSerif` (Classic, editorial feel)
- Body: `Manrope` (Clean, data-dense)
- Arabic: `IBMPlexArabic` (Dual-purpose)

**Key Text Styles (`TextTheme` map):**
- `displayLarge`: 57px, NotoSerif, 400.
- `headlineLarge`: 32px, NotoSerif, 400.
- `titleLarge`: 22px, NotoSerif, 500. (Used for App Bar titles)
- `titleMedium`: 16px, NotoSerif, 500. (Used for Card titles)
- `bodyLarge`: 16px, Manrope, 400, letter-spacing 0.15.
- `bodyMedium`: 14px, Manrope, 400.
- `labelLarge`: 14px, Manrope, 500.

---

## 4. Spacing System

*Defined in `dimens.dart` using `flutter_screenutil`.*

Dimensions are split vertically (`.h`), horizontally (`.w`), and square (`.r`).

**Common Vertical (`.h`):**
8, 12, 16, 20, 24, 32, 40, 60

**Common Horizontal (`.w`):**
8, 12, 16, 20, 24, 32

---

## 5. Radius System

*Defined in `radius.dart` using `.r` (aspect ratio aware).*

| Token | Value | Usage |
|-------|-------|-------|
| `$r2` | 2px | **CRITICAL** — Core architectural corner for inputs/cards. |
| `$r12`| 12px | Primary buttons. |
| `$r16`| 16px | Softer elements. |
| `$r100`| 100px| Pill / Stadium shapes. |

*Assumption:* Though `$r2` is listed as the architectural core, `AppPrimaryButton` uses `$r12` in the codebase. Both should be handled carefully depending on context.

---

## 6. Elevation & Shadow System

*Defined in `app_shadows.dart`*

| Token | Blur | Offset | Color | Usage |
|-------|------|--------|-------|-------|
| `card` | 1 | (0, 1) | `rgba(0,0,0, 0.05)` | Subtle card lift |
| `cta` | 16 | (0, 8) | `rgba(0,6,21, 0.10)` | Primary Navy button shadow |
| `hero` | 25 | (0, 20) | `rgba(0,0,0, 0.10)` | Dark hero card shadow |
| `sheet`| 30 | (0, -8)| `rgba(0,6,21, 0.08)` | Bottom sheet upward lift |

---

## 7. Layout Conventions

**`CommonScreen`**
Every main screen wraps its content in `CommonScreen`.
- Sets Scaffold background to `luxuryBackground`.
- Includes a global `GestureDetector` that removes focus from text fields upon background tap.
- Uses standard screen padding: 20px horizontally, 16px top, 60px bottom.

---

## 8. App Bar Standards

**`AppAppBar`**
- Height: `kToolbarHeight`.
- Elevation: 0 (flat).
- Title: Centered, uses `Theme.of(context).textTheme.titleLarge`.
- Back Button: Custom `AppAppBarBackButton`.
- Background: `luxuryBackground` by default.

---

## 9. Button Design Language

- **Primary Button (`AppPrimaryButton`)**: Solid navy, 55px height, 12px radius, uppercase Manrope 14px text, +0.8 letter spacing. Uses `AppShadows.cta`.
- **Secondary Button (`AppSecondaryButton`)**: Transparent background, 1px border (Navy or Gold depending on variant), 2px radius, 55px height.

---

## 10. Design Principles (Inferred)

- **Luxury Minimalist:** The UI uses tight spacing, thin architectural borders (1.5px to 2px for focus), and very slight rounding (2px/12px).
- **High Contrast Typography:** The mix of NotoSerif and Manrope creates a premium magazine or high-end real estate feeling.
- **Gold Accent Strategy:** Gold (`#735B24` and `#C8A96A`) is strictly reserved for interactive or highly focal elements (borders, progress lines, specific buttons), keeping the UI mostly monochrome (Navy/White/Grey).

---

## 11. AI Generation Rules

Refer to `UI_GENERATION_RULES.md` for specific AI prompt rules and guidelines.
