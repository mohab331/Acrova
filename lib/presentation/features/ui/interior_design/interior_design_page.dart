import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/features/ui/interior_design/cubit/interior_design_cubit.dart';
import 'package:acrova/presentation/features/ui/interior_design/widgets/interior_design_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InteriorDesignPage extends StatelessWidget {
  const InteriorDesignPage({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocatorInstance<InteriorDesignCubit>(),
      child: InteriorDesignView(projectId: projectId),
    );
  }
}
