import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../../../core/constants/color_constants.dart';

class LoadingShimmer extends StatefulWidget {
  const LoadingShimmer({super.key});

  @override
  State<LoadingShimmer> createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<LoadingShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: context.padding.low,
      decoration: BoxDecoration(
        borderRadius: context.border.normalBorderRadius,
        color: ColorConstants.darkSpace.withOpacity(0.3),
        border: Border.all(
          color: ColorConstants.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: context.border.normalBorderRadius,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    ColorConstants.darkSpace.withOpacity(0.3),
                    ColorConstants.white.withOpacity(0.1),
                    ColorConstants.darkSpace.withOpacity(0.3),
                  ],
                  stops: [
                    _animation.value - 0.3,
                    _animation.value,
                    _animation.value + 0.3,
                  ],
                ),
              ),
              child: Padding(
                padding: context.padding.normal,
                child: Row(
                  children: [
                    // Shimmer Circle
                    Container(
                      width: context.sized.dynamicWidth(0.12),
                      height: context.sized.dynamicWidth(0.12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstants.white.withOpacity(0.1),
                      ),
                    ),
                    SizedBox(width: context.sized.lowValue),

                    // Shimmer Text Lines
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: context.sized.dynamicWidth(0.3),
                            height: context.sized.dynamicHeight(0.02),
                            decoration: BoxDecoration(
                              color: ColorConstants.white.withOpacity(0.1),
                              borderRadius: context.border.lowBorderRadius,
                            ),
                          ),
                          SizedBox(height: context.sized.lowValue),
                          Container(
                            width: context.sized.dynamicWidth(0.2),
                            height: context.sized.dynamicHeight(0.015),
                            decoration: BoxDecoration(
                              color: ColorConstants.white.withOpacity(0.1),
                              borderRadius: context.border.lowBorderRadius,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Shimmer Sparkline
                    Container(
                      width: context.sized.dynamicWidth(0.15),
                      height: context.sized.dynamicHeight(0.03),
                      decoration: BoxDecoration(
                        color: ColorConstants.white.withOpacity(0.1),
                        borderRadius: context.border.lowBorderRadius,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
