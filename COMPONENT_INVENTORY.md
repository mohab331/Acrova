# Component Catalog

This document provides an inventory of all reusable UI components found in the system, extracted from `lib/presentation/features/common_widgets`.

---

## Buttons

### Primary Button (`AppPrimaryButton`)
- **File:** `lib/presentation/features/common_widgets/buttons/app_primary_button.dart`
- **Usage:** Main call to actions (CTAs).
- **Properties:**
  - `label` (String)
  - `onPressed` (VoidCallback)
  - `isLoading` (bool)
  - `enabled` (bool)
  - `width` (double, default: infinity)
  - `icon` (Widget?)
- **Styles:**
  - **Height:** 55px
  - **Background:** `luxuryNavy` (#0B1F3A). Drops to 50% opacity when disabled.
  - **Radius:** 12px (originally 2px architecturally, but implemented as `$r12`).
  - **Typography:** `fontSizes.$14`, `semiBold`, letter spacing 0.8, UPPERCASE.
  - **Shadow:** Uses `AppShadows.cta` when active.
  - **Padding:** Horizontal 24px.

### Secondary Button (`AppSecondaryButton`)
- **File:** `lib/presentation/features/common_widgets/buttons/app_secondary_button.dart`
- **Usage:** Secondary actions, ghost/outline style.
- **Properties:**
  - `label` (String)
  - `onPressed` (VoidCallback)
  - `variant` (AppSecondaryButtonVariant: navy or gold)
- **Styles:**
  - **Height:** 55px
  - **Border:** 1px `luxuryNavy` or `luxuryGoldLight` depending on variant.
  - **Radius:** 2px.
  - **Typography:** `fontSizes.$16`, `semiBold`, `Manrope`, letter spacing 0.4.

---

## App Bars

### Standard App Bar (`AppAppBar`)
- **File:** `lib/presentation/features/common_widgets/app_bar/app_app_bar.dart`
- **Usage:** Default navigation header.
- **Properties:**
  - `title` (String?)
  - `titleWidget` (Widget?)
  - `showBack` (bool, default: true)
  - `backgroundColor` (Color?)
  - `brightness` (Brightness, default: light)
- **Styles:**
  - **Elevation:** 0
  - **Alignment:** Centered Title.
  - **Typography:** `Theme.of(context).textTheme.titleLarge` (NotoSerif).
  - **Leading Icon:** Custom `AppAppBarBackButton`.

---

## Layout Wrappers

### Common Screen (`CommonScreen`)
- **File:** `lib/presentation/features/common_widgets/common_screen/common_screen.dart`
- **Usage:** Standard screen wrapper. Every new screen should use this.
- **Features:**
  - Handles `Scaffold` background (`luxuryBackground`).
  - Implements `GestureDetector` to unfocus inputs on tap.
  - Manages `SafeArea` padding.
  - **Padding Default:** Left/Right 20px, Top 16px, Bottom 60px.
  - Directionality awareness (RTL support).

---

## Form Inputs

### Luxury Icon Text Field (`LuxuryIconTextField`)
- **File:** `lib/presentation/features/ui/auth/profile_setup/widgets/luxury_icon_text_field.dart`
- **Usage:** Primarily used in Auth and Profile forms.
- **Styles:**
  - **Background:** `luxuryProgressTrack` (or red tinted on error).
  - **Border:** `UnderlineInputBorder` (2px thickness). `luxuryGoldLight` on focus.
  - **Typography:** `fontSizes.$16`, `Manrope`, `regular`.
  - **Prefix Icon:** Included by default, size 18px.
  - **Radius:** Top-left and top-right 2px.

### Wizard Text Field (`WizardTextField`)
- **File:** `lib/presentation/features/ui/project_creation/steps/widgets/wizard_text_field.dart`
- **Usage:** Standard data entry for creation flows.
- **Styles:**
  - **Label:** `labelLarge` (`luxuryBody`).
  - **Background:** `luxuryInputBg`.
  - **Border:** 1px `luxuryInputBorder` by default. Focus states use `OutlineInputBorder` with 1.5px `luxuryGoldLight`.
  - **Radius:** 2px.
  - **Typography:** `bodyMedium` sized at 15px.
