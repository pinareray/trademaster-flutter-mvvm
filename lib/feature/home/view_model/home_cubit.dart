import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';
import '../service/i_home_service.dart';

class HomeCubit extends Cubit<HomeState> {
  final IHomeService homeService;

  HomeCubit(this.homeService) : super(const HomeInitial());

  Future<void> fetchAllCoins() async {
    emit(const HomeLoading());
    
    try {
      final coins = await homeService.fetchCoins();
      
      if (coins == null || coins.isEmpty) {
        emit(const HomeError('No coins found'));
        return;
      }
      
      emit(HomeCompleted(coins));
    } catch (e) {
      emit(HomeError('Failed to fetch coins: ${e.toString()}'));
    }
  }
}







