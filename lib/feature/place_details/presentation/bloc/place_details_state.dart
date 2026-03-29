part of 'place_details_bloc.dart';

enum PlaceDetailsStatus {
  initial,
  loading,
  success,
  failure,
}

class PlaceDetailsState {
  final PlaceDetailsStatus status;
  final PlaceDetailsFeed? feed;
  final String? errorMessage;
  final bool isTransparencyEnabled;
  final bool isHiddenReviewRevealed;
  final String? selectedMapPickId;

  const PlaceDetailsState({
    this.status = PlaceDetailsStatus.initial,
    this.feed,
    this.errorMessage,
    this.isTransparencyEnabled = true,
    this.isHiddenReviewRevealed = false,
    this.selectedMapPickId,
  });

  PlaceDetailsState copyWith({
    PlaceDetailsStatus? status,
    PlaceDetailsFeed? feed,
    String? errorMessage,
    bool clearErrorMessage = false,
    bool? isTransparencyEnabled,
    bool? isHiddenReviewRevealed,
    String? selectedMapPickId,
    bool clearSelectedMapPickId = false,
  }) {
    return PlaceDetailsState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      errorMessage: clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      isTransparencyEnabled:
          isTransparencyEnabled ?? this.isTransparencyEnabled,
      isHiddenReviewRevealed:
          isHiddenReviewRevealed ?? this.isHiddenReviewRevealed,
      selectedMapPickId: clearSelectedMapPickId
          ? null
          : selectedMapPickId ?? this.selectedMapPickId,
    );
  }
}
