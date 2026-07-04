import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_error_state.dart';
import 'package:acrova/presentation/features/cubit/dashboard/dashboard_cubit.dart';
import 'package:acrova/presentation/features/cubit/dashboard/dashboard_state.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_content.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_skeleton.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocatorInstance<DashboardCubit>()..fetchDashboardData(),
      child: CommonScreen(
        bottomPadding: 0,
        child:
            BlocSelector<
              DashboardCubit,
              DashboardCubitState,
              ({bool isLoading, CubitStatus status, bool isError})
            >(
              selector: (state) => (
                isLoading: state.isLoading,
                status: state.cubitStatus,
                isError: state.isError,
              ),
              builder: (context, selection) {
                if (selection.isLoading ||
                    selection.status == CubitStatus.initial) {
                  return const DashboardSkeleton();
                }
                if (selection.isError) {
                  final state = context.read<DashboardCubit>().state;
                  return AppErrorState(
                    message: state.appErrorModel?.message ?? '',
                    onRetry: () =>
                        context.read<DashboardCubit>().fetchDashboardData(),
                  );
                }

                return BlocBuilder<DashboardCubit, DashboardCubitState>(
                  builder: (context, state) {
                    if (state.data == null) return const SizedBox.shrink();
                    return DashboardContent(data: state.data!);
                  },
                );
              },
            ),
      ),
    );
  }
}
