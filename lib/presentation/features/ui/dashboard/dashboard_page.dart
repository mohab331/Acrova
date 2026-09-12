import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/ui/dashboard/cubit/dashboard_cubit.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_content.dart';
import 'package:acrova/presentation/features/ui/portfolio/cubit/portfolio_cubit.dart';
import 'package:acrova/presentation/features/ui/projects/cubit/projects_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocatorInstance<DashboardCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              serviceLocatorInstance<ProjectsCubit>()..fetchProjects(),
        ),
        BlocProvider(
          create: (context) =>
              serviceLocatorInstance<PortfolioCubit>()..fetchPortfolio(),
        ),
      ],
      child: const CommonScreen(bottomPadding: 0, child: DashboardContent()),
    );
  }
}
