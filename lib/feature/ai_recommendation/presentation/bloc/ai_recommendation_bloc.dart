import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/ai_recommendation_feed.dart';
import '../../domain/usecases/get_ai_recommendation_feed_usecase.dart';

part 'ai_recommendation_event.dart';
part 'ai_recommendation_state.dart';

class AiRecommendationBloc
    extends Bloc<AiRecommendationEvent, AiRecommendationState> {
  final GetAiRecommendationFeedUseCase getAiRecommendationFeedUseCase;

  AiRecommendationBloc({
    required this.getAiRecommendationFeedUseCase,
  }) : super(const AiRecommendationState()) {
    on<AiRecommendationStarted>(_onStarted);
    on<AiRecommendationPromptChanged>(_onPromptChanged);
    on<AiRecommendationSuggestionToggled>(_onSuggestionToggled);
  }

  Future<void> _onStarted(
    AiRecommendationStarted event,
    Emitter<AiRecommendationState> emit,
  ) async {
    emit(state.copyWith(status: AiRecommendationStatus.loading));

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
          errorMessage: null,
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
}
