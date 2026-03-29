import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/place_details_feed.dart';
import '../../domain/usecases/get_place_details_feed_usecase.dart';

part 'place_details_event.dart';
part 'place_details_state.dart';

class PlaceDetailsBloc extends Bloc<PlaceDetailsEvent, PlaceDetailsState> {
  final GetPlaceDetailsFeedUseCase getPlaceDetailsFeedUseCase;

  PlaceDetailsBloc({
    required this.getPlaceDetailsFeedUseCase,
  }) : super(const PlaceDetailsState()) {
    on<PlaceDetailsStarted>(_onStarted);
    on<PlaceDetailsTransparencyToggled>(_onTransparencyToggled);
    on<PlaceDetailsHiddenReviewRevealToggled>(_onHiddenReviewRevealToggled);
    on<PlaceDetailsMapPickSelected>(_onMapPickSelected);
  }

  Future<void> _onStarted(
    PlaceDetailsStarted event,
    Emitter<PlaceDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: PlaceDetailsStatus.loading,
        clearErrorMessage: true,
        clearSelectedMapPickId: true,
      ),
    );

    try {
      final PlaceDetailsFeed feed =
          await getPlaceDetailsFeedUseCase(event.placeId);
      String? initialPickId;
      for (final item in feed.map.picks) {
        if (item.isFeatured) {
          initialPickId = item.id;
          break;
        }
      }
      initialPickId ??= feed.map.picks.isNotEmpty ? feed.map.picks.first.id : null;
      emit(
        state.copyWith(
          status: PlaceDetailsStatus.success,
          feed: feed,
          selectedMapPickId: initialPickId,
          isTransparencyEnabled: true,
          isHiddenReviewRevealed: false,
          clearErrorMessage: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: PlaceDetailsStatus.failure,
          errorMessage: 'Unable to load place details.',
        ),
      );
    }
  }

  void _onTransparencyToggled(
    PlaceDetailsTransparencyToggled event,
    Emitter<PlaceDetailsState> emit,
  ) {
    emit(
      state.copyWith(
        isTransparencyEnabled: !state.isTransparencyEnabled,
      ),
    );
  }

  void _onHiddenReviewRevealToggled(
    PlaceDetailsHiddenReviewRevealToggled event,
    Emitter<PlaceDetailsState> emit,
  ) {
    emit(
      state.copyWith(
        isHiddenReviewRevealed: !state.isHiddenReviewRevealed,
      ),
    );
  }

  void _onMapPickSelected(
    PlaceDetailsMapPickSelected event,
    Emitter<PlaceDetailsState> emit,
  ) {
    emit(state.copyWith(selectedMapPickId: event.pickId));
  }
}
