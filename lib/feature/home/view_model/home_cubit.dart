import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/enums.dart';
import '../model/coin_model.dart';
import '../service/i_home_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final IHomeService homeService;
  List<CoinModel> _allCoins = [];

  HomeCubit(this.homeService) : super(const HomeInitial());

  Future<void> fetchAllCoins() async {
    emit(const HomeLoading());

    try {
      final coins = await homeService.fetchCoins();

      if (coins == null || coins.isEmpty) {
        emit(const HomeError('No coins found'));
        return;
      }

      _allCoins = coins;
      emit(HomeCompleted(coins));
    } catch (e) {
      emit(HomeError('Failed to fetch coins: ${e.toString()}'));
    }
  }

  void searchCoins(String query) {
    if (query.isEmpty) {
      emit(HomeCompleted(_allCoins));
      return;
    }

    final filteredCoins = _allCoins.where((coin) {
      final name = coin.name?.toLowerCase() ?? '';
      final symbol = coin.symbol?.toLowerCase() ?? '';
      final searchLower = query.toLowerCase();

      return name.contains(searchLower) || symbol.contains(searchLower);
    }).toList();

    emit(HomeCompleted(filteredCoins));
  }

  void sortCoins(SortType sortType, {String? searchQuery}) {
    var coins = searchQuery != null && searchQuery.isNotEmpty
        ? _allCoins.where((coin) {
            final name = coin.name?.toLowerCase() ?? '';
            final symbol = coin.symbol?.toLowerCase() ?? '';
            final searchLower = searchQuery.toLowerCase();
            return name.contains(searchLower) || symbol.contains(searchLower);
          }).toList()
        : List<CoinModel>.from(_allCoins);

    switch (sortType) {
      case SortType.marketCapDesc:
        coins.sort((a, b) => (b.marketCap ?? 0).compareTo(a.marketCap ?? 0));
        break;
      case SortType.marketCapAsc:
        coins.sort((a, b) => (a.marketCap ?? 0).compareTo(b.marketCap ?? 0));
        break;
      case SortType.priceChangeDesc:
        coins.sort((a, b) =>
            (b.priceChangePercentage24h ?? 0).compareTo(a.priceChangePercentage24h ?? 0));
        break;
      case SortType.priceChangeAsc:
        coins.sort((a, b) =>
            (a.priceChangePercentage24h ?? 0).compareTo(b.priceChangePercentage24h ?? 0));
        break;
      case SortType.nameAsc:
        coins.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
        break;
      case SortType.nameDesc:
        coins.sort((a, b) => (b.name ?? '').compareTo(a.name ?? ''));
        break;
    }

    emit(HomeCompleted(coins));
  }
}







