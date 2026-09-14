import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/features/ui/auth/phone_input/cubit/phone_input_cubit.dart';
import 'package:acrova/presentation/features/ui/auth/phone_input/widgets/phone_input_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneInputPage extends StatelessWidget {
  const PhoneInputPage({this.args, super.key});

  final AuthFlowArgs? args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhoneInputCubit>(
      create: (context) => PhoneInputCubit(),
      child: PhoneInputView(args: args),
    );
  }
}
