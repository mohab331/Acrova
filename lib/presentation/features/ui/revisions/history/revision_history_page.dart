import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/ui/revisions/cubit/revisions/revisions_cubit.dart';
import 'package:acrova/presentation/features/ui/revisions/history/revision_history_content.dart';

import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RevisionHistoryPage extends StatelessWidget {
  const RevisionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return BlocProvider(
      create: (context) =>
          serviceLocatorInstance<RevisionsCubit>()..fetchRevisions(),
      child: CommonScreen(
        bottomPadding: 0,
        appBar: AppAuthBrandHeader(
          label: l10n.revisionHistoryTitle,
          showBack: true,
        ),
        child: const RevisionHistoryContent(),
      ),
    );
  }
}
