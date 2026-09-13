import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/presentation/features/cubit/auth/auth_cubit.dart';
import 'package:acrova/presentation/features/ui/profile/cubit/profile_cubit.dart';
import 'package:acrova/presentation/features/ui/profile/cubit/profile_state.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_content.dart';
import 'package:acrova/presentation/features/ui/profile/widgets/profile_skeleton.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AuthCubit>().getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    return BlocProvider(
      create: (context) => serviceLocatorInstance<ProfileCubit>(),
      child: CommonScreen(
        bottomPadding: 0,
        child: BlocBuilder<ProfileCubit, ProfileCubitState>(
          builder: (context, state) {
            if (authState.getUserCubitStatus == CubitStatus.loading) {
              return const ProfileSkeleton();
            }
            if (authState.getUserCubitStatus == CubitStatus.error) {
              return CommonErrorWidget(
                error: state.appErrorModel,
                onRetry: () => context.read<AuthCubit>().getUser(),
              );
            }
            final profile = authState.userModel;
            if (profile == null) return const SizedBox.shrink();

            return ProfileContent(profile: profile);
          },
        ),
      ),
    );
  }
}
