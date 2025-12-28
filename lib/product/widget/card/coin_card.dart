import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../../../core/constants/color_constants.dart';
import '../../../feature/home/model/coin_model.dart';
import 'sparkline_painter.dart';

class CoinCard extends StatelessWidget {
  final CoinModel coin;

  const CoinCard({super.key, required this.coin});

  bool get isPriceUp => (coin.priceChangePercentage24h ?? 0) >= 0;

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
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: context.padding.normal,
            child: Row(
              children: [
                // Coin Image
                _buildCoinImage(context),
                SizedBox(width: context.sized.lowValue),

                // Coin Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCoinName(context),
                      SizedBox(height: context.sized.lowValue),
                      _buildCoinPrice(context),
                    ],
                  ),
                ),

                // Sparkline & Change
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildSparkline(context),
                    SizedBox(height: context.sized.lowValue),
                    _buildPriceChange(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoinImage(BuildContext context) {
    return Container(
      width: context.sized.dynamicWidth(0.12),
      height: context.sized.dynamicWidth(0.12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorConstants.white.withOpacity(0.1),
      ),
      child: coin.image != null
          ? ClipOval(
              child: Image.network(
                coin.image!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.currency_bitcoin,
                  color: ColorConstants.mintGreen,
                  size: context.sized.dynamicWidth(0.08),
                ),
              ),
            )
          : Icon(
              Icons.currency_bitcoin,
              color: ColorConstants.mintGreen,
              size: context.sized.dynamicWidth(0.08),
            ),
    );
  }

  Widget _buildCoinName(BuildContext context) {
    return Row(
      children: [
        Text(
          coin.name ?? 'Unknown',
          style: context.general.textTheme.titleMedium?.copyWith(
            color: ColorConstants.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: context.sized.lowValue),
        Text(
          coin.symbol?.toUpperCase() ?? '',
          style: context.general.textTheme.bodySmall?.copyWith(
            color: ColorConstants.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildCoinPrice(BuildContext context) {
    final price = coin.currentPrice ?? 0.0;
    return Text(
      '\$${price.toStringAsFixed(2)}',
      style: context.general.textTheme.bodyLarge?.copyWith(
        color: ColorConstants.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildSparkline(BuildContext context) {
    // Fake sparkline data (in real app, this would come from API)
    final sparklineData = List.generate(
      20,
      (index) => 0.5 + (index % 3) * 0.1 + (isPriceUp ? 0.2 : -0.2),
    );

    return SizedBox(
      width: context.sized.dynamicWidth(0.15),
      height: context.sized.dynamicHeight(0.03),
      child: CustomPaint(
        painter: SparklinePainter(
          data: sparklineData,
          color: isPriceUp
              ? ColorConstants.mintGreen
              : ColorConstants.radicalRed,
        ),
      ),
    );
  }

  Widget _buildPriceChange(BuildContext context) {
    final change = coin.priceChangePercentage24h ?? 0.0;
    final changeText = '${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}%';

    return Container(
      padding: context.padding.low,
      decoration: BoxDecoration(
        color: isPriceUp
            ? ColorConstants.mintGreen.withOpacity(0.2)
            : ColorConstants.radicalRed.withOpacity(0.2),
        borderRadius: context.border.lowBorderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPriceUp ? Icons.trending_up : Icons.trending_down,
            size: 14,
            color: isPriceUp
                ? ColorConstants.mintGreen
                : ColorConstants.radicalRed,
          ),
          SizedBox(width: context.sized.lowValue),
          Text(
            changeText,
            style: context.general.textTheme.bodySmall?.copyWith(
              color: isPriceUp
                  ? ColorConstants.mintGreen
                  : ColorConstants.radicalRed,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
