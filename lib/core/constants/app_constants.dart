import 'package:flutter/material.dart';

@immutable
class ApplicationConstants {
  const ApplicationConstants._();

  static const String appName = 'TradeMaster';
  static const String baseUrl = 'https://api.coingecko.com/api/v3/';

  // UI Constants
  static const int shimmerLoadingCount = 10;

  // Storage Keys
  static const String favoritesKey = 'favorite_coins';
}
