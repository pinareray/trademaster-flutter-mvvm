import 'package:equatable/equatable.dart';
import '../model/coin_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeCompleted extends HomeState {
  final List<CoinModel> coins;

  const HomeCompleted(this.coins);

  @override
  List<Object?> get props => [coins];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}


