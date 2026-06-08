import 'package:acrova/data/models/project/create_project_request.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_state.dart';
import 'package:acrova/utils/extensions/localization_extension.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Step4DesignPreferences extends StatefulWidget {
  const Step4DesignPreferences({super.key});

  @override
  State<Step4DesignPreferences> createState() => _Step4DesignPreferencesState();
}

class _Step4DesignPreferencesState extends State<Step4DesignPreferences> {
  late final TextEditingController _notesCtrl;

  @override
  void initState() {
    super.initState();
    _notesCtrl = TextEditingController(
      text: context.read<ProjectCreationCubit>().state.additionalNotes,
    );
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
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
        final cubit = context.read<ProjectCreationCubit>();
        final l10n = context.localization;

        return SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                l10n.designPreferencesTitle,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: Resources.colors.luxuryNavy,
                  fontWeight: Resources.fontWeights.semiBold,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                l10n.designPreferencesSubtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Resources.colors.luxuryBody,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$32),

              Text(
                l10n.designPreferencesLabelStyle,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Resources.colors.luxuryBody,
                ),
              ),
              SizedBox(height: Resources.verticalDims.$12),

              // Style chips
              Wrap(
                spacing: Resources.horizontalDims.$10,
                runSpacing: Resources.verticalDims.$10,
                children: DesignStyle.all.map((style) {
                  final isSelected = state.stylePreference == style;
                  return GestureDetector(
                    onTap: () => cubit.selectStyle(style),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: EdgeInsets.symmetric(
                        horizontal: Resources.horizontalDims.$18,
                        vertical: Resources.verticalDims.$10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Resources.colors.luxuryNavy
                            : Resources.colors.luxurySurface,
                        borderRadius: BorderRadius.circular(Resources.radius.$r8),
                        border: Border.all(
                          color: isSelected
                              ? Resources.colors.luxuryNavy
                              : Resources.colors.luxuryBorder,
                        ),
                        boxShadow: AppShadows.card,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSelected) ...[
                            Icon(
                              Icons.check,
                              size: Resources.iconSizes.$14,
                              color: Resources.colors.luxuryGoldOnDark,
                            ),
                            SizedBox(width: Resources.horizontalDims.$6),
                          ],
                          Text(
                            _getStyleLabel(context, style),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: Resources.fontSizes.$14,
                                  fontWeight: isSelected
                                      ? Resources.fontWeights.semiBold
                                      : Resources.fontWeights.medium,
                                  color: isSelected
                                      ? Resources.colors.luxurySurface
                                      : Resources.colors.luxuryInk,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: Resources.verticalDims.$28),

              Text(
                l10n.designPreferencesLabelNotes,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Resources.colors.luxuryBody,
                    ),
              ),
              SizedBox(height: Resources.verticalDims.$8),
              Text(
                l10n.designPreferencesSubtitleNotes,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Resources.colors.luxuryBodyMuted,
                    ),
              ),
              SizedBox(height: Resources.verticalDims.$12),

              Container(
                decoration: BoxDecoration(
                  color: Resources.colors.luxuryInputBg,
                  borderRadius: BorderRadius.circular(Resources.radius.$r2),
                  border: Border.all(color: Resources.colors.luxuryInputBorder),
                ),
                child: TextField(
                  controller: _notesCtrl,
                  maxLines: 5,
                  minLines: 4,
                  onChanged: cubit.updateNotes,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Resources.colors.luxuryInk,

                    fontSize: Resources.fontSizes.$15,
                  ),
                  decoration: InputDecoration(
                    hintText: l10n.designPreferencesHintNotes,
                    hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Resources.colors.luxuryPlaceholder,
                    ),
                    contentPadding: EdgeInsets.all(Resources.horizontalDims.$16),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Resources.radius.$r2),
                      borderSide: BorderSide(
                        color: Resources.colors.luxuryGoldLight,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: InputBorder.none,
                  ),
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
