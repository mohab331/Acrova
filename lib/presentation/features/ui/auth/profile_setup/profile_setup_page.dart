import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nationalIdController = TextEditingController();
  String _selectedLanguage = 'en';

  String? _nameError;
  String? _emailError;
  String? _mobileError;
  String? _nationalIdError;

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _nationalIdFocus = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _nationalIdFocus.dispose();
    super.dispose();
  }

  bool _validate(BuildContext context) {
    final l10n = context.localization;
    String? nameErr;
    String? emailErr;
    String? mobileErr;
    String? nationalIdErr;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final nationalId = _nationalIdController.text.trim();

    if (name.isEmpty) {
      nameErr = l10n.profileSetupNameRequired;
    }

    if (email.isEmpty) {
      emailErr = l10n.profileSetupEmailRequired;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      emailErr = l10n.profileSetupEmailInvalid;
    }

    if (nationalId.isEmpty) {
      nationalIdErr = 'National ID is required';
    }

    setState(() {
      _nameError = nameErr;
      _emailError = emailErr;
      _mobileError = mobileErr;
      _nationalIdError = nationalIdErr;
    });

    return nameErr == null &&
        emailErr == null &&
        mobileErr == null &&
        nationalIdErr == null;
  }

  void _submit(BuildContext context) {
    if (!_validate(context)) return;
    context.read<AuthCubit>().saveProfile(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      nationalId: _nationalIdController.text.trim(),
      language: _selectedLanguage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return BlocListener<AuthCubit, AuthCubitState>(
      listenWhen: (prev, curr) => prev.cubitStatus != curr.cubitStatus,
      listener: (context, state) {
        if (state.isSuccess) {
          context.pushReplacement(AppRouteEnum.homePage.name);
        } else if (state.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.appErrorModel?.message ?? 'Failed to save profile.',
              ),
              backgroundColor: Resources.colors.luxuryError,
            ),
          );
        }
      },
      child: CommonScreen(
        resizeToAvoidBottomInset: true,
        bottomPadding: 0,
        appBar: const AppAuthBrandHeader(showBack: true),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Resources.verticalDims.$20),
              _ProfileCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Heading (centred) ────────────────────────────────
                    Text(
                      'Complete Your Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'NotoSerif',
                        fontSize: Resources.fontSizes.$24,
                        fontWeight: Resources.fontWeights.bold,
                        color: Resources.colors.luxuryInk,
                        letterSpacing: Resources.letterSpacing.$n0_6,
                      ),
                    ),

                    SizedBox(height: Resources.verticalDims.$8),

                    Text(
                      'To curate your exclusive real estate portfolio, '
                      'we require a few final details for a bespoke experience.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: Resources.fontSizes.$14,
                        color: Resources.colors.luxuryBody,
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: Resources.verticalDims.$28),

                    // ── Full Name ────────────────────────────────────────
                    _FieldLabel(label: l10n.profileSetupNameLabel),
                    SizedBox(height: Resources.verticalDims.$6),
                    _LuxuryIconTextField(
                      controller: _nameController,
                      focusNode: _nameFocus,
                      nextFocus: _emailFocus,
                      hint: l10n.profileSetupNameHint,
                      icon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      error: _nameError,
                      onChanged: (_) {
                        if (_nameError != null) {
                          setState(() => _nameError = null);
                        }
                      },
                    ),

                    SizedBox(height: Resources.verticalDims.$20),

                    // ── Email ────────────────────────────────────────────
                    _FieldLabel(label: l10n.profileSetupEmailLabel),
                    SizedBox(height: Resources.verticalDims.$6),
                    _LuxuryIconTextField(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      nextFocus: _nationalIdFocus,
                      hint: l10n.profileSetupEmailHint,
                      icon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      error: _emailError,
                      onChanged: (_) {
                        if (_emailError != null) {
                          setState(() => _emailError = null);
                        }
                      },
                    ),

                    SizedBox(height: Resources.verticalDims.$20),

                    // ── National ID ──────────────────────────────────────
                    const _FieldLabel(label: 'NATIONAL ID'),
                    SizedBox(height: Resources.verticalDims.$6),
                    _LuxuryIconTextField(
                      controller: _nationalIdController,
                      focusNode: _nationalIdFocus,
                      hint: 'Enter your National ID',
                      icon: Icons.badge_outlined,
                      keyboardType: TextInputType.text,
                      error: _nationalIdError,
                      onChanged: (_) {
                        if (_nationalIdError != null) {
                          setState(() => _nationalIdError = null);
                        }
                      },
                    ),

                    SizedBox(height: Resources.verticalDims.$24),

                    // ── Language ─────────────────────────────────────────
                    _FieldLabel(label: l10n.profileSetupLanguageLabel),
                    SizedBox(height: Resources.verticalDims.$12),
                    _LanguageSelector(
                      selected: _selectedLanguage,
                      onChanged: (lang) =>
                          setState(() => _selectedLanguage = lang),
                    ),

                    SizedBox(height: Resources.verticalDims.$28),

                    // ── CTA ──────────────────────────────────────────────
                    BlocBuilder<AuthCubit, AuthCubitState>(
                      builder: (context, state) => _EnterAcrovaButton(
                        isLoading: state.isLoading,
                        onPressed: () => _submit(context),
                      ),
                    ),

                    SizedBox(height: Resources.verticalDims.$20),

                    // ── Terms ────────────────────────────────────────────
                    const _TermsText(),
                  ],
                ),
              ),

              SizedBox(height: Resources.verticalDims.$32),

              // ── Footer ───────────────────────────────────────────────────
              const _PageFooter(),

              SizedBox(height: Resources.verticalDims.$16),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Profile Card ─────────────────────────────────────────────────────────────
//
// Card with:
//   - luxuryInputBg fill (surface-container-low #F3F4F5)
//   - 2px radius
//   - subtle elevation shadow
//   - 2px gold accent rule centred at the top edge

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        // Gold accent rule at top-center
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 64.w,
              height: 2,
              decoration: BoxDecoration(
                color: Resources.colors.luxuryGold,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Field Label ───────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        fontFamily: 'Manrope',
        fontSize: Resources.fontSizes.$10,
        fontWeight: Resources.fontWeights.bold,
        letterSpacing: Resources.letterSpacing.$1_0,
        color: Resources.colors.luxuryGold,
      ),
    );
  }
}

// ── Luxury Icon Text Field ────────────────────────────────────────────────────
//
// Filled text field with:
//   - luxuryProgressTrack fill (#E7E8E9 = surface-container-high)
//   - 2px bottom border: transparent → gold on focus → red on error
//   - Leading icon in on-surface-variant colour
//   - Error message below

class _LuxuryIconTextField extends StatefulWidget {
  const _LuxuryIconTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.focusNode,
    this.nextFocus,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.error,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final String? error;
  final ValueChanged<String>? onChanged;

  @override
  State<_LuxuryIconTextField> createState() => _LuxuryIconTextFieldState();
}

class _LuxuryIconTextFieldState extends State<_LuxuryIconTextField> {
  late final FocusNode _effectiveFocus;

  @override
  void initState() {
    super.initState();
    _effectiveFocus = widget.focusNode ?? FocusNode();
    // Trigger rebuild on focus change so fillColor can update with error state
    _effectiveFocus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _effectiveFocus.removeListener(_onFocusChange);
    if (widget.focusNode == null) _effectiveFocus.dispose();
    super.dispose();
  }

  UnderlineInputBorder _border(Color color) => UnderlineInputBorder(
    borderSide: BorderSide(color: color, width: 2),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(Resources.radius.$r2),
      topRight: Radius.circular(Resources.radius.$r2),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final hasError = widget.error != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          focusNode: _effectiveFocus,
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.nextFocus != null
              ? TextInputAction.next
              : TextInputAction.done,
          onChanged: widget.onChanged,
          onSubmitted: (_) => widget.nextFocus?.requestFocus(),
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: Resources.fontSizes.$16,
            color: Resources.colors.luxuryInk,
            fontWeight: Resources.fontWeights.regular,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: Resources.colors.luxuryPlaceholder),
            filled: true,
            fillColor: hasError
                ? Resources.colors.luxuryError.withValues(alpha: 0.04)
                : Resources.colors.luxuryProgressTrack,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Resources.horizontalDims.$12,
              ),
              child: Icon(
                widget.icon,
                size: Resources.iconSizes.$18,
                color: hasError
                    ? Resources.colors.luxuryError
                    : Resources.colors.luxuryBody,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(),
            contentPadding: EdgeInsets.symmetric(
              vertical: Resources.verticalDims.$14,
              horizontal: Resources.horizontalDims.$4,
            ),
            enabledBorder: _border(
              hasError ? Resources.colors.luxuryError : Colors.transparent,
            ),
            focusedBorder: _border(
              hasError
                  ? Resources.colors.luxuryError
                  : Resources.colors.luxuryGoldLight,
            ),
            disabledBorder: _border(Colors.transparent),
            errorBorder: _border(Resources.colors.luxuryError),
            focusedErrorBorder: _border(Resources.colors.luxuryError),
          ),
        ),
        if (hasError) ...[
          SizedBox(height: Resources.verticalDims.$4),
          Text(
            widget.error!,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: Resources.fontSizes.$12,
              color: Resources.colors.luxuryError,
            ),
          ),
        ],
      ],
    );
  }
}

// ── Language Selector ─────────────────────────────────────────────────────────

class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector({required this.selected, required this.onChanged});

  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Row(
      children: [
        Expanded(
          child: _LanguageOption(
            label: l10n.profileSetupLanguageEn,
            value: 'en',
            selected: selected,
            onTap: onChanged,
          ),
        ),
        SizedBox(width: Resources.horizontalDims.$12),
        Expanded(
          child: _LanguageOption(
            label: l10n.profileSetupLanguageAr,
            value: 'ar',
            selected: selected,
            onTap: onChanged,
          ),
        ),
      ],
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String value;
  final String selected;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == value;

    return GestureDetector(
      onTap: () => onTap(value),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: Resources.verticalDims.$12),
        decoration: BoxDecoration(
          color: isSelected
              ? Resources.colors.luxurySurface
              : Resources.colors.luxuryProgressTrack,
          borderRadius: BorderRadius.circular(Resources.radius.$r2),
          border: Border.all(
            color: isSelected
                ? Resources.colors.luxuryBorder
                : Colors.transparent,
          ),
          boxShadow: isSelected ? AppShadows.card : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected) ...[
              Icon(
                Icons.check_circle,
                size: Resources.iconSizes.$16,
                color: Resources.colors.luxuryGold,
              ),
              SizedBox(width: Resources.horizontalDims.$6),
            ] else ...[
              Icon(
                Icons.language,
                size: Resources.iconSizes.$16,
                color: Resources.colors.luxuryBody,
              ),
              SizedBox(width: Resources.horizontalDims.$6),
            ],
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: Resources.fontSizes.$14,
                fontWeight: isSelected
                    ? Resources.fontWeights.semiBold
                    : Resources.fontWeights.regular,
                color: isSelected
                    ? Resources.colors.luxuryInk
                    : Resources.colors.luxuryBody,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Enter Acrova Button ───────────────────────────────────────────────────────

class _EnterAcrovaButton extends StatelessWidget {
  const _EnterAcrovaButton({required this.isLoading, required this.onPressed});

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Resources.verticalDims.$55,
      decoration: BoxDecoration(
        color: Resources.colors.luxuryNavy,
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
        boxShadow: AppShadows.cta,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Resources.radius.$r2),
          onTap: isLoading ? null : onPressed,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Resources.colors.white,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'ENTER ACROVA',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: Resources.fontSizes.$12,
                          fontWeight: Resources.fontWeights.bold,
                          letterSpacing: Resources.letterSpacing.$1_4,
                          color: Resources.colors.white,
                        ),
                      ),
                      SizedBox(width: Resources.horizontalDims.$8),
                      Icon(
                        Icons.arrow_forward,
                        size: Resources.iconSizes.$18,
                        color: Resources.colors.white,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// ── Terms Text ────────────────────────────────────────────────────────────────

class _TermsText extends StatelessWidget {
  const _TermsText();

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "By continuing you agree to Acrova's ",
        style: TextStyle(
          fontFamily: 'Manrope',
          fontSize: Resources.fontSizes.$12,
          color: Resources.colors.luxuryBodyMuted,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: 'Terms',
            style: TextStyle(color: Resources.colors.luxuryGoldLight),
          ),
          const TextSpan(text: ' · '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(color: Resources.colors.luxuryGoldLight),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

// ── Page Footer ───────────────────────────────────────────────────────────────

class _PageFooter extends StatelessWidget {
  const _PageFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FooterLink(label: 'Terms of Service'),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Resources.horizontalDims.$8,
              ),
              child: Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: Resources.colors.luxuryPlaceholder,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            _FooterLink(label: 'Privacy Policy'),
          ],
        ),
        SizedBox(height: Resources.verticalDims.$8),
        Text(
          '© 2024 Acrova Portfolio. All rights reserved.',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: Resources.fontSizes.$10,
            color: Resources.colors.luxuryBodyMuted,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Manrope',
          fontSize: Resources.fontSizes.$12,
          color: Resources.colors.luxuryGold,
          fontWeight: Resources.fontWeights.medium,
        ),
      ),
    );
  }
}
