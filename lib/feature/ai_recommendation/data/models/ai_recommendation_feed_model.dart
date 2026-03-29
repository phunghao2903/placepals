import '../../domain/entities/ai_recommendation_feed.dart';
import 'ai_recommendation_highlight_model.dart';
import 'ai_recommendation_comment_feed_model.dart';
import 'ai_recommendation_compare_option_model.dart';
import 'ai_recommendation_compare_row_model.dart';
import 'ai_recommendation_location_detail_model.dart';
import 'ai_recommendation_map_pick_model.dart';
import 'ai_recommendation_progress_step_model.dart';
import 'ai_recommendation_review_insights_model.dart';
import 'ai_recommendation_result_item_model.dart';
import 'ai_recommendation_suggestion_model.dart';
import 'ai_recommendation_top_pick_model.dart';
import 'ai_recommendation_trip_planner_model.dart';

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
  final String mapTitle;
  final String mapRefineLabel;
  final String mapSheetTitle;
  final String mapCenterMatchLabel;
  final List<AiRecommendationMapPickModel> mapPicks;
  final String compareEyebrow;
  final String compareTitle;
  final String compareDescription;
  final List<AiRecommendationCompareOptionModel> compareOptions;
  final List<AiRecommendationCompareRowModel> compareRows;
  final AiRecommendationTopPickModel topPick;
  final AiRecommendationLocationDetailModel locationDetail;
  final AiRecommendationCommentFeedModel commentFeed;
  final AiRecommendationReviewInsightsModel reviewInsights;
  final AiRecommendationTripPlannerModel tripPlanner;

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
      mapTitle: mapTitle,
      mapRefineLabel: mapRefineLabel,
      mapSheetTitle: mapSheetTitle,
      mapCenterMatchLabel: mapCenterMatchLabel,
      mapPicks: mapPicks.map((item) => item.toEntity()).toList(),
      compareEyebrow: compareEyebrow,
      compareTitle: compareTitle,
      compareDescription: compareDescription,
      compareOptions: compareOptions.map((item) => item.toEntity()).toList(),
      compareRows: compareRows.map((item) => item.toEntity()).toList(),
      topPick: topPick.toEntity(),
      locationDetail: locationDetail.toEntity(),
      commentFeed: commentFeed.toEntity(),
      reviewInsights: reviewInsights.toEntity(),
      tripPlanner: tripPlanner.toEntity(),
    );
  }
}
