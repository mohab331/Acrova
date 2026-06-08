import 'package:acrova/data/models/project/create_project_request.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_state.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Step6ReviewSubmit extends StatelessWidget {
  const Step6ReviewSubmit({super.key});

  String _getProjectTypeName(BuildContext context, ProjectType? type) {
    if (type == null) return '—';
    final l10n = context.localization;
    switch (type) {
      case ProjectType.residentialVilla:
        return l10n.projectTypeVillaLabel;
      case ProjectType.commercialBuilding:
        return l10n.projectTypeCommercialLabel;
      case ProjectType.mixedUse:
        return l10n.projectTypeMixedUseLabel;
    }
  }

  String _getStyleLabel(BuildContext context, String key) {
    final l10n = context.localization;
    switch (key) {
      case DesignStyle.modern:
        return l10n.designStyleModern;
      case DesignStyle.classic:
        return l10n.designStyleClassic;
      case DesignStyle.contemporary:
        return l10n.designStyleContemporary;
      case DesignStyle.minimalist:
        return l10n.designStyleMinimalist;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCreationCubit, ProjectCreationState>(
      builder: (context, state) {
        final l10n = context.localization;
        final isRtl = context.isRtl;

        return SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                l10n.reviewSubmitTitle,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: Resources.colors.luxuryNavy,
                  fontWeight: Resources.fontWeights.semiBold,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                l10n.reviewSubmitSubtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Resources.colors.luxuryBody,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$32),

              // ── Project Type ────────────────────────────────────────────
              _ReviewSection(
                title: l10n.stepProjectType.toUpperCase(),
                stepIndex: 0,
                rows: [
                  _ReviewRow(
                    label: l10n.reviewLabelType,
                    value: _getProjectTypeName(context, state.selectedType),
                  ),
                ],
              ),
              SizedBox(height: Resources.verticalDims.$16),

              // ── Land Details ────────────────────────────────────────────
              _ReviewSection(
                title: l10n.stepLandDetails.toUpperCase(),
                stepIndex: 1,
                rows: [
                  _ReviewRow(
                    label: l10n.reviewLabelLocation,
                    value: state.location.isEmpty ? '—' : state.location,
                  ),
                  _ReviewRow(
                    label: l10n.reviewLabelArea,
                    value: state.landAreaSqm != null
                        ? '${state.landAreaSqm!.toStringAsFixed(0)} ${isRtl ? 'م²' : 'm²'}'
                        : '—',
                  ),
                  _ReviewRow(
                    label: l10n.reviewLabelWidthLength,
                    value: (state.landWidthM != null && state.landLengthM != null)
                        ? '${state.landWidthM!.toStringAsFixed(0)} ${isRtl ? 'م' : 'm'} × ${state.landLengthM!.toStringAsFixed(0)} ${isRtl ? 'م' : 'm'}'
                        : '—',
                  ),
                  _ReviewRow(
                    label: l10n.reviewLabelFloors,
                    value: '${state.floors}',
                  ),
                ],
              ),
              SizedBox(height: Resources.verticalDims.$16),

              // ── Building Requirements ────────────────────────────────────
              _ReviewSection(
                title: l10n.stepRequirements.toUpperCase(),
                stepIndex: 2,
                rows: [
                  _ReviewRow(
                    label: l10n.reviewLabelBedrooms,
                    value: '${state.bedrooms}',
                  ),
                  _ReviewRow(
                    label: l10n.reviewLabelBathrooms,
                    value: '${state.bathrooms}',
                  ),
                  _ReviewRow(
                    label: l10n.reviewLabelExtras,
                    value: _buildExtras(context, state),
                  ),
                ],
              ),
              SizedBox(height: Resources.verticalDims.$16),

              // ── Design Preferences ───────────────────────────────────────
              _ReviewSection(
                title: l10n.stepDesign.toUpperCase(),
                stepIndex: 3,
                rows: [
                  _ReviewRow(
                    label: l10n.reviewLabelStyle,
                    value: state.stylePreference.isEmpty
                        ? '—'
                        : _getStyleLabel(context, state.stylePreference),
                  ),
                  if (state.additionalNotes.isNotEmpty)
                    _ReviewRow(
                      label: l10n.reviewLabelNotes,
                      value: state.additionalNotes,
                    ),
                ],
              ),
              SizedBox(height: Resources.verticalDims.$16),

              // ── Media ────────────────────────────────────────────────────
              _ReviewSection(
                title: l10n.stepMedia.toUpperCase(),
                stepIndex: 4,
                rows: [
                  _ReviewRow(
                    label: l10n.reviewLabelPhotos,
                    value: state.mediaPaths.isEmpty
                        ? l10n.reviewLabelNoneAdded
                        : state.mediaPaths.length == 1
                            ? '1 ${l10n.reviewPhotosCountSingular}'
                            : '${state.mediaPaths.length} ${l10n.reviewPhotosCountPlural}',
                  ),
                ],
              ),

              // ── SBC Warnings ─────────────────────────────────────────────
              if (state.hasSbcWarnings) ...[
                SizedBox(height: Resources.verticalDims.$20),
                const _SbcSummaryWarning(),
              ],

              SizedBox(height: Resources.verticalDims.$32),

              // ── Terms notice ─────────────────────────────────────────────
              Container(
                padding: EdgeInsets.all(Resources.horizontalDims.$16),
                decoration: BoxDecoration(
                  color: Resources.colors.luxuryNavy.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(Resources.radius.$r8),
                  border: Border.all(color: Resources.colors.luxuryBorder),
                ),
                child: Text(
                  l10n.reviewSubmitAgreement,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Resources.colors.luxuryBodyMuted,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$24),
            ],
          ),
        );
      },
    );
  }

  String _buildExtras(BuildContext context, ProjectCreationState state) {
    final l10n = context.localization;
    final extras = <String>[];
    if (state.hasMajlis) extras.add(l10n.requirementsSpaceMajlis);
    if (state.hasMaidRoom) extras.add(l10n.requirementsSpaceMaid);
    if (state.hasDriverRoom) extras.add(l10n.requirementsSpaceDriver);
    if (state.hasBasement) extras.add(l10n.requirementsSpaceBasement);
    if (state.hasPool) extras.add(l10n.requirementsSpacePool);
    if (state.hasRooftop) extras.add(l10n.requirementsSpaceRooftop);
    return extras.isEmpty ? l10n.reviewLabelNone : extras.join(', ');
  }
}

// ─── Review Section ──────────────────────────────────────────────────────────

class _ReviewSection extends StatelessWidget {
  const _ReviewSection({
    required this.title,
    required this.stepIndex,
    required this.rows,
  });

  final String title;
  final int stepIndex;
  final List<_ReviewRow> rows;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Container(
      padding: EdgeInsets.all(Resources.horizontalDims.$16),
      decoration: BoxDecoration(
        color: Resources.colors.luxurySurface,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(color: Resources.colors.luxuryBorder),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Resources.colors.luxuryGoldLight,
                    ),
              ),
              GestureDetector(
                onTap: () => context
                    .read<ProjectCreationCubit>()
                    .goToStep(stepIndex),
                child: Container(
                  padding: const EdgeInsets.all(
                    8,
                  ),
                  decoration: BoxDecoration(
                    color: Resources.colors.luxuryGoldLight
                        .withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(
                      Resources.radius.$r10,
                    ),
                    border: Border.all(
                      color: Resources.colors.luxuryGoldLight
                          .withValues(alpha: .18),
                    ),
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    size: Resources.iconSizes.$14,
                    color: Resources.colors.luxuryGoldLight,
                  ),
                ),
              ),
            ],
          ),
          Divider(color: Resources.colors.luxuryGoldBorder,),
          SizedBox(height: Resources.verticalDims.$12),
          ...rows.map(
            (r) => Padding(
              padding: EdgeInsets.only(bottom: Resources.verticalDims.$8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      r.label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: Resources.fontSizes.$12,
                            color: Resources.colors.luxuryBodyMuted,
                          ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    r.value,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: Resources.fontSizes.$12,
                          fontWeight: Resources.fontWeights.semiBold,
                          color: Resources.colors.luxuryInk,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewRow {
  const _ReviewRow({required this.label, required this.value});

  final String label;
  final String value;
}

// ─── SBC Summary Warning ──────────────────────────────────────────────────────

class _SbcSummaryWarning extends StatelessWidget {
  const _SbcSummaryWarning();

  @override
  Widget build(BuildContext context) {
    final l10n = context.localization;

    return Container(
      padding: EdgeInsets.all(Resources.horizontalDims.$16),
      decoration: BoxDecoration(
        color: Resources.colors.luxuryWarning.withOpacity(0.08),
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        border: Border.all(
          color: Resources.colors.luxuryWarning.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Resources.colors.luxuryWarning,
            size: Resources.iconSizes.$20,
          ),
          SizedBox(width: Resources.horizontalDims.$10),
          Expanded(
            child: Text(
              l10n.reviewSbcWarning,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Resources.colors.luxuryWarning,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
