import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/features/ui/auth/identity_verification/identity_verification_content.dart';
import 'package:acrova/presentation/features/ui/auth/identity_verification/widgets/cubit/otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdentityVerificationPage extends StatefulWidget {
  const IdentityVerificationPage({required this.args, super.key});

  final AuthFlowArgs? args;

  @override
  State<IdentityVerificationPage> createState() =>
      _IdentityVerificationPageState();
}

class _IdentityVerificationPageState extends State<IdentityVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OTPCubit>(
      create: (context) => OTPCubit(),
      child: IdentityVerificationContent(args: widget.args),
    );
  }
}
