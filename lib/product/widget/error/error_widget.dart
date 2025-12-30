import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../../../core/constants/color_constants.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const CustomErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
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
              Icons.error_outline,
              size: context.sized.dynamicWidth(0.2),
              color: ColorConstants.radicalRed,
            ),
            SizedBox(height: context.sized.normalValue),
            Text(
              'Error',
              style: context.general.textTheme.headlineSmall?.copyWith(
                color: ColorConstants.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.sized.lowValue),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.general.textTheme.bodyMedium?.copyWith(
                color: ColorConstants.white.withOpacity(0.7),
              ),
            ),
            if (onRetry != null) ...[
              SizedBox(height: context.sized.normalValue),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.crystalBlue,
                  foregroundColor: ColorConstants.white,
                  padding: context.padding.normal,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

