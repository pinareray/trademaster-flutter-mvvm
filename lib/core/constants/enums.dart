enum SortType {
  marketCapDesc,
  marketCapAsc,
  priceChangeDesc,
  priceChangeAsc,
  nameAsc,
  nameDesc,
}

extension SortTypeExtension on SortType {
  String get displayName {
    switch (this) {
      case SortType.marketCapDesc:
        return 'Market Cap (High to Low)';
      case SortType.marketCapAsc:
        return 'Market Cap (Low to High)';
      case SortType.priceChangeDesc:
        return 'Price Change (High to Low)';
      case SortType.priceChangeAsc:
        return 'Price Change (Low to High)';
      case SortType.nameAsc:
        return 'Name (A-Z)';
      case SortType.nameDesc:
        return 'Name (Z-A)';
    }
  }

  String get icon {
    switch (this) {
      case SortType.marketCapDesc:
      case SortType.marketCapAsc:
        return '💰';
      case SortType.priceChangeDesc:
      case SortType.priceChangeAsc:
        return '📈';
      case SortType.nameAsc:
      case SortType.nameDesc:
        return '🔤';
    }
  }
}
