import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/features/ui/project_creation/cubit/project_creation_cubit.dart';
import 'package:acrova/presentation/features/ui/project_creation/widgets/project_creation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectCreationPage extends StatelessWidget {
  const ProjectCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocatorInstance<ProjectCreationCubit>(),
      child: const ProjectCreationView(),
    );
  }
}
