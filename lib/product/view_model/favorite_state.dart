import 'package:equatable/equatable.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {
  const FavoriteInitial();
}

class FavoritesLoaded extends FavoriteState {
  final Set<String> favoriteIds;

  const FavoritesLoaded(this.favoriteIds);

  @override
  List<Object?> get props => [favoriteIds];
}
