import 'package:acrova/presentation/features/ui/auth/phone_input/phone_input_cubit.dart';
import 'package:acrova/presentation/features/ui/auth/phone_input/widgets/phone_input_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneInputPage extends StatelessWidget {
  const PhoneInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhoneInputCubit(),
      child: const PhoneInputView(),
    );
  }
}
