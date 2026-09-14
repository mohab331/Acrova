import 'package:acrova/data/models/response/interior_design/interior_design_response_model.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/utils/enums/interior_design_status_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InteriorDesignBottomCta extends StatelessWidget {
  const InteriorDesignBottomCta({required this.item, super.key});

  final InteriorDesignResponseModel? item;

  @override
  Widget build(BuildContext context) {
    final status = item?.status;
    final bool showCTA =
        status == InteriorDesignStatus.awaitingPayment ||
        status == InteriorDesignStatus.conceptReady ||
        status == InteriorDesignStatus.completed ||
        (item?.projectId != null && (item?.projectId?.isNotEmpty ?? false));

    if (!showCTA) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsetsDirectional.only(
        top: Resources.verticalDims.$16,
        start: Resources.horizontalDims.$24,
        end: Resources.horizontalDims.$24,
        bottom: Resources.verticalDims.$32,
      ),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        boxShadow: [
          BoxShadow(
            color: Resources.colors.luxuryInk.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: _CtaButton(item: item),
    );
  }
}

class _CtaButton extends StatelessWidget {
  const _CtaButton({required this.item});

  final InteriorDesignResponseModel? item;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    if (item?.status == InteriorDesignStatus.awaitingPayment) {
      return AppPrimaryButton(
        label: loc.interiorDesignActionPayNow,
        onPressed: () {
          context.push(AppRouteEnum.makePaymentPage.path);
        },
      );
    } else if (item?.status == InteriorDesignStatus.conceptReady) {
      return AppPrimaryButton(
        label: loc.interiorDesignActionReviewConcepts,
        onPressed: () {
          context.push(AppRouteEnum.walkthroughPage.path);
        },
      );
    } else if (item?.projectId != null &&
        (item?.projectId?.isNotEmpty ?? false)) {
      return AppPrimaryButton(
        label: loc.viewProject,
        onPressed: () {
          context.push(
            AppRouteEnum.projectDetailPage.path,
            extra: ProjectDetailArgs(
              id: item?.projectId,
              title: item?.projectName,
            ),
          );
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
