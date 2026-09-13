import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/domain/repository/contact_us/base_contact_us_repo.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/features/ui/contact_us/contact_us_content.dart';
import 'package:acrova/presentation/features/ui/contact_us/cubit/contact_us_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:acrova/presentation/app/navigation/args/navigation_args.dart'
    show ContactUsArgs;

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({this.args, super.key});

  final ContactUsArgs? args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactUsCubit(
        contactUsRepo: serviceLocatorInstance<BaseContactUsRepo>(),
        email: args?.email ?? '',
        mobileNumber: args?.mobileNumber ?? '',
      ),
      child: const ContactUsContent(),
    );
  }
}
