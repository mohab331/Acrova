import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/presentation/features/cubit/interior_design/interior_design_cubit.dart';
import 'package:acrova/presentation/features/ui/interior_design/widgets/interior_design_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InteriorDesignPage extends StatelessWidget {
  const InteriorDesignPage({
    required this.projectId,
    super.key,
  });

  final String projectId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InteriorDesignCubit(
        projectRepo: serviceLocatorInstance<BaseProjectRepo>(),
        projectId: projectId,
      ),
      child: InteriorDesignView(projectId: projectId),
    );
  }
}
