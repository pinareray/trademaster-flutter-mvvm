import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/favorite_service.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteService favoriteService;

  FavoriteCubit(this.favoriteService) : super(const FavoriteInitial());

  Future<void> loadFavorites() async {
    final favorites = await favoriteService.getFavorites();
    emit(FavoritesLoaded(favorites));
  }

  Future<void> toggleFavorite(String coinId) async {
    await favoriteService.toggleFavorite(coinId);
    await loadFavorites();
  }

  bool isFavorite(String coinId) {
    if (state is FavoritesLoaded) {
      return (state as FavoritesLoaded).favoriteIds.contains(coinId);
    }
    return false;
  }
}
