part of 'ai_recommendation_bloc.dart';

enum AiRecommendationStatus {
  initial,
  loading,
  success,
  failure,
}

class AiRecommendationState {
  final AiRecommendationStatus status;
  final AiRecommendationFeed? feed;
  final String? errorMessage;
  final String prompt;
  final List<String> selectedSuggestionIds;

  const AiRecommendationState({
    this.status = AiRecommendationStatus.initial,
    this.feed,
    this.errorMessage,
    this.prompt = '',
    this.selectedSuggestionIds = const <String>[],
  });

  AiRecommendationState copyWith({
    AiRecommendationStatus? status,
    AiRecommendationFeed? feed,
    String? errorMessage,
    String? prompt,
    List<String>? selectedSuggestionIds,
  }) {
    return AiRecommendationState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      errorMessage: errorMessage ?? this.errorMessage,
      prompt: prompt ?? this.prompt,
      selectedSuggestionIds:
          selectedSuggestionIds ?? this.selectedSuggestionIds,
    );
  }
}
