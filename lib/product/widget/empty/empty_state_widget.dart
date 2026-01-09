import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../../../core/constants/color_constants.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: context.padding.normal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.search_off,
              size: context.sized.dynamicWidth(0.2),
              color: ColorConstants.white.withOpacity(0.3),
            ),
            SizedBox(height: context.sized.normalValue),
            Text(
              title,
              style: context.general.textTheme.headlineSmall?.copyWith(
                color: ColorConstants.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.sized.lowValue),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: context.general.textTheme.bodyMedium?.copyWith(
                color: ColorConstants.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
