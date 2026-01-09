import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class FavoriteService {
  static FavoriteService? _instance;
  static FavoriteService get instance => _instance ??= FavoriteService._init();

  SharedPreferences? _preferences;

  FavoriteService._init();

  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  Future<Set<String>> getFavorites() async {
    await init();
    final favorites = _preferences?.getStringList(ApplicationConstants.favoritesKey);
    return favorites?.toSet() ?? {};
  }

  Future<bool> addFavorite(String coinId) async {
    await init();
    final favorites = await getFavorites();
    favorites.add(coinId);
    return await _preferences?.setStringList(
          ApplicationConstants.favoritesKey,
          favorites.toList(),
        ) ??
        false;
  }

  Future<bool> removeFavorite(String coinId) async {
    await init();
    final favorites = await getFavorites();
    favorites.remove(coinId);
    return await _preferences?.setStringList(
          ApplicationConstants.favoritesKey,
          favorites.toList(),
        ) ??
        false;
  }

  Future<bool> isFavorite(String coinId) async {
    final favorites = await getFavorites();
    return favorites.contains(coinId);
  }

  Future<bool> toggleFavorite(String coinId) async {
    final isFav = await isFavorite(coinId);
    if (isFav) {
      return await removeFavorite(coinId);
    } else {
      return await addFavorite(coinId);
    }
  }
}
