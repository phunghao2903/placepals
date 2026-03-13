import 'ai_recommendation_highlight.dart';
import 'ai_recommendation_progress_step.dart';
import 'ai_recommendation_result_item.dart';
import 'ai_recommendation_suggestion.dart';

class AiRecommendationFeed {
  final String headline;
  final List<AiRecommendationHighlight> highlights;
  final String askTitle;
  final String askPrompt;
  final List<AiRecommendationSuggestion> suggestions;
  final String progressTitle;
  final String progressSubtitle;
  final List<AiRecommendationProgressStep> progressSteps;
  final String resultsTitle;
  final String resultsSummaryQuery;
  final String resultsSummarySuffix;
  final List<AiRecommendationResultItem> results;

  const AiRecommendationFeed({
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
}
