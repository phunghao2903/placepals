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

class AiRecommendationTripDestinationChanged extends AiRecommendationEvent {
  final String destination;

  const AiRecommendationTripDestinationChanged({
    required this.destination,
  });
}

class AiRecommendationTripVibeToggled extends AiRecommendationEvent {
  final String vibeId;

  const AiRecommendationTripVibeToggled({
    required this.vibeId,
  });
}

class AiRecommendationTripBudgetChanged extends AiRecommendationEvent {
  final int budgetIndex;

  const AiRecommendationTripBudgetChanged({
    required this.budgetIndex,
  });
}

class AiRecommendationTripDaySelected extends AiRecommendationEvent {
  final int dayIndex;

  const AiRecommendationTripDaySelected({
    required this.dayIndex,
  });
}

class AiRecommendationPlaceNoteChanged extends AiRecommendationEvent {
  final String note;

  const AiRecommendationPlaceNoteChanged({
    required this.note,
  });
}

class AiRecommendationCompareOptionSelected extends AiRecommendationEvent {
  final String optionId;

  const AiRecommendationCompareOptionSelected({
    required this.optionId,
  });
}

class AiRecommendationTransparencyToggled extends AiRecommendationEvent {
  const AiRecommendationTransparencyToggled();
}

class AiRecommendationHiddenReviewRevealToggled
    extends AiRecommendationEvent {
  const AiRecommendationHiddenReviewRevealToggled();
}
