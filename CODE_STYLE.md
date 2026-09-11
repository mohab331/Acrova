# Code Styling & Best Practices

## 1. Design Token Access
**NEVER hardcode colors, dimensions, typography, or shadows.** 
Always use the global `Resources` accessor:
- Colors: `Resources.colors.luxuryNavy`
- Spacing (Horizontal): `Resources.horizontalDims.$20`
- Spacing (Vertical): `Resources.verticalDims.$16`
- Spacing (Square/Radius): `Resources.radius.$r2` or `Resources.squareDims.$24`
- Fonts: `Resources.fontSizes.$14`, `Resources.fontWeights.semiBold`
- Shadows: `AppShadows.cta`

## 2. Screen Scaffolding
Every new screen must be wrapped in the `CommonScreen` widget.
```dart
@override
Widget build(BuildContext context) {
  return CommonScreen(
    appBar: const AppAppBar(title: 'My Screen'),
    child: Column(
      children: [
        // Content
      ],
    ),
  );
}
```
This ensures consistent padding, gesture unwrapping, and background colors.

## 3. Localization and RTL
- Always wrap specific text or components in `Directionality` if required, but note that `CommonScreen` automatically handles base RTL injection based on `context.isRtl`.
- Do not use hardcoded left/right paddings. Use `EdgeInsetsDirectional.only(start: ..., end: ...)` instead of `EdgeInsets.only(left: ..., right: ...)`.

## 4. UI Scaling
The project strictly uses `flutter_screenutil`.
- Do not use raw doubles (e.g., `16.0`).
- Use the predefined tokens in `Resources` which internally call `.w`, `.h`, `.r`, `.sp`.

## 5. Theming
Avoid raw `Theme.of(context).textTheme` overrides where possible. Prefer composing text styles using `TextStyle` and `Resources`:
```dart
TextStyle(
  fontFamily: Resources.fonts.manrope,
  fontSize: Resources.fontSizes.$14,
  color: Resources.colors.luxuryBody,
)
```
## 5. Widgets
Avoid custom widget functions. Always use STL and STFL widgets:

For standard heading sizes, however, `Theme.of(context).textTheme.titleLarge` is acceptable and mapped correctly in `app_theme.dart`.
