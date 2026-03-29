import 'ai_recommendation_comment_feed.dart';
import 'ai_recommendation_compare_option.dart';
import 'ai_recommendation_compare_row.dart';
import 'ai_recommendation_highlight.dart';
import 'ai_recommendation_location_detail.dart';
import 'ai_recommendation_map_pick.dart';
import 'ai_recommendation_progress_step.dart';
import 'ai_recommendation_review_insights.dart';
import 'ai_recommendation_result_item.dart';
import 'ai_recommendation_suggestion.dart';
import 'ai_recommendation_top_pick.dart';
import 'ai_recommendation_trip_planner.dart';

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
  final String mapTitle;
  final String mapRefineLabel;
  final String mapSheetTitle;
  final String mapCenterMatchLabel;
  final List<AiRecommendationMapPick> mapPicks;
  final String compareEyebrow;
  final String compareTitle;
  final String compareDescription;
  final List<AiRecommendationCompareOption> compareOptions;
  final List<AiRecommendationCompareRow> compareRows;
  final AiRecommendationTopPick topPick;
  final AiRecommendationLocationDetail locationDetail;
  final AiRecommendationCommentFeed commentFeed;
  final AiRecommendationReviewInsights reviewInsights;
  final AiRecommendationTripPlanner tripPlanner;

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
    required this.mapTitle,
    required this.mapRefineLabel,
    required this.mapSheetTitle,
    required this.mapCenterMatchLabel,
    required this.mapPicks,
    required this.compareEyebrow,
    required this.compareTitle,
    required this.compareDescription,
    required this.compareOptions,
    required this.compareRows,
    required this.topPick,
    required this.locationDetail,
    required this.commentFeed,
    required this.reviewInsights,
    required this.tripPlanner,
  });
}
