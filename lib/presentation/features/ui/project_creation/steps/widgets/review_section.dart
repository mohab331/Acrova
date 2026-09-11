import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/project_creation/project_creation_cubit.dart';
import 'package:acrova/presentation/features/ui/project_creation/steps/widgets/review_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({
    required this.title,
    required this.stepIndex,
    required this.rows,
    super.key,
  });

  final String title;
  final int stepIndex;
  final List<ReviewRow> rows;

  @override
  Widget build(BuildContext context) {
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
                onTap: () =>
                    context.read<ProjectCreationCubit>().goToStep(stepIndex),
                child: Container(
                  padding: EdgeInsets.all(Resources.horizontalDims.$8),
                  decoration: BoxDecoration(
                    color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(Resources.radius.$r10),
                    border: Border.all(
                      color: Resources.colors.luxuryGoldLight.withValues(alpha: 0.18),
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
          Divider(color: Resources.colors.luxuryGoldBorder),
          SizedBox(height: Resources.verticalDims.$12),
          ...rows.map(
            (r) => Padding(
              padding: EdgeInsets.only(bottom: Resources.verticalDims.$8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Resources.horizontalDims.$100,
                    child: Text(
                      r.label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: Resources.fontSizes.$12,
                            color: Resources.colors.luxuryBodyMuted,
                          ),
                    ),
                  ),
                  const Spacer(),
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
