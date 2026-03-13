part of 'ai_recommendation_bloc.dart';

sealed class AiRecommendationEvent {
  const AiRecommendationEvent();
}

class AiRecommendationStarted extends AiRecommendationEvent {
  const AiRecommendationStarted();
}

class AiRecommendationPromptChanged extends AiRecommendationEvent {
  final String prompt;

  const AiRecommendationPromptChanged({
    required this.prompt,
  });
}

class AiRecommendationSuggestionToggled extends AiRecommendationEvent {
  final String suggestionId;

  const AiRecommendationSuggestionToggled({
    required this.suggestionId,
  });
}
