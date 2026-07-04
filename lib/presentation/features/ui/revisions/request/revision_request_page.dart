import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/data/data_source/local/services/image_picker/base_image_picker_service.dart';
import 'package:acrova/domain/repository/revisions/base_revisions_repo.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_error_state.dart';
import 'package:acrova/presentation/features/ui/revisions/request/cubit/revision_request_cubit.dart';
import 'package:acrova/presentation/features/ui/revisions/request/cubit/revision_request_state.dart';
import 'package:acrova/presentation/features/ui/revisions/request/widgets/revision_request_form.dart';
import 'package:acrova/presentation/features/ui/revisions/request/widgets/revision_request_skeleton.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RevisionRequestPage extends StatelessWidget {
  const RevisionRequestPage({super.key});

  static const _deliverables = [
    'Floor Plan v1.1 — Main Residence',
    'Exterior Renderings v2',
    'Interior Moodboard v1',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RevisionRequestCubit(
        revisionsRepo: serviceLocatorInstance<BaseRevisionsRepo>(),
        imagePicker: serviceLocatorInstance<BaseImagePickerService>(),
      )..fetchQuota(),
      child: const _RevisionRequestView(deliverables: _deliverables),
    );
  }
}

class _RevisionRequestView extends StatefulWidget {
  const _RevisionRequestView({required this.deliverables});

  final List<String> deliverables;

  @override
  State<_RevisionRequestView> createState() => _RevisionRequestViewState();
}

class _RevisionRequestViewState extends State<_RevisionRequestView> {
  final _detailsController = TextEditingController();

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return BlocListener<RevisionRequestCubit, RevisionRequestState>(
      listenWhen: (p, c) => p.createdRevision != c.createdRevision,
      listener: (context, state) {
        if (state.createdRevision != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.revisionSubmitSuccess),
              backgroundColor: Resources.colors.luxurySuccess,
            ),
          );
          Navigator.of(context).pop(state.createdRevision);
        }
      },
      child: CommonScreen(
        padding: EdgeInsets.zero,
        resizeToAvoidBottomInset: false,
        appBar: AppAuthBrandHeader(label: l10n.revisionRequestTitle,showBack: true,),
        child: BlocBuilder<RevisionRequestCubit, RevisionRequestState>(
          builder: (context, state) {
            if ( state.isLoading || state.cubitStatus == CubitStatus.initial) {
              return const RevisionRequestSkeleton();
            }
            if (state.isError || state.quota == null) {
              return AppErrorState(
                message: state.appErrorModel?.message ?? '',
                onRetry: () =>
                    context.read<RevisionRequestCubit>().fetchQuota(),
              );
            }
            return RevisionRequestForm(
              state: state,
              detailsController: _detailsController,
              deliverables: widget.deliverables,
            );
          },
        ),
      ),
    );
  }
}
