part of 'ai_recommendation_bloc.dart';

enum AiRecommendationStatus { initial, loading, success, failure }

class AiRecommendationState {
  final AiRecommendationStatus status;
  final AiRecommendationFeed? feed;
  final String? errorMessage;
  final String prompt;
  final List<String> selectedSuggestionIds;
  final String tripDestination;
  final List<String> selectedTripVibeIds;
  final int selectedTripBudgetIndex;
  final int selectedTripDayIndex;
  final String placeNote;
  final String? selectedCompareOptionId;
  final bool isTransparencyEnabled;
  final bool isHiddenReviewRevealed;

  const AiRecommendationState({
    this.status = AiRecommendationStatus.initial,
    this.feed,
    this.errorMessage,
    this.prompt = '',
    this.selectedSuggestionIds = const <String>[],
    this.tripDestination = '',
    this.selectedTripVibeIds = const <String>[],
    this.selectedTripBudgetIndex = 2,
    this.selectedTripDayIndex = 0,
    this.placeNote = '',
    this.selectedCompareOptionId,
    this.isTransparencyEnabled = true,
    this.isHiddenReviewRevealed = false,
  });

  AiRecommendationState copyWith({
    AiRecommendationStatus? status,
    AiRecommendationFeed? feed,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? prompt,
    List<String>? selectedSuggestionIds,
    String? tripDestination,
    List<String>? selectedTripVibeIds,
    int? selectedTripBudgetIndex,
    int? selectedTripDayIndex,
    String? placeNote,
    String? selectedCompareOptionId,
    bool? clearSelectedCompareOptionId,
    bool? isTransparencyEnabled,
    bool? isHiddenReviewRevealed,
  }) {
    return AiRecommendationState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      errorMessage: clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      prompt: prompt ?? this.prompt,
      selectedSuggestionIds:
          selectedSuggestionIds ?? this.selectedSuggestionIds,
      tripDestination: tripDestination ?? this.tripDestination,
      selectedTripVibeIds: selectedTripVibeIds ?? this.selectedTripVibeIds,
      selectedTripBudgetIndex:
          selectedTripBudgetIndex ?? this.selectedTripBudgetIndex,
      selectedTripDayIndex: selectedTripDayIndex ?? this.selectedTripDayIndex,
      placeNote: placeNote ?? this.placeNote,
      selectedCompareOptionId: clearSelectedCompareOptionId == true
          ? null
          : selectedCompareOptionId ?? this.selectedCompareOptionId,
      isTransparencyEnabled:
          isTransparencyEnabled ?? this.isTransparencyEnabled,
      isHiddenReviewRevealed:
          isHiddenReviewRevealed ?? this.isHiddenReviewRevealed,
    );
  }
}
