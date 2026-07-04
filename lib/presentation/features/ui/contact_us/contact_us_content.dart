import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/ui/contact_us/cubit/contact_us_cubit.dart';
import 'package:acrova/presentation/features/ui/contact_us/cubit/contact_us_state.dart';
import 'package:acrova/presentation/features/ui/contact_us/widgets/contact_channel_card.dart';
import 'package:acrova/presentation/features/ui/contact_us/widgets/contact_us_form.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:acrova/utils/helpers/launcher_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsContent extends StatefulWidget {
  const ContactUsContent({super.key});

  @override
  State<ContactUsContent> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsContent> {
  final _launcher = LauncherService();
  late final TextEditingController _emailController;
  late final TextEditingController _mobileController;

  final _detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final s = context.read<ContactUsCubit>().state;
    _emailController = TextEditingController(text: s.email);
    _mobileController = TextEditingController(text: s.mobileNumber);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _mobileController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return BlocListener<ContactUsCubit, ContactUsState>(
      listenWhen: (p, c) => p.cubitStatus != c.cubitStatus,
      listener: (context, state) {
        if (state.cubitStatus == CubitStatus.success) {
          _detailsController.clear();
          context.read<ContactUsCubit>().updateDetails('');
        }
      },
      child: CommonScreen(
        bottomPadding: 0,
        appBar: AppAuthBrandHeader(label: l10n.contactUsTitle, showBack: true),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get in Touch',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Resources.colors.luxuryNavy,
                        fontWeight: Resources.fontWeights.semiBold,
                      ),
                    ),
                    SizedBox(height: Resources.verticalDims.$4),
                    Text(
                      'We\'re here to help. Reach out with any questions, feedback, or support requests and our team will get back to you as soon as possible.',
                      style: context.textTheme.labelMedium?.copyWith(
                        color: Resources.colors.luxuryBodyMuted,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Resources.verticalDims.$32),
              _SectionLabel(text: l10n.contactUsInquirySection),
              SizedBox(height: Resources.verticalDims.$12),
              ContactUsForm(
                emailController: _emailController,
                mobileController: _mobileController,
                detailsController: _detailsController,
              ),
              SizedBox(height: Resources.verticalDims.$32),
              _SectionLabel(text: l10n.contactUsChannelsSection),
              SizedBox(height: Resources.verticalDims.$12),
              ContactChannelCard(
                icon: Icons.call_outlined,
                title: l10n.contactUsCallTitle,
                subtitle: l10n.contactUsCallNumber,
                onTap: () => _launcher.callNumber(l10n.contactUsCallNumber),
              ),
              SizedBox(height: Resources.verticalDims.$12),
              ContactChannelCard(
                icon: Icons.mail_outline,
                title: l10n.contactUsEmailTitle,
                subtitle: l10n.contactUsEmailAddress,
                onTap: () => _launcher.sendEmail(l10n.contactUsEmailAddress),
              ),
              SizedBox(height: Resources.verticalDims.$32),
            ],
          ),
        ),
      ),
    );
  }
}
class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$8),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontFamily: Resources.fonts.manrope,
          fontSize: Resources.fontSizes.$10,
          fontWeight: Resources.fontWeights.bold,
          letterSpacing: Resources.letterSpacing.$1_0,
          color: Resources.colors.luxuryBodyMuted,
        ),
      ),
    );
  }
}
