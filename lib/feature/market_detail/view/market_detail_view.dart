import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../home/model/coin_model.dart';

class MarketDetailView extends StatelessWidget {
  final CoinModel coin;

  const MarketDetailView({super.key, required this.coin});

  bool get isPriceUp => (coin.priceChangePercentage24h ?? 0) >= 0;

  @override
  Widget build(BuildContext context) {
    final price = coin.currentPrice ?? 0;
    final change = coin.priceChangePercentage24h ?? 0;

    return Scaffold(
      backgroundColor: ColorConstants.darkSpace,
      appBar: AppBar(
        backgroundColor: ColorConstants.darkSpace,
        elevation: 0,
        title: Text(
          coin.symbol?.toUpperCase() ?? '',
          style: context.general.textTheme.titleLarge?.copyWith(
            color: ColorConstants.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: context.padding.normal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, price, change),
            SizedBox(height: context.sized.normalValue),
            _buildChartPlaceholder(context),
            SizedBox(height: context.sized.normalValue),
            _buildStats(context),
            SizedBox(height: context.sized.normalValue),
            _buildOrderButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double price, double change) {
    return Row(
      children: [
        CircleAvatar(
          radius: context.sized.dynamicWidth(0.08),
          backgroundColor: ColorConstants.white.withOpacity(0.1),
          backgroundImage:
              coin.image != null ? NetworkImage(coin.image!) : null,
          child: coin.image == null
              ? Icon(
                  Icons.currency_bitcoin,
                  color: ColorConstants.mintGreen,
                  size: context.sized.dynamicWidth(0.08),
                )
              : null,
        ),
        SizedBox(width: context.sized.normalValue),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                coin.name ?? StringConstants.unknownCoinName,
                style: context.general.textTheme.titleLarge?.copyWith(
                  color: ColorConstants.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: context.sized.lowValue),
              Row(
                children: [
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: context.general.textTheme.headlineMedium?.copyWith(
                      color: ColorConstants.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: context.sized.lowValue),
                  _buildChangeChip(context, change),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChangeChip(BuildContext context, double change) {
    final isUp = isPriceUp;
    final changeText = '${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}%';

    return Container(
      padding: context.padding.low,
      decoration: BoxDecoration(
        color: isUp
            ? ColorConstants.mintGreen.withOpacity(0.2)
            : ColorConstants.radicalRed.withOpacity(0.2),
        borderRadius: context.border.lowBorderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUp ? Icons.trending_up : Icons.trending_down,
            size: 16,
            color:
                isUp ? ColorConstants.mintGreen : ColorConstants.radicalRed,
          ),
          SizedBox(width: context.sized.lowValue),
          Text(
            changeText,
            style: context.general.textTheme.bodySmall?.copyWith(
              color:
                  isUp ? ColorConstants.mintGreen : ColorConstants.radicalRed,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartPlaceholder(BuildContext context) {
    return Container(
      height: context.sized.dynamicHeight(0.3),
      decoration: BoxDecoration(
        borderRadius: context.border.normalBorderRadius,
        color: ColorConstants.darkSpace.withOpacity(0.6),
        border: Border.all(
          color: ColorConstants.white.withOpacity(0.1),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        StringConstants.chartPlaceholder,
        style: context.general.textTheme.bodyMedium?.copyWith(
          color: ColorConstants.white.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConstants.marketStatsTitle,
          style: context.general.textTheme.titleMedium?.copyWith(
            color: ColorConstants.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: context.sized.lowValue),
        Container(
          padding: context.padding.normal,
          decoration: BoxDecoration(
            borderRadius: context.border.normalBorderRadius,
            color: ColorConstants.darkSpace.withOpacity(0.6),
            border: Border.all(
              color: ColorConstants.white.withOpacity(0.1),
            ),
          ),
          child: Column(
            children: [
              _buildStatRow(
                context,
                StringConstants.marketCapLabel,
                coin.marketCap != null
                    ? '\$${coin.marketCap!.toStringAsFixed(0)}'
                    : StringConstants.noData,
              ),
              SizedBox(height: context.sized.lowValue),
              _buildStatRow(
                context,
                StringConstants.marketCapRankLabel,
                coin.marketCapRank?.toString() ?? StringConstants.noData,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(
    BuildContext context,
    String label,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.general.textTheme.bodyMedium?.copyWith(
            color: ColorConstants.white.withOpacity(0.7),
          ),
        ),
        Text(
          value,
          style: context.general.textTheme.bodyMedium?.copyWith(
            color: ColorConstants.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.radicalRed,
              foregroundColor: ColorConstants.white,
              padding: context.padding.normal,
              shape: RoundedRectangleBorder(
                borderRadius: context.border.normalBorderRadius,
              ),
            ),
            child: Text(
              StringConstants.sellButton,
              style: context.general.textTheme.titleMedium?.copyWith(
                color: ColorConstants.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: context.sized.normalValue),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.mintGreen,
              foregroundColor: ColorConstants.white,
              padding: context.padding.normal,
              shape: RoundedRectangleBorder(
                borderRadius: context.border.normalBorderRadius,
              ),
            ),
            child: Text(
              StringConstants.buyButton,
              style: context.general.textTheme.titleMedium?.copyWith(
                color: ColorConstants.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}







