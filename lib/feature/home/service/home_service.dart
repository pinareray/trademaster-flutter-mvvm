import 'package:vexana/vexana.dart';
import 'i_home_service.dart';
import '../model/coin_model.dart';

class HomeService extends IHomeService {
  HomeService(super.networkManager);

  @override
  Future<List<CoinModel>?> fetchCoins() async {
    final response = await networkManager.send<CoinModel, List<CoinModel>>(
      'coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
        'order': 'market_cap_desc',
      },
      parseModel: CoinModel(),
      method: RequestType.GET,
    );
    return response.data;
  }
}

