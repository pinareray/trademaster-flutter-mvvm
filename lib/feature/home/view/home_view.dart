import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/init/network/network_manager.dart';
import '../../../product/widget/base/base_view.dart';
import '../../../product/widget/card/coin_card.dart';
import '../../../product/widget/error/error_widget.dart';
import '../../../product/widget/loading/loading_shimmer.dart';
import '../../market_detail/view/market_detail_view.dart';
import '../service/home_service.dart';
import '../view_model/home_cubit.dart';
import '../view_model/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseView<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final networkManager = ProductNetworkManager.instance.networkManager;
        final homeService = HomeService(networkManager);
        return HomeCubit(homeService)..fetchAllCoins();
      },
      child: Scaffold(
        backgroundColor: ColorConstants.darkSpace,
        appBar: AppBar(
          title: Text(
            'TradeMaster',
            style: context.general.textTheme.titleLarge?.copyWith(
              color: ColorConstants.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: ColorConstants.darkSpace,
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return _buildLoadingView(context);
            } else if (state is HomeCompleted) {
              return _buildCompletedView(context, state);
            } else if (state is HomeError) {
              return _buildErrorView(context, state);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadingView(BuildContext context) {
    return ListView.builder(
      padding: context.padding.normal,
      itemCount: 10,
      itemBuilder: (context, index) => const LoadingShimmer(),
    );
  }

  Widget _buildCompletedView(BuildContext context, HomeCompleted state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeCubit>().fetchAllCoins();
      },
      color: ColorConstants.mintGreen,
      backgroundColor: ColorConstants.darkSpace,
      child: ListView.builder(
        padding: context.padding.normal,
        itemCount: state.coins.length,
        itemBuilder: (context, index) {
          final coin = state.coins[index];
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MarketDetailView(coin: coin),
                ),
              );
            },
            child: CoinCard(coin: coin),
          );
        },
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, HomeError state) {
    return CustomErrorWidget(
      message: state.message,
      onRetry: () {
        context.read<HomeCubit>().fetchAllCoins();
      },
    );
  }

  @override
  void onViewModelReady() {
    // ViewModel hazır olduğunda ek işlemler yapılabilir
  }
}

