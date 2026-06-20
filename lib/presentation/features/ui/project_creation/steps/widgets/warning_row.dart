import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

class WarningRow extends StatelessWidget {
  const WarningRow(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Resources.verticalDims.$4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              fontSize: Resources.fontSizes.$12,
              color: Resources.colors.luxuryWarning,
            ),
          ),
          Expanded(
            child: Text(
              text,
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
