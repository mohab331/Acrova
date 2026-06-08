import 'package:acrova/data/models/dashboard/dashboard_data_model.dart';
import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/presentation/features/common_widgets/cards/app_card.dart';
import 'package:acrova/presentation/features/common_widgets/chips/app_status_chip.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_empty_state.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_error_state.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_skeleton_loader.dart';
import 'package:acrova/presentation/features/common_widgets/layout/app_section_header.dart';
import 'package:acrova/presentation/features/cubit/dashboard/dashboard_cubit.dart';
import 'package:acrova/presentation/features/cubit/dashboard/dashboard_state.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().fetchDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      bottomPadding: 0,
      child: BlocBuilder<DashboardCubit, DashboardCubitState>(
        builder: (context, state) {
          if (state.isLoading || state.cubitStatus == CubitStatus.initial) {
            return const _DashboardSkeleton();
          }
          if (state.isError) {
            return AppErrorState(
              message:
                  state.appErrorModel?.message ??
                  'Failed to load dashboard data.',
              onRetry: () =>
                  context.read<DashboardCubit>().fetchDashboardData(),
            );
          }
          final data = state.data;
          if (data == null) return const SizedBox.shrink();
          return _DashboardContent(data: data);
        },
      ),
    );
  }
}

// ─── Content ────────────────────────────────────────────────────────────────

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({required this.data});

  final DashboardDataModel data;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return RefreshIndicator(
      color: Resources.colors.luxuryGoldLight,
      onRefresh: () => context.read<DashboardCubit>().fetchDashboardData(),
      child: Column(
        children: [
          AvatarHeader(
            userName: data.userName,
            notificationCount: data.notificationCount,
            avatarUrl: data.avatarUrl,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Hero banner ───────────────────────────────────────────────
                  const _HeroBanner(),
                  SizedBox(height: Resources.verticalDims.$32),

                  // ── Your Projects ─────────────────────────────────────────────
                  AppSectionHeader(
                    title: loc.dashboardYourProjects,
                    actionLabel: loc.dashboardViewAll,
                    onActionTap: () =>
                        context.go(AppRouteEnum.projectsPage.path),
                    bottomSpacing: Resources.verticalDims.$16,
                  ),

                  if (data.recentProjects.isEmpty)
                    AppEmptyState(
                      icon: Icons.folder_open_outlined,
                      title: 'No projects yet',
                      subtitle: 'Start your first project to see it here.',
                      ctaLabel: 'NEW PROJECT',
                      onCtaTap: () =>
                          context.push(AppRouteEnum.projectCreationPage.path),
                    )
                  else
                    Column(
                      children: data.recentProjects
                          .map(
                            (p) => Padding(
                              padding: EdgeInsets.only(
                                bottom: Resources.verticalDims.$12,
                              ),
                              child: _ProjectCardItem(project: p),
                            ),
                          )
                          .toList(),
                    ),

                  SizedBox(height: Resources.verticalDims.$20),

                  // ── Quick Actions ─────────────────────────────────────────────
                  Text(
                    loc.dashboardQuickActions,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: Resources.colors.luxuryNavy,
                      fontSize: AppTextTokens.sectionTitle,
                      fontWeight: Resources.fontWeights.semiBold,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$16),
                  _QuickActionsGrid(),
                  SizedBox(height: Resources.verticalDims.$32),

                  // ── Explore Designs ───────────────────────────────────────────
                  AppSectionHeader(
                    title: loc.dashboardExploreDesigns,
                    actionLabel: loc.dashboardGallery,
                    onActionTap: () {
                      context.goNamed(AppRouteEnum.portfolioPage.name);
                    },
                    bottomSpacing: Resources.verticalDims.$16,
                  ),
                  _DesignGallery(designs: data.exploreDesigns),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Header ─────────────────────────────────────────────────────────────────

class AvatarHeader extends StatelessWidget {
  const AvatarHeader({
    required this.userName,
    required this.notificationCount,
    this.avatarUrl,
  });

  final String userName;
  final int notificationCount;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _Avatar(
                avatarUrl:
                    'https://png.pngtree.com/png-vector/20231019/ourmid/pngtree-user-profile-avatar-png-image_10211467.png',
                userName: userName,
              ),
              SizedBox(width: Resources.horizontalDims.$12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.dashboardWelcome.toUpperCase(),
                    style: context.textTheme.titleLarge?.copyWith(
                      fontSize: 12.sp,
                      letterSpacing: 0.1,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$2),
                  Text(
                    userName,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: Resources.colors.luxuryInk,
                      fontWeight: Resources.fontWeights.semiBold,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          _NotificationBell(count: notificationCount),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({this.avatarUrl, required this.userName});

  final String? avatarUrl;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.r,
      height: 42.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Resources.colors.luxuryNavy,
        border: Border.all(
          color: Resources.colors.luxuryGoldBorder,
          width: 1.5,
        ),
      ),
      child: avatarUrl != null
          ? ClipOval(
              child: AppCachedNetworkImage(
                imageUrl: avatarUrl!,
                fit: BoxFit.cover,
              ),
            )
          : Center(
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : 'A',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: Resources.fontSizes.$16,
                  fontWeight: Resources.fontWeights.bold,
                  color: Resources.colors.luxuryGoldLight,
                ),
              ),
            ),
    );
  }
}

class _NotificationBell extends StatelessWidget {
  const _NotificationBell({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.notifications_outlined,
            color: Resources.colors.luxuryInk,
            size: Resources.iconSizes.$24,
          ),
        ),
        if (count > 0)
          Positioned(
            top: -4,
            right: -0.2,
            child: Container(
              width: 16.r,
              height: 16.r,
              decoration: BoxDecoration(
                color: Resources.colors.luxuryError,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  count > 9 ? '9+' : '$count',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: Resources.fontSizes.$8,
                    fontWeight: Resources.fontWeights.extraBold,
                    color: Resources.colors.luxurySurface,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ─── Hero Banner ────────────────────────────────────────────────────────────

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRouteEnum.projectCreationPage.path),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(Resources.horizontalDims.$24),
        decoration: BoxDecoration(
          color: Resources.colors.luxuryNavy,
          borderRadius: BorderRadius.circular(Resources.radius.$r16),
          boxShadow: AppShadows.hero,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Vision',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: Resources.colors.luxurySurface,
                    fontWeight: Resources.fontWeights.semiBold,
                    height: 1.4,
                  ),
                ),
                Text(
                  'Fully Realised',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: Resources.colors.luxuryGold,
                    fontWeight: Resources.fontWeights.semiBold,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: Resources.verticalDims.$20),
                const _HeroCta(),
              ],
            ),
            Positioned(
              right: -8,
              bottom: -8,
              child: Icon(
                Icons.architecture,
                size: 80.sp,
                color: Resources.colors.luxurySurface.withOpacity(0.06),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCta extends StatelessWidget {
  const _HeroCta();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRouteEnum.projectCreationPage.path),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Resources.horizontalDims.$16,
          vertical: Resources.verticalDims.$10,
        ),
        decoration: BoxDecoration(
          color: Resources.colors.luxuryGoldLight,
          borderRadius: BorderRadius.circular(Resources.radius.$r12),
        ),
        child: Text(
          context.localization.dashboardStartProject,
          style: TextStyle(
            fontSize: Resources.fontSizes.$10,
            fontWeight: Resources.fontWeights.semiBold,
            letterSpacing: Resources.letterSpacing.$1_4,
            color: Resources.colors.white,
          ),
        ),
      ),
    );
  }
}

// ─── Project Card ────────────────────────────────────────────────────────────

class _ProjectCardItem extends StatelessWidget {
  const _ProjectCardItem({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    print('object: ${project.thumbnailUrl}');
    return AppCard(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail placeholder
          Container(
            width: 56.r,
            height: 56.r,
            decoration: BoxDecoration(
              color: Resources.colors.luxuryNavy,
              borderRadius: BorderRadius.circular(Resources.radius.$r8),
            ),

            child: AppCachedNetworkImage(imageUrl: project.thumbnailUrl ?? ''),
          ),
          SizedBox(width: Resources.horizontalDims.$12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        project.name,
                        style: context.textTheme.titleSmall?.copyWith(
                          color: Resources.colors.luxuryInk,
                          fontWeight: Resources.fontWeights.semiBold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: Resources.horizontalDims.$8),
                    AppStatusChip(status: project.status),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$4),
                Text(
                  project.id,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: Resources.fontSizes.$10,
                    fontWeight: Resources.fontWeights.medium,
                    letterSpacing: Resources.letterSpacing.$n0_4,
                    color: Resources.colors.luxuryBody,
                  ),
                ),
                if (project.location != null) ...[
                  SizedBox(height: Resources.verticalDims.$2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: Resources.iconSizes.$14,
                        color: Resources.colors.luxuryBodyMuted,
                      ),
                      SizedBox(width: Resources.horizontalDims.$2),
                      Expanded(
                        child: Text(
                          project.location!,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: Resources.fontSizes.$10,
                            color: Resources.colors.luxuryBodyMuted,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: Resources.verticalDims.$12),
                // Progress bar
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Resources.radius.$r4,
                        ),
                        child: LinearProgressIndicator(
                          value: project.progressRatio,
                          backgroundColor: Resources.colors.luxuryProgressTrack,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Resources.colors.luxuryGoldLight,
                          ),
                          minHeight: 4,
                        ),
                      ),
                    ),
                    SizedBox(width: Resources.horizontalDims.$8),
                    Text(
                      project.progressLabel,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: Resources.fontSizes.$10,
                        fontWeight: Resources.fontWeights.bold,
                        color: Resources.colors.luxuryGoldLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Quick Actions ───────────────────────────────────────────────────────────

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  @override
  Widget build(BuildContext context) {
    final loc = context.localization;

    final actions = [
      _QuickAction(
        icon: Icons.add_circle_outline,
        label: loc.dashboardActionNewProject,
        onTap: () => context.push(AppRouteEnum.projectCreationPage.path),
      ),
      _QuickAction(
        icon: Icons.headset_mic_outlined,
        label: loc.dashboardActionSupport,
        onTap: () => context.go(AppRouteEnum.messagesPage.path),
      ),
      _QuickAction(
        icon: Icons.receipt_long_outlined,
        label: loc.dashboardActionUploadReceipt,
        onTap: () {},
      ),
      _QuickAction(
        icon: Icons.edit_document,
        label: loc.dashboardActionRevision,
        onTap: () {},
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Resources.horizontalDims.$12,
        mainAxisSpacing: Resources.verticalDims.$12,
        childAspectRatio: 2.8,
      ),
      itemCount: actions.length,
      itemBuilder: (_, i) => _QuickActionCard(action: actions[i]),
    );
  }
}

class _QuickAction {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({required this.action});

  final _QuickAction action;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$12,
        vertical: Resources.verticalDims.$10,
      ),
      onTap: action.onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            action.icon,
            color: Resources.colors.luxuryGoldLight,
            size: Resources.iconSizes.$20,
          ),
          SizedBox(width: Resources.horizontalDims.$8),
          Flexible(
            child: Text(
              action.label,
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: Resources.fontWeights.bold,
                color: Resources.colors.luxuryInk,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Design Gallery ──────────────────────────────────────────────────────────

class _DesignGallery extends StatelessWidget {
  const _DesignGallery({required this.designs});

  final List<DesignModel> designs;

  @override
  Widget build(BuildContext context) {
    if (designs.isEmpty) return const SizedBox.shrink();

    final featured = designs.first;
    final rest = designs.skip(1).toList();

    return Column(
      children: [
        // Featured design card
        _DesignCard(design: featured, height: 170),
        if (rest.isNotEmpty) ...[
          SizedBox(height: Resources.verticalDims.$12),
          Row(
            children: rest
                .take(2)
                .map(
                  (d) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: d == rest.first && rest.length > 1
                            ? Resources.horizontalDims.$6
                            : 0,
                        left: d != rest.first ? Resources.horizontalDims.$6 : 0,
                      ),
                      child: _DesignCard(design: d, height: 140),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }
}

class _DesignCard extends StatelessWidget {
  const _DesignCard({required this.design, required this.height});

  final DesignModel design;
  final double height;

  @override
  Widget build(BuildContext context) {
    final hasAsset = design.imageAsset != null;
    final hasUrl = design.imageUrl != null;

    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Resources.radius.$r12),
        child: Stack(
          children: [
            // Image background
            SizedBox(
              height: height.h,
              width: double.infinity,
              child: hasAsset
                  ? Image.asset(
                      design.imageAsset!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          _DesignCardPlaceholder(height: height),
                    )
                  : hasUrl
                  ? AppCachedNetworkImage(
                      imageUrl: design.imageUrl!,
                      fit: BoxFit.cover,
                      radius: Resources.radius.$r12,
                    )
                  : _DesignCardPlaceholder(height: height),
            ),
            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Resources.colors.luxuryInk.withOpacity(0.72),
                    ],
                    stops: const [0.4, 1.0],
                  ),
                ),
              ),
            ),
            // Labels
            Positioned(
              bottom: Resources.verticalDims.$12,
              left: Resources.horizontalDims.$12,
              right: Resources.horizontalDims.$12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    design.styleTag.toUpperCase(),
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: Resources.fontSizes.$8,
                      fontWeight: Resources.fontWeights.extraBold,
                      letterSpacing: Resources.letterSpacing.$1_2,
                      color: Resources.colors.luxuryGoldLight,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$3),
                  Text(
                    design.title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: Resources.fontSizes.$14,
                      fontWeight: Resources.fontWeights.semiBold,
                      color: Resources.colors.luxurySurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DesignCardPlaceholder extends StatelessWidget {
  const _DesignCardPlaceholder({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      color: Resources.colors.luxuryNavy,
      child: Icon(
        Icons.architecture,
        size: 48.sp,
        color: Resources.colors.luxuryGoldLight.withOpacity(0.3),
      ),
    );
  }
}

// ─── Skeleton ────────────────────────────────────────────────────────────────

class _DashboardSkeleton extends StatelessWidget {
  const _DashboardSkeleton();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Resources.verticalDims.$20),
          // Header skeleton
          Row(
            children: [
              SkeletonBox(width: 42.r, height: 42.r, radius: 42),
              SizedBox(width: Resources.horizontalDims.$12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(width: 60.w, height: 10.h),
                  SizedBox(height: Resources.verticalDims.$4),
                  SkeletonBox(width: 100.w, height: 16.h),
                ],
              ),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$24),
          // Banner skeleton
          SkeletonBox(width: double.infinity, height: 130.h, radius: 16),
          SizedBox(height: Resources.verticalDims.$32),
          SkeletonBox(width: 120.w, height: 18.h),
          SizedBox(height: Resources.verticalDims.$16),
          SkeletonBox(width: double.infinity, height: 100.h, radius: 8),
          SizedBox(height: Resources.verticalDims.$12),
          SkeletonBox(width: double.infinity, height: 100.h, radius: 8),
          SizedBox(height: Resources.verticalDims.$32),
          SkeletonBox(width: 120.w, height: 18.h),
          SizedBox(height: Resources.verticalDims.$16),
          Row(
            children: [
              Expanded(
                child: SkeletonBox(
                  width: double.infinity,
                  height: 60.h,
                  radius: 8,
                ),
              ),
              SizedBox(width: Resources.horizontalDims.$12),
              Expanded(
                child: SkeletonBox(
                  width: double.infinity,
                  height: 60.h,
                  radius: 8,
                ),
              ),
            ],
          ),
          SizedBox(height: Resources.verticalDims.$12),
          Row(
            children: [
              Expanded(
                child: SkeletonBox(
                  width: double.infinity,
                  height: 60.h,
                  radius: 8,
                ),
              ),
              SizedBox(width: Resources.horizontalDims.$12),
              Expanded(
                child: SkeletonBox(
                  width: double.infinity,
                  height: 60.h,
                  radius: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
