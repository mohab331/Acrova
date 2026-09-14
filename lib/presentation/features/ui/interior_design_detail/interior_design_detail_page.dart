import 'package:acrova/core/di/dependency_injector.dart';
import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_error_widget.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/common_shimmer_loading.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/presentation/features/ui/interior_design_detail/cubit/interior_design_detail_cubit.dart';
import 'package:acrova/presentation/features/ui/interior_design_detail/cubit/interior_design_detail_state.dart';
import 'package:acrova/presentation/features/ui/interior_design_detail/widgets/interior_design_bottom_cta.dart';
import 'package:acrova/presentation/features/ui/interior_design_detail/widgets/interior_design_content_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InteriorDesignDetailPage extends StatelessWidget {
  const InteriorDesignDetailPage({this.args, super.key});

  final InteriorDesignDetailArgs? args;

  @override
  Widget build(BuildContext context) {
    final id = args?.id ?? args?.interiorDesign?.id;
    final title =
        args?.interiorDesign?.title ??
        args?.interiorDesign?.referenceNumber ??
        '';

    return BlocProvider(
      create: (context) =>
          serviceLocatorInstance<InteriorDesignDetailCubit>()
            ..fetchInteriorDesign(id: id),
      child: CommonScreen(
        padding: EdgeInsets.zero,
        appBar: AppAuthBrandHeader(label: title, showBack: true),
        backGroundColor: Resources.colors.white,
        child: const _InteriorDesignDetailView(),
      ),
    );
  }
}

class _InteriorDesignDetailView extends StatelessWidget {
  const _InteriorDesignDetailView();

  @override
  Widget build(BuildContext context) {
    final heroHeight = MediaQuery.of(context).size.height * 0.4;
    final cubit = context.read<InteriorDesignDetailCubit>();

    return BlocBuilder<InteriorDesignDetailCubit, InteriorDesignDetailState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CommonShimmerLoading(isDetail: true);
        }
        if (state.isError) {
          return CommonErrorWidget(
            error: state.appErrorModel,
            onRetry: cubit.fetchInteriorDesign,
          );
        }

        final item = state.item;
        return RefreshIndicator(
          color: Resources.colors.luxuryGoldLight,
          onRefresh: cubit.fetchInteriorDesign,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: heroHeight,
                        child: AppCachedNetworkImage(
                          imageUrl: item?.thumbnailUrl ?? '',
                          width: double.infinity,
                          radius: 0,
                          openInViewerOnTap: true,
                          viewerTitle: item?.title,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -Resources.verticalDims.$24),
                        child: InteriorDesignContentSheet(item: item),
                      ),
                    ],
                  ),
                ),
              ),
              InteriorDesignBottomCta(item: item),
            ],
          ),
        );
      },
    );
  }
}
