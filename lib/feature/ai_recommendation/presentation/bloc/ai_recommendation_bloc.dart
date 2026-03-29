import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/ai_recommendation_feed.dart';
import '../../domain/usecases/get_ai_recommendation_feed_usecase.dart';

part 'ai_recommendation_event.dart';
part 'ai_recommendation_state.dart';

class AiRecommendationBloc
    extends Bloc<AiRecommendationEvent, AiRecommendationState> {
  final GetAiRecommendationFeedUseCase getAiRecommendationFeedUseCase;

  AiRecommendationBloc({required this.getAiRecommendationFeedUseCase})
    : super(const AiRecommendationState()) {
    on<AiRecommendationStarted>(_onStarted);
    on<AiRecommendationPromptChanged>(_onPromptChanged);
    on<AiRecommendationSuggestionToggled>(_onSuggestionToggled);
    on<AiRecommendationTripDestinationChanged>(_onTripDestinationChanged);
    on<AiRecommendationTripVibeToggled>(_onTripVibeToggled);
    on<AiRecommendationTripBudgetChanged>(_onTripBudgetChanged);
    on<AiRecommendationTripDaySelected>(_onTripDaySelected);
    on<AiRecommendationPlaceNoteChanged>(_onPlaceNoteChanged);
    on<AiRecommendationCompareOptionSelected>(_onCompareOptionSelected);
    on<AiRecommendationTransparencyToggled>(_onTransparencyToggled);
    on<AiRecommendationHiddenReviewRevealToggled>(
      _onHiddenReviewRevealToggled,
    );
  }

  Future<void> _onStarted(
    AiRecommendationStarted event,
    Emitter<AiRecommendationState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AiRecommendationStatus.loading,
        clearErrorMessage: true,
      ),
    );

    try {
      final feed = await getAiRecommendationFeedUseCase();
      emit(
        state.copyWith(
          status: AiRecommendationStatus.success,
          feed: feed,
          prompt: feed.askPrompt,
          selectedSuggestionIds: feed.suggestions
              .where((item) => item.isSelected)
              .map((item) => item.id)
              .toList(growable: false),
          tripDestination: feed.tripPlanner.destinationPlaceholder,
          selectedTripVibeIds: const <String>['relaxed', 'foodie'],
          selectedTripBudgetIndex: 2,
          selectedTripDayIndex: 0,
          selectedCompareOptionId: feed.compareOptions.first.id,
          placeNote: '',
          isTransparencyEnabled: true,
          isHiddenReviewRevealed: false,
          clearErrorMessage: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: AiRecommendationStatus.failure,
          errorMessage: 'Unable to load AI recommendation screen.',
        ),
      );
    }
  }

  void _onPromptChanged(
    AiRecommendationPromptChanged event,
    Emitter<AiRecommendationState> emit,
  ) {
    emit(state.copyWith(prompt: event.prompt));
  }

  void _onSuggestionToggled(
    AiRecommendationSuggestionToggled event,
    Emitter<AiRecommendationState> emit,
  ) {
    final selected = List<String>.from(state.selectedSuggestionIds);
    if (selected.contains(event.suggestionId)) {
      selected.remove(event.suggestionId);
    } else {
      selected.add(event.suggestionId);
    }
    emit(state.copyWith(selectedSuggestionIds: selected));
  }

  void _onTripDestinationChanged(
    AiRecommendationTripDestinationChanged event,
    Emitter<AiRecommendationState> emit,
  ) {
    emit(state.copyWith(tripDestination: event.destination));
  }

  void _onTripVibeToggled(
    AiRecommendationTripVibeToggled event,
    Emitter<AiRecommendationState> emit,
  ) {
    final selected = List<String>.from(state.selectedTripVibeIds);
    if (selected.contains(event.vibeId)) {
      selected.remove(event.vibeId);
    } else if (selected.length < 3) {
      selected.add(event.vibeId);
    }

    emit(state.copyWith(selectedTripVibeIds: selected));
  }

  void _onTripBudgetChanged(
    AiRecommendationTripBudgetChanged event,
    Emitter<AiRecommendationState> emit,
  ) {
    emit(state.copyWith(selectedTripBudgetIndex: event.budgetIndex));
  }

  void _onTripDaySelected(
    AiRecommendationTripDaySelected event,
    Emitter<AiRecommendationState> emit,
  ) {
    emit(state.copyWith(selectedTripDayIndex: event.dayIndex));
  }

  void _onPlaceNoteChanged(
    AiRecommendationPlaceNoteChanged event,
    Emitter<AiRecommendationState> emit,
  ) {
    emit(state.copyWith(placeNote: event.note));
  }

  void _onCompareOptionSelected(
    AiRecommendationCompareOptionSelected event,
    Emitter<AiRecommendationState> emit,
  ) {
    emit(state.copyWith(selectedCompareOptionId: event.optionId));
  }

  void _onTransparencyToggled(
    AiRecommendationTransparencyToggled event,
    Emitter<AiRecommendationState> emit,
  ) {
    emit(
      state.copyWith(
        isTransparencyEnabled: !state.isTransparencyEnabled,
      ),
    );
  }

  void _onHiddenReviewRevealToggled(
    AiRecommendationHiddenReviewRevealToggled event,
    Emitter<AiRecommendationState> emit,
  ) {
    emit(
      state.copyWith(
        isHiddenReviewRevealed: !state.isHiddenReviewRevealed,
      ),
    );
  }
}
