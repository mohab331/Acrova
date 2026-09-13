import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/data/data_source/local/services/image_picker/base_image_picker_service.dart';
import 'package:acrova/domain/repository/project/base_project_repo.dart';
import 'package:acrova/presentation/features/ui/project_creation/cubit/project_creation_cubit.dart';
import 'package:acrova/presentation/features/ui/project_creation/widgets/project_creation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectCreationPage extends StatelessWidget {
  const ProjectCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectCreationCubit(
        projectRepo: serviceLocatorInstance<BaseProjectRepo>(),
        imagePicker: serviceLocatorInstance<BaseImagePickerService>(),
      ),
      child: const ProjectCreationView(),
    );
  }
}
