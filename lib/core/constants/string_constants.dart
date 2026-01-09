import 'package:flutter/material.dart';

@immutable
class StringConstants {
  const StringConstants._();

  // Error Widget
  static const String errorTitle = 'Error';
  static const String retryButton = 'Retry';

  // Market Detail View
  static const String chartPlaceholder = 'Interactive chart coming soon';
  static const String marketStatsTitle = 'Market Stats';
  static const String marketCapLabel = 'Market Cap';
  static const String marketCapRankLabel = 'Market Cap Rank';
  static const String sellButton = 'Sell';
  static const String buyButton = 'Buy';

  // Coin Card
  static const String unknownCoinName = 'Unknown';

  // General
  static const String noData = '-';

  // Search
  static const String searchHint = 'Search coins...';
  static const String noResultsFound = 'No results found';
  static const String tryDifferentKeyword = 'Try a different keyword';

  // Filters
  static const String allCoins = 'All';
  static const String favoritesOnly = 'Favorites';
  static const String noFavoritesYet = 'No favorites yet';
  static const String addSomeCoins = 'Add some coins to your favorites';

  // Sorting
  static const String sortBy = 'Sort By';
}
