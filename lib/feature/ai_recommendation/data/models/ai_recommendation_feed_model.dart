import '../../domain/entities/ai_recommendation_feed.dart';
import 'ai_recommendation_highlight_model.dart';
import 'ai_recommendation_progress_step_model.dart';
import 'ai_recommendation_result_item_model.dart';
import 'ai_recommendation_suggestion_model.dart';

class AiRecommendationFeedModel {
  final String headline;
  final List<AiRecommendationHighlightModel> highlights;
  final String askTitle;
  final String askPrompt;
  final List<AiRecommendationSuggestionModel> suggestions;
  final String progressTitle;
  final String progressSubtitle;
  final List<AiRecommendationProgressStepModel> progressSteps;
  final String resultsTitle;
  final String resultsSummaryQuery;
  final String resultsSummarySuffix;
  final List<AiRecommendationResultItemModel> results;

  const AiRecommendationFeedModel({
    required this.headline,
    required this.highlights,
    required this.askTitle,
    required this.askPrompt,
    required this.suggestions,
    required this.progressTitle,
    required this.progressSubtitle,
    required this.progressSteps,
    required this.resultsTitle,
    required this.resultsSummaryQuery,
    required this.resultsSummarySuffix,
    required this.results,
  });

  AiRecommendationFeed toEntity() {
    return AiRecommendationFeed(
      headline: headline,
      highlights: highlights.map((item) => item.toEntity()).toList(),
      askTitle: askTitle,
      askPrompt: askPrompt,
      suggestions: suggestions.map((item) => item.toEntity()).toList(),
      progressTitle: progressTitle,
      progressSubtitle: progressSubtitle,
      progressSteps: progressSteps.map((item) => item.toEntity()).toList(),
      resultsTitle: resultsTitle,
      resultsSummaryQuery: resultsSummaryQuery,
      resultsSummarySuffix: resultsSummarySuffix,
      results: results.map((item) => item.toEntity()).toList(),
    );
  }
}
