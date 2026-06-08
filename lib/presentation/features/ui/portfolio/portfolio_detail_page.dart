import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/buttons/app_primary_button.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/presentation/features/ui/portfolio/portfolio_item.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/media_query_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
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
        fontSize: 18.sp,
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
                      _Carousel(
                        imageUrls: widget.item.imageUrls,
                        controller: _pageController,
                        onPageChanged: (i) => setState(() => _currentPage = i),
                      ),
                      // Top gradient for button visibility
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
                                colors: [
                                  Color(0x99000615), // 60%
                                  Color(0x00000615),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Dot indicators
                      if (widget.item.imageUrls.length > 1)
                        Positioned(
                          bottom: 56.h,
                          left: 0,
                          right: 0,
                          child: _DotIndicators(
                            count: widget.item.imageUrls.length,
                            currentIndex: _currentPage,
                          ),
                        ),
                    ],
                  ),
                ),
                // Content panel slides up 24dp over the carousel
                Transform.translate(
                  offset: Offset(0, -24.h),
                  child: _ContentPanel(item: widget.item),
                ),
              ],
            ),
          ),

          // ── Fixed bottom CTAs ───────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomCTAs(
              onStartProject: () =>
                  context.push(AppRouteEnum.projectCreationPage.path),
              onWatchWalkthrough: () {

              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Carousel ───────────────────────────────────────────────────────────────────

class _Carousel extends StatelessWidget {
  const _Carousel({
    required this.imageUrls,
    required this.controller,
    required this.onPageChanged,
  });

  final List<String> imageUrls;
  final PageController controller;
  final void Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: onPageChanged,
      itemCount: imageUrls.length,
      itemBuilder: (_, index) => AppCachedNetworkImage(
        imageUrl: imageUrls[index],
        fit: BoxFit.cover,
        radius: 0,
      ),
    );
  }
}

// ── Dot indicators ─────────────────────────────────────────────────────────────

class _DotIndicators extends StatelessWidget {
  const _DotIndicators({required this.count, required this.currentIndex});

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 8.r,
          height: 8.r,
          margin: EdgeInsets.symmetric(horizontal: 4.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? Resources.colors.luxuryGold
                : Resources.colors.white.withOpacity(0.5),
          ),
        );
      }),
    );
  }
}

// ── Content panel ──────────────────────────────────────────────────────────────

class _ContentPanel extends StatelessWidget {
  const _ContentPanel({required this.item});

  final PortfolioItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000615),
            blurRadius: 30,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 12.h),
          // Drag handle indicator
          Center(
            child: Container(
              width: 48.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Resources.colors.luxuryInputBorder,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 120.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Style tag
                Text(
                  item.style.toUpperCase(),
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: Resources.fontSizes.$10,
                    fontWeight: Resources.fontWeights.extraBold,
                    color: Resources.colors.luxuryGoldLight,
                    letterSpacing: Resources.letterSpacing.$1_2,
                  ),
                ),
                SizedBox(height: 8.h),
                // Title
                Text(
                  item.title,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: Resources.fontSizes.$18,
                    fontWeight: Resources.fontWeights.semiBold,
                    color: Resources.colors.luxuryNavy,
                    height: 1.25,
                  ),
                ),
                SizedBox(height: 8.h),
                // Metadata dots
                Row(
                  children: [
                    _MetaDot(text: item.location),
                    _DotSeparator(),
                    _MetaDot(text: item.area),
                    _DotSeparator(),
                    _MetaDot(text: item.floors),
                  ],
                ),
                SizedBox(height: 32.h),
                // Narrative
                Text(
                  context.localization.portfolioNarrative,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: Resources.fontSizes.$18,
                    fontWeight: Resources.fontWeights.semiBold,
                    color: Resources.colors.luxuryNavy,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  item.narrative,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: Resources.fontSizes.$14,
                    fontWeight: Resources.fontWeights.regular,
                    color: Resources.colors.luxuryBody,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 32.h),
                // Specifications
                Text(
                  context.localization.portfolioSpecifications,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: Resources.fontSizes.$18,
                    fontWeight: Resources.fontWeights.semiBold,
                    color: Resources.colors.luxuryNavy,
                  ),
                ),
                SizedBox(height: 16.h),
                _SpecGrid(item: item),
                SizedBox(height: 24.h),
                // Key features
                Text(
                  context.localization.portfolioKeyFeatures,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: Resources.fontSizes.$18,
                    fontWeight: Resources.fontWeights.semiBold,
                    color: Resources.colors.luxuryNavy,
                  ),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: item.features
                      .map((f) => _FeatureChip(label: f))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaDot extends StatelessWidget {
  const _MetaDot({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.labelMedium?.copyWith(
        fontSize: Resources.fontSizes.$11,
        fontWeight: Resources.fontWeights.medium,
        color: Resources.colors.luxuryBodyMuted,
      ),
    );
  }
}

class _DotSeparator extends StatelessWidget {
  const _DotSeparator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Container(
        width: 4.r,
        height: 4.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Resources.colors.luxuryPlaceholder.withOpacity(0.5),
        ),
      ),
    );
  }
}

// ── Specifications 2×2 grid ────────────────────────────────────────────────────

class _SpecGrid extends StatelessWidget {
  const _SpecGrid({required this.item});
  final PortfolioItem item;

  @override
  Widget build(BuildContext context) {
    final specs = [
      (context.localization.specArea, item.area),
      (context.localization.specFloors, item.floors),
      (context.localization.specStyle, item.style),
      (context.localization.specLocation, item.location),
    ];
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      childAspectRatio: 2.4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: specs.map((s) => _SpecCell(label: s.$1, value: s.$2)).toList(),
    );
  }
}

class _SpecCell extends StatelessWidget {
  const _SpecCell({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Resources.colors.luxuryInputBg,
        borderRadius: BorderRadius.circular(Resources.radius.$r4),
        border: Border.all(
          color: Resources.colors.luxuryPlaceholder.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label.toUpperCase(),
            style: context.textTheme.labelSmall?.copyWith(
              fontSize: Resources.fontSizes.$10,
              fontWeight: Resources.fontWeights.semiBold,
              color: Resources.colors.luxuryBody,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: context.textTheme.labelLarge?.copyWith(
              fontSize: Resources.fontSizes.$12,
              fontWeight: Resources.fontWeights.semiBold,
              color: Resources.colors.luxuryNavy,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ── Feature chip ───────────────────────────────────────────────────────────────

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Resources.colors.luxuryProgressTrack, // #E7E8E9
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Text(
        label,
        style: context.textTheme.labelMedium?.copyWith(
          fontSize: Resources.fontSizes.$11,
          fontWeight: Resources.fontWeights.semiBold,
          color: Resources.colors.luxuryNavy,
        ),
      ),
    );
  }
}

// ── Bottom CTAs ────────────────────────────────────────────────────────────────

class _BottomCTAs extends StatelessWidget {
  const _BottomCTAs({
    required this.onStartProject,
    required this.onWatchWalkthrough,
  });

  final VoidCallback onStartProject;
  final VoidCallback onWatchWalkthrough;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface.withOpacity(0.92),
        border: Border(top: BorderSide(color: Resources.colors.luxuryInputBg)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onStartProject,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Resources.colors.luxuryNavy,
                    borderRadius: BorderRadius.circular(Resources.radius.$r12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.localization.portfolioCtaStartProject,
                        style: TextStyle(
                          fontSize: Resources.fontSizes.$12,
                          fontWeight: Resources.fontWeights.bold,
                          color: Resources.colors.white,
                          letterSpacing: Resources.letterSpacing.$0_8,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.arrow_forward,
                        size: Resources.iconSizes.$18,
                        color: Resources.colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: onWatchWalkthrough,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_circle,
                        size: Resources.iconSizes.$16,
                        color: Resources.colors.luxuryGoldLight,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        context.localization.portfolioCtaWatchWalkthrough,
                        style: TextStyle(
                          fontSize: Resources.fontSizes.$12,
                          fontWeight: Resources.fontWeights.bold,
                          color: Resources.colors.luxuryGoldLight,
                          letterSpacing: Resources.letterSpacing.$0_8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}