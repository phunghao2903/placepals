part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState {
  final HomeStatus status;
  final HomeFeed? feed;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.feed,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    HomeFeed? feed,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
