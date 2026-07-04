import 'package:acrova/data/models/project/create_project_request.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_state.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/review_row.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/review_section.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/sbc_summary_warning.dart';
import 'package:acrova/utils/enums/project_type_enum.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Step6ReviewSubmit extends StatelessWidget {
  const Step6ReviewSubmit({super.key});

  String _getProjectTypeName(BuildContext context, ProjectType? type) {
    if (type == null) return '—';
    final l10n = context.localization;
    return switch (type) {
      ProjectType.villa => l10n.projectTypeVillaLabel,
      ProjectType.houseApartment => l10n.projectTypeHouseApartmentLabel,
      ProjectType.commercial => l10n.projectTypeCommercialLabel,
    };
  }

  String _getStyleLabel(BuildContext context, String key) {
    final l10n = context.localization;
    return switch (key) {
      DesignStyle.modern => l10n.designStyleModern,
      DesignStyle.classic => l10n.designStyleClassic,
      DesignStyle.contemporary => l10n.designStyleContemporary,
      DesignStyle.minimalist => l10n.designStyleMinimalist,
      DesignStyle.neoClassical => l10n.designStyleNeoClassical,
      _ => key,
    };
  }
  
  String _getSmartHomeLabel(BuildContext context, String key) {
    final l10n = context.localization;
    return switch (key) {
      'basic' => l10n.requirementsSmartHomeBasic,
      'intermediate' => l10n.requirementsSmartHomeIntermediate,
      'advanced' => l10n.requirementsSmartHomeAdvanced,
      _ => key,
    };
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCreationCubit, ProjectCreationState>(
      builder: (context, state) {
        final l10n = context.localization;
        final isRtl = context.isRtl;
        final isCommercial = state.selectedType == ProjectType.commercial;

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
                style: context.textTheme.bodyMedium?.copyWith(color: Resources.colors.luxuryBody),
              ),
              SizedBox(height: Resources.verticalDims.$32),
              ReviewSection(
                title: l10n.stepProjectType.toUpperCase(),
                stepIndex: 0,
                rows: [ReviewRow(label: l10n.reviewLabelType, value: _getProjectTypeName(context, state.selectedType))],
              ),
              SizedBox(height: Resources.verticalDims.$16),
              ReviewSection(
                title: l10n.stepLandDetails.toUpperCase(),
                stepIndex: 1,
                rows: [
                  ReviewRow(label: l10n.reviewLabelLocation, value: state.location.isEmpty ? '—' : state.location),
                  ReviewRow(
                    label: l10n.reviewLabelArea,
                    value: state.landAreaSqm != null
                        ? '${state.landAreaSqm!.toStringAsFixed(0)} ${isRtl ? 'م²' : 'm²'}'
                        : '—',
                  ),
                  if (isCommercial)
                    ReviewRow(label: l10n.reviewLabelEmployees, value: '${state.employeeCount}')
                  else
                    ReviewRow(
                      label: l10n.reviewLabelWidthLength,
                      value: (state.landWidthM != null && state.landLengthM != null)
                          ? '${state.landWidthM!.toStringAsFixed(0)} ${isRtl ? 'م' : 'm'} × ${state.landLengthM!.toStringAsFixed(0)} ${isRtl ? 'م' : 'm'}'
                          : '—',
                    ),
                  ReviewRow(label: l10n.reviewLabelFloors, value: '${state.floors}'),
                ],
              ),
              SizedBox(height: Resources.verticalDims.$16),
              ReviewSection(
                title: l10n.stepRequirements.toUpperCase(),
                stepIndex: 2,
                rows: [
                  if (!isCommercial) ...[
                    ReviewRow(label: l10n.reviewLabelBedrooms, value: '${state.bedrooms}'),
                    ReviewRow(label: l10n.reviewLabelBathrooms, value: '${state.bathrooms}'),
                  ],
                  ReviewRow(label: l10n.reviewLabelExtras, value: _buildExtras(context, state)),
                  ReviewRow(label: l10n.reviewLabelSmartHome, value: _getSmartHomeLabel(context, state.smartHomeLevel)),
                ],
              ),
              SizedBox(height: Resources.verticalDims.$16),
              ReviewSection(
                title: l10n.stepDesign.toUpperCase(),
                stepIndex: 3,
                rows: [
                  ReviewRow(
                    label: l10n.reviewLabelStyle,
                    value: state.architecturalStyle.isEmpty ? '—' : _getStyleLabel(context, state.architecturalStyle),
                  ),
                  if (state.additionalNotes.isNotEmpty)
                    ReviewRow(label: l10n.reviewLabelNotes, value: state.additionalNotes),
                ],
              ),
              SizedBox(height: Resources.verticalDims.$16),
              ReviewSection(
                title: l10n.stepMedia.toUpperCase(),
                stepIndex: 4,
                rows: [
                  ReviewRow(
                    label: l10n.reviewLabelPhotos,
                    value: state.mediaPaths.isEmpty
                        ? l10n.reviewLabelNoneAdded
                        : state.mediaPaths.length == 1
                            ? '1 ${l10n.reviewPhotosCountSingular}'
                            : '${state.mediaPaths.length} ${l10n.reviewPhotosCountPlural}',
                  ),
                ],
              ),
              if (state.hasSbcWarnings) ...[
                SizedBox(height: Resources.verticalDims.$20),
                const SbcSummaryWarning(),
              ],
              SizedBox(height: Resources.verticalDims.$32),
              Container(
                padding: EdgeInsets.all(Resources.horizontalDims.$16),
                decoration: BoxDecoration(
                  color: Resources.colors.luxuryNavy.withValues(alpha: 0.04),
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
}
