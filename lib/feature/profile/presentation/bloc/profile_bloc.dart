import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/profile_feed.dart';
import '../../domain/usecases/get_profile_feed_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileFeedUseCase getProfileFeedUseCase;

  ProfileBloc({required this.getProfileFeedUseCase})
    : super(const ProfileState()) {
    on<ProfileStarted>(_onStarted);
    on<ProfileTabSelected>(_onTabSelected);
    on<ProfileCityFilterSelected>(_onCityFilterSelected);
    on<ProfileSortSelected>(_onSortSelected);
    on<ProfileViewModeChanged>(_onViewModeChanged);
    on<ProfilePlaceSaveToggled>(_onPlaceSaveToggled);
  }

  Future<void> _onStarted(
    ProfileStarted event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final feed = await getProfileFeedUseCase();
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          feed: feed,
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: 'Unable to load profile.',
        ),
      );
    }
  }

  void _onTabSelected(ProfileTabSelected event, Emitter<ProfileState> emit) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedTabs = currentFeed.tabs
        .map((tab) => tab.copyWith(isSelected: tab.id == event.tabId))
        .toList(growable: false);

    emit(state.copyWith(feed: currentFeed.copyWith(tabs: updatedTabs)));
  }

  void _onCityFilterSelected(
    ProfileCityFilterSelected event,
    Emitter<ProfileState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedFilters = currentFeed.cityFilters
        .map(
          (filter) => filter.copyWith(isSelected: filter.id == event.filterId),
        )
        .toList(growable: false);

    emit(
      state.copyWith(feed: currentFeed.copyWith(cityFilters: updatedFilters)),
    );
  }

  void _onSortSelected(ProfileSortSelected event, Emitter<ProfileState> emit) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedSorts = currentFeed.sortOptions
        .map((sort) => sort.copyWith(isSelected: sort.id == event.sortId))
        .toList(growable: false);

    emit(state.copyWith(feed: currentFeed.copyWith(sortOptions: updatedSorts)));
  }

  void _onViewModeChanged(
    ProfileViewModeChanged event,
    Emitter<ProfileState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    emit(state.copyWith(feed: currentFeed.copyWith(viewMode: event.viewMode)));
  }

  void _onPlaceSaveToggled(
    ProfilePlaceSaveToggled event,
    Emitter<ProfileState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedPlaces = currentFeed.places
        .map(
          (place) => place.id == event.placeId
              ? place.copyWith(isSaved: event.isSaved)
              : place,
        )
        .toList(growable: false);

    emit(
      state.copyWith(
        feed: currentFeed.copyWith(places: updatedPlaces),
      ),
    );
  }
}
