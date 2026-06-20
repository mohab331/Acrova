import 'package:acrova/data/models/dashboard/dashboard_data_model.dart';
import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/ui/dashboard/widgets/dashboard_design_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardDesignGallery extends StatelessWidget {
  const DashboardDesignGallery({required this.designs, super.key});

  final List<DesignModel> designs;

  @override
  Widget build(BuildContext context) {
    if (designs.isEmpty) return const SizedBox.shrink();

    final featured = designs.first;
    final rest = designs.skip(1).toList();

    return Column(
      children: [
        DashboardDesignCard(design: featured, height: 170),
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
                      child: DashboardDesignCard(design: d, height: 140),
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
