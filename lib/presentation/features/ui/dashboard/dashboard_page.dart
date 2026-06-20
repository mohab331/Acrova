import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_error_state.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_skeleton_loader.dart';
import 'package:acrova/presentation/features/cubit/dashboard/dashboard_cubit.dart';
import 'package:acrova/presentation/features/cubit/dashboard/dashboard_state.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_content.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_skeleton.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().fetchDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      bottomPadding: 0,
      child: BlocBuilder<DashboardCubit, DashboardCubitState>(
        builder: (context, state) {
          if (state.isLoading || state.cubitStatus == CubitStatus.initial) {
            return const DashboardSkeleton();
          }
          if (state.isError) {
            return AppErrorState(
              message: state.appErrorModel?.message ?? '',
              onRetry: () => context.read<DashboardCubit>().fetchDashboardData(),
            );
          }
          final data = state.data;
          if (data == null) return const SizedBox.shrink();
          return DashboardContent(data: data);
        },
      ),
    );
  }
}
