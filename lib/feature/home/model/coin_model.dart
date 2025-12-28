import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'coin_model.g.dart'; // Bu dosya build_runner sonrası oluşacak

@JsonSerializable()
class CoinModel extends INetworkModel<CoinModel> {
  final String? id;
  final String? symbol;
  final String? name;
  final String? image;

  @JsonKey(name: 'current_price')
  final double? currentPrice;

  @JsonKey(name: 'price_change_percentage_24h')
  final double? priceChangePercentage24h;

  @JsonKey(name: 'market_cap')
  final double? marketCap;

  @JsonKey(name: 'market_cap_rank')
  final int? marketCapRank;

  CoinModel({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.priceChangePercentage24h,
    this.marketCap,
    this.marketCapRank,
  });

  @override
  CoinModel fromJson(Map<String, dynamic> json) {
    return _$CoinModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CoinModelToJson(this);
  }
}
