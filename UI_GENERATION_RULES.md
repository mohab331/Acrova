# Rules For Future AI Generated Screens

## Core Philosophy
This application uses a premium, dense luxury style. It is not standard Material Design. It features architectural spacing, subtle gold accents, and deep navy primary elements.

## 1. NEVER Invent Colors
- **ALWAYS** use the semantic palette defined in `Resources.colors`.
- **DO NOT** use generic Flutter colors (e.g., `Colors.red`, `Colors.blue`).
- For backgrounds, use `Resources.colors.luxuryBackground` (Scaffold) and `Resources.colors.luxurySurface` (Cards).
- For primary accents, use `Resources.colors.luxuryNavy`.
- For interactive highlights (progress, active borders, links), use `Resources.colors.luxuryGoldLight`.

## 2. Typography Rules
- **NEVER** invent text styles or hardcode fonts.
- Use `Theme.of(context).textTheme` or explicit tokens from `Resources.fontSizes` / `Resources.fontWeights`.
- `NotoSerif` is strictly for Headings (`display`, `headline`, `titleLarge`, `titleMedium`).
- `Manrope` is strictly for Body/Labels (`bodyLarge`, `bodyMedium`, `bodySmall`, `labelLarge`).
- Secondary buttons and inputs use `Manrope`.
- Buttons use specific uppercase, letter-spaced typography: `Resources.fontSizes.$14`, `semiBold`.

## 3. Spacing & Sizing Rules
- **NEVER** use hardcoded double values for dimensions.
- **ALWAYS** use `flutter_screenutil` dimensions defined in `Resources.horizontalDims`, `Resources.verticalDims`, and `Resources.squareDims`.
- Example: `SizedBox(height: Resources.verticalDims.$16)` instead of `SizedBox(height: 16)`.
- Use `.w` for horizontal spacing, `.h` for vertical spacing, and `.r` for radii and square icons/avatars.

## 4. Component Usage
- **ALWAYS** reuse existing widgets from `lib/presentation/features/common_widgets`.
- Use `AppPrimaryButton` for primary CTAs (Navy, 55px height, 2px architectural radius).
- Use `AppSecondaryButton` for ghost/outline buttons.
- Use `CommonScreen` for scaffold wrapper, which handles `SafeArea`, `GestureDetector` (for unfocusing), and standard background colors.
- Use `AppAppBar` instead of native `AppBar`.
- For text fields, use `LuxuryIconTextField` or `WizardTextField`.

## 5. Shape and Shadow Rules
- **NEVER** use large rounded corners (like 16px or 24px) for inputs or buttons unless specifically documented. The core architectural radius is `Resources.radius.$r2`.
- Use shadows from `AppShadows` (e.g., `AppShadows.cta` for primary buttons, `AppShadows.card` for subtle lift).

# Prompt Context For UI Generation Tools

**Visual Identity**: Luxury, minimalist, real-estate / architectural feeling. Dark navy (`#0B1F3A`) and subtle gold (`#735B24`).
**Component Behavior**: Solid rectangles with 2px corners, thin 1.5px borders for focus states, floating sheets with soft navy tinted drop-shadows.
**Typography**: High-contrast pairings. Classic Serif (NotoSerif) for headings to give an editorial feel, clean Sans-Serif (Manrope) for dense data and utility.
**Forms**: Filled inputs with `#F3F4F5` background, underline borders for icon fields, and full borders for wizard fields. Focus state relies on Gold accent border width of 1.5px to 2px.

When generating a screen, follow the `CommonScreen` structure and arrange items sequentially in a `Column` or `ListView`, adhering strictly to `Resources` for all design tokens.
