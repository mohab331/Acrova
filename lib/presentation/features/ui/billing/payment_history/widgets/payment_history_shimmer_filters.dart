import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PaymentHistoryShimmerFilters extends StatelessWidget {
  const PaymentHistoryShimmerFilters();

  static const _widths = [80.0, 100.0, 90.0, 110.0];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$24),
      scrollDirection: Axis.horizontal,
      itemCount: _widths.length,
      separatorBuilder: (_, __) => SizedBox(width: Resources.horizontalDims.$8),
      itemBuilder: (context, index) {
        return Container(
          width: _widths[index],
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Resources.radius.$r20),
            border: Border.all(color: Resources.colors.luxuryBorder),
          ),
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Resources.colors.luxuryBorder.withValues(alpha: 0.3),
            highlightColor: Resources.colors.luxuryBorder.withValues(
              alpha: 0.1,
            ),
            child: Container(
              width: _widths[index] * 0.6,
              height: Resources.verticalDims.$12,
              decoration: BoxDecoration(
                color: Resources.colors.white,
                borderRadius: BorderRadius.circular(Resources.radius.$r4),
              ),
            ),
          ),
        );
      },
    );
  }
}
