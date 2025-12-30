import 'package:vexana/vexana.dart';
import '../../constants/app_constants.dart';

class ProductNetworkManager {
  static ProductNetworkManager? _instance;
  static ProductNetworkManager get instance =>
      _instance ??= ProductNetworkManager._init();

  late final INetworkManager networkManager;

  ProductNetworkManager._init() {
    networkManager = NetworkManager<EmptyModel>(
      options: BaseOptions(
        baseUrl: ApplicationConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
      ),
    );
  }
}
