import 'package:vexana/vexana.dart';
import '../model/coin_model.dart';

abstract class IHomeService {
  final INetworkManager networkManager;
  IHomeService(this.networkManager);

  Future<List<CoinModel>?> fetchCoins();
}


