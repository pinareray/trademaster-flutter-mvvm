import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/init/network/network_manager.dart';
import '../../../product/service/favorite_service.dart';
import '../../../product/view_model/favorite_cubit.dart';
import '../../../product/view_model/favorite_state.dart';
import '../../../product/widget/base/base_view.dart';
import '../../../product/widget/card/coin_card.dart';
import '../../../product/widget/empty/empty_state_widget.dart';
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
  final TextEditingController _searchController = TextEditingController();
  bool _showOnlyFavorites = false;
  SortType _currentSortType = SortType.marketCapDesc;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final networkManager = ProductNetworkManager.instance.networkManager;
            final homeService = HomeService(networkManager);
            return HomeCubit(homeService)..fetchAllCoins();
          },
        ),
        BlocProvider(
          create: (context) => FavoriteCubit(FavoriteService.instance)..loadFavorites(),
        ),
      ],
      child: Scaffold(
        backgroundColor: ColorConstants.darkSpace,
        appBar: AppBar(
          title: Text(
            ApplicationConstants.appName,
            style: context.general.textTheme.titleLarge?.copyWith(
              color: ColorConstants.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: ColorConstants.darkSpace,
          elevation: 0,
          centerTitle: true,
          actions: [
            PopupMenuButton<SortType>(
              icon: const Icon(Icons.sort, color: ColorConstants.white),
              tooltip: StringConstants.sortBy,
              color: ColorConstants.darkSpace.withOpacity(0.95),
              onSelected: (SortType sortType) {
                setState(() {
                  _currentSortType = sortType;
                });
                context.read<HomeCubit>().sortCoins(
                      sortType,
                      searchQuery: _searchController.text,
                    );
              },
              itemBuilder: (BuildContext context) {
                return SortType.values.map((SortType sortType) {
                  return PopupMenuItem<SortType>(
                    value: sortType,
                    child: Row(
                      children: [
                        Text(
                          sortType.icon,
                          style: const TextStyle(fontSize: 20),
                        ),
                        SizedBox(width: context.sized.lowValue),
                        Expanded(
                          child: Text(
                            sortType.displayName,
                            style: context.general.textTheme.bodyMedium?.copyWith(
                              color: ColorConstants.white,
                              fontWeight: _currentSortType == sortType
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        if (_currentSortType == sortType)
                          const Icon(
                            Icons.check,
                            color: ColorConstants.crystalBlue,
                            size: 20,
                          ),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            _buildSearchBar(context),
            _buildFilterChips(context),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
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
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.padding.normal.horizontal),
      child: Row(
        children: [
          FilterChip(
            label: Text(StringConstants.allCoins),
            selected: !_showOnlyFavorites,
            onSelected: (selected) {
              setState(() {
                _showOnlyFavorites = false;
              });
            },
            selectedColor: ColorConstants.crystalBlue.withOpacity(0.3),
            checkmarkColor: ColorConstants.white,
            backgroundColor: ColorConstants.darkSpace.withOpacity(0.6),
            labelStyle: context.general.textTheme.bodySmall?.copyWith(
              color: ColorConstants.white,
              fontWeight: _showOnlyFavorites ? FontWeight.normal : FontWeight.bold,
            ),
            side: BorderSide(
              color: _showOnlyFavorites
                  ? ColorConstants.white.withOpacity(0.1)
                  : ColorConstants.crystalBlue,
              width: _showOnlyFavorites ? 1 : 2,
            ),
          ),
          SizedBox(width: context.sized.lowValue),
          FilterChip(
            label: Text(StringConstants.favoritesOnly),
            selected: _showOnlyFavorites,
            onSelected: (selected) {
              setState(() {
                _showOnlyFavorites = true;
              });
            },
            selectedColor: ColorConstants.radicalRed.withOpacity(0.3),
            checkmarkColor: ColorConstants.white,
            backgroundColor: ColorConstants.darkSpace.withOpacity(0.6),
            labelStyle: context.general.textTheme.bodySmall?.copyWith(
              color: ColorConstants.white,
              fontWeight: _showOnlyFavorites ? FontWeight.bold : FontWeight.normal,
            ),
            side: BorderSide(
              color: _showOnlyFavorites
                  ? ColorConstants.radicalRed
                  : ColorConstants.white.withOpacity(0.1),
              width: _showOnlyFavorites ? 2 : 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: context.padding.normal,
      child: TextField(
        controller: _searchController,
        onChanged: (query) {
          context.read<HomeCubit>().searchCoins(query);
        },
        style: context.general.textTheme.bodyMedium?.copyWith(
          color: ColorConstants.white,
        ),
        decoration: InputDecoration(
          hintText: StringConstants.searchHint,
          hintStyle: context.general.textTheme.bodyMedium?.copyWith(
            color: ColorConstants.white.withOpacity(0.5),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: ColorConstants.white.withOpacity(0.7),
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: ColorConstants.white.withOpacity(0.7),
                  ),
                  onPressed: () {
                    _searchController.clear();
                    context.read<HomeCubit>().searchCoins('');
                  },
                )
              : null,
          filled: true,
          fillColor: ColorConstants.darkSpace.withOpacity(0.6),
          border: OutlineInputBorder(
            borderRadius: context.border.normalBorderRadius,
            borderSide: BorderSide(
              color: ColorConstants.white.withOpacity(0.1),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: context.border.normalBorderRadius,
            borderSide: BorderSide(
              color: ColorConstants.white.withOpacity(0.1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: context.border.normalBorderRadius,
            borderSide: BorderSide(
              color: ColorConstants.crystalBlue,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingView(BuildContext context) {
    return ListView.builder(
      padding: context.padding.normal,
      itemCount: ApplicationConstants.shimmerLoadingCount,
      itemBuilder: (context, index) => const LoadingShimmer(),
    );
  }

  Widget _buildCompletedView(BuildContext context, HomeCompleted state) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, favoriteState) {
        var displayCoins = state.coins;

        // Apply favorites filter if active
        if (_showOnlyFavorites && favoriteState is FavoritesLoaded) {
          displayCoins = state.coins
              .where((coin) => favoriteState.favoriteIds.contains(coin.id))
              .toList();

          // Show empty state if no favorites
          if (displayCoins.isEmpty) {
            return const EmptyStateWidget(
              title: StringConstants.noFavoritesYet,
              subtitle: StringConstants.addSomeCoins,
              icon: Icons.favorite_border,
            );
          }
        }

        // Show empty state if no results from search
        if (displayCoins.isEmpty) {
          return const EmptyStateWidget(
            title: StringConstants.noResultsFound,
            subtitle: StringConstants.tryDifferentKeyword,
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            _searchController.clear();
            context.read<HomeCubit>().fetchAllCoins();
          },
          color: ColorConstants.mintGreen,
          backgroundColor: ColorConstants.darkSpace,
          child: ListView.builder(
            padding: context.padding.normal,
            itemCount: displayCoins.length,
            itemBuilder: (context, index) {
              final coin = displayCoins[index];
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
      },
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

