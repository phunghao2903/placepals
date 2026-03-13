import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/home_feed.dart';
import '../../domain/usecases/get_home_feed_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeFeedUseCase getHomeFeedUseCase;

  HomeBloc({
    required this.getHomeFeedUseCase,
  }) : super(const HomeState()) {
    on<HomeStarted>(_onStarted);
    on<HomeCategorySelected>(_onCategorySelected);
    on<HomeFavoriteToggled>(_onFavoriteToggled);
  }

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final feed = await getHomeFeedUseCase();
      emit(
        state.copyWith(
          status: HomeStatus.success,
          feed: feed,
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: 'Unable to load nearby places.',
        ),
      );
    }
  }

  void _onCategorySelected(
    HomeCategorySelected event,
    Emitter<HomeState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedCategories = currentFeed.categories
        .map(
          (c) => c.copyWith(isSelected: c.id == event.categoryId),
        )
        .toList(growable: false);

    emit(
      state.copyWith(
        feed: currentFeed.copyWith(categories: updatedCategories),
      ),
    );
  }

  void _onFavoriteToggled(
    HomeFavoriteToggled event,
    Emitter<HomeState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedPlaces = currentFeed.places
        .map(
          (p) => p.id == event.placeId
              ? p.copyWith(isFavorite: !p.isFavorite)
              : p,
        )
        .toList(growable: false);

    emit(
      state.copyWith(
        feed: currentFeed.copyWith(places: updatedPlaces),
      ),
    );
  }
}
