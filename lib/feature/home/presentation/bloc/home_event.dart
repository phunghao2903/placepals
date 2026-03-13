part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

class HomeStarted extends HomeEvent {
  const HomeStarted();
}

class HomeCategorySelected extends HomeEvent {
  final String categoryId;

  const HomeCategorySelected({
    required this.categoryId,
  });
}

class HomeFavoriteToggled extends HomeEvent {
  final String placeId;

  const HomeFavoriteToggled({
    required this.placeId,
  });
}
