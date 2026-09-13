import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/common_widgets/chips/app_filter_chip.dart';
import 'package:acrova/presentation/features/ui/billing/payment_history/cubit/payment_history_cubit.dart';
import 'package:acrova/presentation/features/ui/billing/payment_history/cubit/payment_history_state.dart';
import 'package:acrova/utils/enums/payment_filter_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentFilterWidget extends StatelessWidget {
  const PaymentFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Resources.verticalDims.$36,
      child: BlocBuilder<PaymentHistoryCubit, PaymentHistoryState>(
        buildWhen: (p, c) => p.selectedFilter != c.selectedFilter,
        builder: (context, state) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: Resources.horizontalDims.$24,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: PaymentFilter.values.length,
            separatorBuilder: (_, __) =>
                SizedBox(width: Resources.horizontalDims.$8),
            itemBuilder: (context, index) {
              final filter = PaymentFilter.values[index];
              final isSelected = filter == state.selectedFilter;
              return FiltersChip(
                label: filter.localizedLabel(context),
                onTap: () =>
                    context.read<PaymentHistoryCubit>().updateFilter(filter),
                active: isSelected,
              );
            },
          );
        },
      ),
    );
  }
}
