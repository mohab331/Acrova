import 'package:acrova/presentation/features/ui/contact_us/contact_us_content.dart';
import 'package:acrova/presentation/features/ui/contact_us/cubit/contact_us_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsArgs {
  final String? email;
  final String? mobileNumber;

  ContactUsArgs({
    this.email,
    this.mobileNumber,
  });
}

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({required this.args, super.key});

  final ContactUsArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactUsCubit(
        email: args.email ?? '',
        mobileNumber: args.mobileNumber ?? '',
      ),
      child: const ContactUsContent(),
    );
  }
}



