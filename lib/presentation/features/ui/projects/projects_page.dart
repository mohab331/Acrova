import 'package:acrova/data/models/project/project_model.dart';
import 'package:acrova/presentation/app/navigation/app_route_enum.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/app_bar/app_auth_brand_header.dart';
import 'package:acrova/presentation/features/common_widgets/common_screen/common_screen.dart';
import 'package:acrova/presentation/features/common_widgets/images/app_cached_network_image.dart';
import 'package:acrova/presentation/features/common_widgets/chips/app_status_chip.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_empty_state.dart';
import 'package:acrova/presentation/features/common_widgets/feedback/app_error_state.dart';
import 'package:acrova/presentation/features/cubit/dashboard/dashboard_cubit.dart';
import 'package:acrova/presentation/features/cubit/dashboard/dashboard_state.dart';
import 'package:acrova/presentation/features/cubit/projects/projects_cubit.dart';
import 'package:acrova/presentation/features/cubit/projects/projects_state.dart';
import 'package:acrova/presentation/features/ui/dashboard/dashboard_page.dart';
import 'package:acrova/utils/enums/cubit_status.dart';
import 'package:acrova/utils/enums/project_status_enum.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

// ── Filter enum ───────────────────────────────────────────────────────────────

enum _ProjectFilter { all, active, completed }

// ── Page ──────────────────────────────────────────────────────────────────────

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  _ProjectFilter _filter = _ProjectFilter.all;

  @override
  void initState() {
    super.initState();
    context.read<ProjectsCubit>().fetchProjects();
  }

  List<ProjectModel> _applyFilter(List<ProjectModel> all) {
    switch (_filter) {
      case _ProjectFilter.all:
        return all;
      case _ProjectFilter.active:
        return all.where((p) => !p.status.isTerminal).toList();
      case _ProjectFilter.completed:
        return all.where((p) => p.status.isTerminal).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      bottomPadding: 0,
      child: Column(
        children: [
          const AvatarHeader(userName: 'Mohab', notificationCount: 2),
          Expanded(
            child: BlocBuilder<ProjectsCubit, ProjectsCubitState>(
              builder: (context, state) {
                if (state.isLoading ||
                    state.cubitStatus == CubitStatus.initial) {
                  return const _ProjectsSkeleton();
                }

                if (state.isError) {
                  return AppErrorState(
                    message:
                        state.appErrorModel?.message ??
                        'Failed to load projects.',
                    onRetry: () =>
                        context.read<ProjectsCubit>().fetchProjects(),
                  );
                }

                final filtered = _applyFilter(state.projects ?? []);

                return RefreshIndicator(
                  color: Resources.colors.luxuryGoldLight,
                  onRefresh: () =>
                      context.read<ProjectsCubit>().fetchProjects(),
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: _SectionHeader(
                          filter: _filter,
                          onFilterChanged: (f) => setState(() => _filter = f),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 20.h)),

                      // ── Content ─────────────────────────────────────
                      if (filtered.isEmpty)
                        SliverFillRemaining(
                          child: AppEmptyState(
                            icon: Icons.folder_open_outlined,
                            title: 'No Projects Yet',
                            subtitle:
                                'Start your first project and\ntrack its progress here.',
                            ctaLabel: 'NEW PROJECT',
                            onCtaTap: () => context.push(
                              AppRouteEnum.projectCreationPage.path,
                            ),
                          ),
                        )
                      else ...[
                        // Remaining standard cards
                        if (filtered.length > 1)
                          SliverList.separated(
                            itemCount: filtered.length - 1,
                            separatorBuilder: (_, __) =>
                                SizedBox(height: Resources.verticalDims.$16),
                            itemBuilder: (_, i) =>
                                _StandardProjectCard(project: filtered[i + 1]),
                          ),

                        SliverToBoxAdapter(child: SizedBox(height: 32.h)),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.filter, required this.onFilterChanged});

  final _ProjectFilter filter;
  final ValueChanged<_ProjectFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Manage Your Developments',
          style: context.textTheme.titleMedium?.copyWith(
            color: Resources.colors.luxuryNavy,
            fontWeight: Resources.fontWeights.semiBold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Track progress, monitor updates, and manage all active projects in one premium workspace.',
          style: context.textTheme.labelMedium?.copyWith(
            color: Resources.colors.luxuryBodyMuted,
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            FiltersChip(
              label: 'All',
              active: filter == _ProjectFilter.all,
              onTap: () => onFilterChanged(_ProjectFilter.all),
            ),
            SizedBox(width: Resources.horizontalDims.$8),
            FiltersChip(
              label: 'Active',
              active: filter == _ProjectFilter.active,
              onTap: () => onFilterChanged(_ProjectFilter.active),
            ),
            SizedBox(width: Resources.horizontalDims.$8),
            FiltersChip(
              label: 'Completed',
              active: filter == _ProjectFilter.completed,
              onTap: () => onFilterChanged(_ProjectFilter.completed),
            ),
          ],
        ),
      ],
    );
  }
}

class FiltersChip extends StatelessWidget {
  const FiltersChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: active
              ? Resources.colors.luxuryNavy
              : Resources.colors.luxuryInputBg,
          borderRadius: BorderRadius.circular(8.r),
          border: active
              ? null
              : Border.all(color: Resources.colors.luxuryBorder),
        ),

        child: Text(
          label,
          style: TextStyle(
            fontSize: Resources.fontSizes.$12,
            fontWeight: Resources.fontWeights.semiBold,
            color: active
                ? Resources.colors.white
                : Resources.colors.luxuryBody,
          ),
        ),
      ),
    );
  }
}

// ── Featured Project Card ─────────────────────────────────────────────────────
// Hero card for the first project — image on top, content below.

class _FeaturedProjectCard extends StatelessWidget {
  const _FeaturedProjectCard({required this.project});

  final ProjectModel project;

  bool get _showActiveBadge => !project.status.isTerminal;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(color: Resources.colors.luxuryBorder),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0x0A191C1D),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Stack(
            children: [
              _ProjectImage(thumbnailUrl: project.thumbnailUrl, height: 192.h),

              // Bottom gradient
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 80.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Resources.colors.luxuryInk.withValues(alpha: 0.6),
                      ],
                    ),
                  ),
                ),
              ),

              // Active Phase badge (top-right)
              if (_showActiveBadge)
                Positioned(top: 12.h, right: 12.w, child: _ActivePhaseBadge()),
            ],
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(Resources.horizontalDims.$20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ID + status row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      project.id,
                      style: context.textTheme.labelMedium?.copyWith(
                        fontSize: Resources.fontSizes.$12,
                        fontWeight: Resources.fontWeights.medium,
                        color: Resources.colors.luxuryBody,
                      ),
                    ),
                    AppStatusChip(status: project.status),
                  ],
                ),

                SizedBox(height: Resources.verticalDims.$8),

                // Title
                Text(
                  project.name,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontSize: Resources.fontSizes.$20,
                    fontWeight: Resources.fontWeights.bold,
                    color: Resources.colors.luxuryNavy,
                  ),
                ),

                SizedBox(height: Resources.verticalDims.$6),

                // Description / type + location
                Text(
                  _buildDescription(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: Resources.fontSizes.$14,
                    color: Resources.colors.luxuryBody,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: Resources.verticalDims.$20),

                // Progress
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Completion',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: Resources.fontSizes.$12,
                        color: Resources.colors.luxuryBody,
                      ),
                    ),
                    Text(
                      project.progressLabel,
                      style: context.textTheme.labelLarge?.copyWith(
                        fontSize: Resources.fontSizes.$14,
                        fontWeight: Resources.fontWeights.bold,
                        color: Resources.colors.luxuryInk,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Resources.verticalDims.$8),

                ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: LinearProgressIndicator(
                    value: project.progressRatio,
                    minHeight: 6,
                    backgroundColor: Resources.colors.luxuryProgressTrack,
                    valueColor: AlwaysStoppedAnimation(
                      Resources.colors.luxuryGoldLight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildDescription() {
    final parts = <String>[];
    parts.add(project.type.displayLabel);
    if (project.location != null) parts.add(project.location!);
    return parts.join(' · ');
  }
}

// ── Standard Project Card ─────────────────────────────────────────────────────
// Compact card for projects after the featured one.

class _StandardProjectCard extends StatelessWidget {
  const _StandardProjectCard({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(color: Resources.colors.luxuryBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          _ProjectImage(thumbnailUrl: project.thumbnailUrl, height: 160.h),

          // Content
          Padding(
            padding: EdgeInsets.all(Resources.horizontalDims.$16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ID + status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      project.id,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: Resources.fontSizes.$10,
                        fontWeight: Resources.fontWeights.medium,
                        color: Resources.colors.luxuryBodyMuted,
                      ),
                    ),
                    AppStatusChip(status: project.status),
                  ],
                ),

                SizedBox(height: Resources.verticalDims.$6),

                // Title
                Text(
                  project.name,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontSize: Resources.fontSizes.$16,
                    fontWeight: Resources.fontWeights.bold,
                    color: Resources.colors.luxuryInk,
                  ),
                ),

                SizedBox(height: Resources.verticalDims.$4),

                // Description
                Text(
                  project.type.displayLabel,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: Resources.fontSizes.$12,
                    color: Resources.colors.luxuryBody,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: Resources.verticalDims.$16),

                // Divider
                Divider(height: 1, color: Resources.colors.luxuryBorder),

                SizedBox(height: Resources.verticalDims.$12),

                // Progress
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Completion',
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: Resources.fontSizes.$10,
                        color: Resources.colors.luxuryInk,
                      ),
                    ),
                    Text(
                      project.progressLabel,
                      style: context.textTheme.labelLarge?.copyWith(
                        fontSize: Resources.fontSizes.$14,
                        fontWeight: Resources.fontWeights.bold,
                        color: Resources.colors.luxuryGold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Resources.verticalDims.$8),

                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: LinearProgressIndicator(
                    value: project.progressRatio,
                    minHeight: 4,
                    backgroundColor: Resources.colors.luxuryProgressTrack,
                    valueColor: AlwaysStoppedAnimation(
                      Resources.colors.luxuryGold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Project Image ─────────────────────────────────────────────────────────────

class _ProjectImage extends StatelessWidget {
  const _ProjectImage({this.thumbnailUrl, required this.height});

  final String? thumbnailUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (thumbnailUrl != null && thumbnailUrl!.isNotEmpty) {
      return AppCachedNetworkImage(
        imageUrl: thumbnailUrl!,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        radius: Resources.radius.$r0,
      );
    }
    return _Placeholder(height: height);
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Resources.colors.luxuryNavy, Resources.colors.luxuryInk],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.apartment_outlined,
          size: 48.r,
          color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

// ── Active Phase Badge ────────────────────────────────────────────────────────

class _ActivePhaseBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Resources.horizontalDims.$12,
        vertical: Resources.verticalDims.$6,
      ),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(Resources.radius.$r2),
        border: Border.all(
          color: Resources.colors.luxuryGold.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pulsing gold dot via animated opacity
          _PulsingDot(),
          SizedBox(width: Resources.horizontalDims.$6),
          Text(
            context.localization.activePhase,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: Resources.fontSizes.$10,
              fontWeight: Resources.fontWeights.bold,
              letterSpacing: Resources.letterSpacing.$0_8,
              color: Resources.colors.luxuryGold,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.4, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: 6.r,
        height: 6.r,
        decoration: BoxDecoration(
          color: Resources.colors.luxuryGold,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// ── Skeleton Loading ──────────────────────────────────────────────────────────

class _ProjectsSkeleton extends StatelessWidget {
  const _ProjectsSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        // Header shimmer
        SizedBox(height: Resources.verticalDims.$20),
        _SkeletonBox(width: 140.w, height: 28.h),
        SizedBox(height: Resources.verticalDims.$8),
        _SkeletonBox(width: 220.w, height: 16.h),
        SizedBox(height: Resources.verticalDims.$16),

        // Filter chips shimmer
        Row(
          children: [
            _SkeletonBox(width: 56.w, height: 34.h, radius: 100),
            SizedBox(width: Resources.horizontalDims.$8),
            _SkeletonBox(width: 68.w, height: 34.h, radius: 100),
            SizedBox(width: Resources.horizontalDims.$8),
            _SkeletonBox(width: 92.w, height: 34.h, radius: 100),
          ],
        ),

        SizedBox(height: Resources.verticalDims.$20),
        // Featured card skeleton
        _SkeletonCardLarge(),

        SizedBox(height: Resources.verticalDims.$16),

        // Standard card skeleton
        _SkeletonCardStandard(),

        SizedBox(height: Resources.verticalDims.$16),

        // CTA button shimmer
        _SkeletonBox(
          width: double.infinity,
          height: 52.h,
          radius: Resources.radius.$r2,
        ),
      ],
    );
  }
}

class _SkeletonCardLarge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(color: Resources.colors.luxuryBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SkeletonBox(width: double.infinity, height: 192.h, radius: 0),
          Padding(
            padding: EdgeInsets.all(Resources.horizontalDims.$20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _SkeletonBox(width: 100.w, height: 14.h),
                    _SkeletonBox(width: 80.w, height: 22.h),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$8),
                _SkeletonBox(width: 200.w, height: 24.h),
                SizedBox(height: Resources.verticalDims.$8),
                _SkeletonBox(width: double.infinity, height: 14.h),
                SizedBox(height: Resources.verticalDims.$4),
                _SkeletonBox(width: 0.75.sw, height: 14.h),
                SizedBox(height: Resources.verticalDims.$20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _SkeletonBox(width: 80.w, height: 14.h),
                    _SkeletonBox(width: 40.w, height: 14.h),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$8),
                _SkeletonBox(width: double.infinity, height: 6.h, radius: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonCardStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(color: Resources.colors.luxuryBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SkeletonBox(width: double.infinity, height: 160.h, radius: 0),
          Padding(
            padding: EdgeInsets.all(Resources.horizontalDims.$16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _SkeletonBox(width: 80.w, height: 12.h),
                    _SkeletonBox(width: 72.w, height: 20.h),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$8),
                _SkeletonBox(width: 160.w, height: 20.h),
                SizedBox(height: Resources.verticalDims.$6),
                _SkeletonBox(width: double.infinity, height: 12.h),
                SizedBox(height: Resources.verticalDims.$20),
                Divider(height: 1, color: Resources.colors.luxuryBorder),
                SizedBox(height: Resources.verticalDims.$12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _SkeletonBox(width: 72.w, height: 12.h),
                    _SkeletonBox(width: 36.w, height: 12.h),
                  ],
                ),
                SizedBox(height: Resources.verticalDims.$8),
                _SkeletonBox(width: double.infinity, height: 4.h, radius: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Skeleton Box ──────────────────────────────────────────────────────────────

class _SkeletonBox extends StatefulWidget {
  const _SkeletonBox({required this.width, required this.height, this.radius});

  final double width;
  final double height;
  final double? radius;

  @override
  State<_SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<_SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              widget.radius ?? Resources.radius.$r4,
            ),
            gradient: LinearGradient(
              begin: Alignment(-1 + 2 * _ctrl.value, 0),
              end: Alignment(-0.5 + 2 * _ctrl.value, 0),
              colors: [
                Resources.colors.luxuryProgressTrack,
                const Color(0xFFFFFFFF),
                Resources.colors.luxuryProgressTrack,
              ],
            ),
          ),
        );
      },
    );
  }
}
