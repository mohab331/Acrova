import 'package:acrova/presentation/app/resources/resources.dart';
import 'package:acrova/presentation/features/cubit/interior_design/interior_design_cubit.dart';
import 'package:acrova/presentation/features/cubit/interior_design/interior_design_state.dart';
import 'package:acrova/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InspirationLinksSection extends StatefulWidget {
  const InspirationLinksSection({super.key});

  @override
  State<InspirationLinksSection> createState() => _InspirationLinksSectionState();
}

class _InspirationLinksSectionState extends State<InspirationLinksSection> {
  final TextEditingController _linkCtrl = TextEditingController();

  @override
  void dispose() {
    _linkCtrl.dispose();
    super.dispose();
  }

  void _addLink(BuildContext context) {
    final text = _linkCtrl.text.trim();
    if (text.isNotEmpty) {
      // Very basic URL validation
      if (text.startsWith('http://') || text.startsWith('https://')) {
        context.read<InteriorDesignCubit>().addInspirationLink(text);
        _linkCtrl.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please enter a valid URL starting with http:// or https://'),
            backgroundColor: Resources.colors.luxuryError,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InteriorDesignCubit, InteriorDesignState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: Resources.verticalDims.$16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'INSPIRATION LINKS',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: Resources.fontWeights.semiBold,
                          color: Resources.colors.luxuryNavy,
                          letterSpacing: 0.5,
                        ),
                  ),
                  SizedBox(height: Resources.verticalDims.$4),
                  Text(
                    'Add links to Pinterest boards, Houzz, or other web references.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Resources.colors.luxuryBody,
                        ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Resources.colors.luxuryInputBg,
                      borderRadius: BorderRadius.circular(Resources.radius.$r8),
                      border: Border.all(color: Resources.colors.luxuryInputBorder),
                    ),
                    child: TextField(
                      controller: _linkCtrl,
                      decoration: InputDecoration(
                        hintText: 'https://...',
                        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Resources.colors.luxuryPlaceholder,
                            ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Resources.horizontalDims.$16,
                          vertical: Resources.verticalDims.$12,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Resources.horizontalDims.$12),
                ElevatedButton(
                  onPressed: () => _addLink(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Resources.colors.luxuryNavy,
                    padding: EdgeInsets.symmetric(
                      horizontal: Resources.horizontalDims.$20,
                      vertical: Resources.verticalDims.$14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Resources.radius.$r8),
                    ),
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Resources.colors.white,
                      fontWeight: Resources.fontWeights.semiBold,
                    ),
                  ),
                ),
              ],
            ),
            if (state.inspirationLinks.isNotEmpty) ...[
              SizedBox(height: Resources.verticalDims.$16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.inspirationLinks.length,
                separatorBuilder: (_, __) => SizedBox(height: Resources.verticalDims.$8),
                itemBuilder: (context, index) {
                  final link = state.inspirationLinks[index];
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Resources.horizontalDims.$16,
                      vertical: Resources.verticalDims.$12,
                    ),
                    decoration: BoxDecoration(
                      color: Resources.colors.luxurySurface,
                      borderRadius: BorderRadius.circular(Resources.radius.$r8),
                      border: Border.all(color: Resources.colors.luxuryBorder),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.link,
                          color: Resources.colors.luxuryGoldLight,
                          size: 20,
                        ),
                        SizedBox(width: Resources.horizontalDims.$12),
                        Expanded(
                          child: Text(
                            link,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Resources.colors.luxuryNavy,
                              fontWeight: Resources.fontWeights.medium,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.read<InteriorDesignCubit>().removeInspirationLink(index),
                          child: Icon(
                            Icons.close,
                            color: Resources.colors.luxuryError,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ],
        );
      },
    );
  }
}
