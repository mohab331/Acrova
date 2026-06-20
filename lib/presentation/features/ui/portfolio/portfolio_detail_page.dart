import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/ui/portfolio/portfolio_item.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/detail_bottom_ctas.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/detail_carousel.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/detail_content_panel.dart';
import 'package:acrova/presentation/features/ui/portfolio/widgets/detail_dot_indicators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PortfolioDetailPage extends StatefulWidget {
  const PortfolioDetailPage({required this.item, super.key});

  final PortfolioItem item;

  @override
  State<PortfolioDetailPage> createState() => _PortfolioDetailPageState();
}

class _PortfolioDetailPageState extends State<PortfolioDetailPage> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heroHeight = MediaQuery.of(context).size.height * 0.4;

    return CommonScreen(
      padding: EdgeInsets.zero,
      appBar: AppAuthBrandHeader(
        showBack: true,
        label: widget.item.title,
        fontSize: Resources.fontSizes.$18,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: heroHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      DetailCarousel(
                        imageUrls: widget.item.imageUrls,
                        controller: _pageController,
                        onPageChanged: (i) =>
                            setState(() => _currentPage = i),
                      ),
                      const Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          height: 128,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: AppGradients.detailHeaderScrim,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (widget.item.imageUrls.length > 1)
                        Positioned(
                          bottom: Resources.verticalDims.$55,
                          left: 0,
                          right: 0,
                          child: DetailDotIndicators(
                            count: widget.item.imageUrls.length,
                            currentIndex: _currentPage,
                          ),
                        ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -Resources.verticalDims.$24),
                  child: DetailContentPanel(item: widget.item),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DetailBottomCtas(
              onStartProject: () =>
                  context.push(AppRouteEnum.projectCreationPage.path),
              onWatchWalkthrough: () {},
            ),
          ),
        ],
      ),
    );
  }
}
