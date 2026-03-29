import '../../domain/entities/ai_recommendation_trip_planner.dart';
import 'ai_recommendation_trip_itinerary_item_model.dart';
import 'ai_recommendation_trip_pick_model.dart';
import 'ai_recommendation_trip_place_detail_model.dart';
import 'ai_recommendation_trip_traveler_model.dart';
import 'ai_recommendation_trip_trend_spot_model.dart';
import 'ai_recommendation_trip_vibe_option_model.dart';

class AiRecommendationTripPlannerModel {
  final String homeGreeting;
  final String homeName;
  final String searchHint;
  final String plannerBadge;
  final String plannerTitle;
  final String plannerDescription;
  final String plannerActionLabel;
  final String picksTitle;
  final String picksEyebrow;
  final String picksActionLabel;
  final List<AiRecommendationTripPickModel> picks;
  final List<String> browseVibes;
  final String trendingTitle;
  final List<AiRecommendationTripTrendSpotModel> trendingSpots;
  final String travelersTitle;
  final String travelersActionLabel;
  final List<AiRecommendationTripTravelerModel> travelers;
  final String infoTitle;
  final String infoEyebrow;
  final String infoHeadline;
  final String infoDescription;
  final String destinationLabel;
  final String destinationPlaceholder;
  final String startDateLabel;
  final String startDateValue;
  final String endDateLabel;
  final String endDateValue;
  final String vibeLabel;
  final String vibeHelperLabel;
  final List<AiRecommendationTripVibeOptionModel> vibeOptions;
  final String budgetLabel;
  final String budgetValue;
  final List<String> budgetScale;
  final String generateLabel;
  final String generateHelperText;
  final String detailTitle;
  final String detailSubtitle;
  final List<String> dayChips;
  final List<AiRecommendationTripItineraryItemModel> itinerary;
  final String detailActionLabel;
  final AiRecommendationTripPlaceDetailModel placeDetail;

  const AiRecommendationTripPlannerModel({
    required this.homeGreeting,
    required this.homeName,
    required this.searchHint,
    required this.plannerBadge,
    required this.plannerTitle,
    required this.plannerDescription,
    required this.plannerActionLabel,
    required this.picksTitle,
    required this.picksEyebrow,
    required this.picksActionLabel,
    required this.picks,
    required this.browseVibes,
    required this.trendingTitle,
    required this.trendingSpots,
    required this.travelersTitle,
    required this.travelersActionLabel,
    required this.travelers,
    required this.infoTitle,
    required this.infoEyebrow,
    required this.infoHeadline,
    required this.infoDescription,
    required this.destinationLabel,
    required this.destinationPlaceholder,
    required this.startDateLabel,
    required this.startDateValue,
    required this.endDateLabel,
    required this.endDateValue,
    required this.vibeLabel,
    required this.vibeHelperLabel,
    required this.vibeOptions,
    required this.budgetLabel,
    required this.budgetValue,
    required this.budgetScale,
    required this.generateLabel,
    required this.generateHelperText,
    required this.detailTitle,
    required this.detailSubtitle,
    required this.dayChips,
    required this.itinerary,
    required this.detailActionLabel,
    required this.placeDetail,
  });

  AiRecommendationTripPlanner toEntity() {
    return AiRecommendationTripPlanner(
      homeGreeting: homeGreeting,
      homeName: homeName,
      searchHint: searchHint,
      plannerBadge: plannerBadge,
      plannerTitle: plannerTitle,
      plannerDescription: plannerDescription,
      plannerActionLabel: plannerActionLabel,
      picksTitle: picksTitle,
      picksEyebrow: picksEyebrow,
      picksActionLabel: picksActionLabel,
      picks: picks.map((item) => item.toEntity()).toList(),
      browseVibes: browseVibes,
      trendingTitle: trendingTitle,
      trendingSpots: trendingSpots.map((item) => item.toEntity()).toList(),
      travelersTitle: travelersTitle,
      travelersActionLabel: travelersActionLabel,
      travelers: travelers.map((item) => item.toEntity()).toList(),
      infoTitle: infoTitle,
      infoEyebrow: infoEyebrow,
      infoHeadline: infoHeadline,
      infoDescription: infoDescription,
      destinationLabel: destinationLabel,
      destinationPlaceholder: destinationPlaceholder,
      startDateLabel: startDateLabel,
      startDateValue: startDateValue,
      endDateLabel: endDateLabel,
      endDateValue: endDateValue,
      vibeLabel: vibeLabel,
      vibeHelperLabel: vibeHelperLabel,
      vibeOptions: vibeOptions.map((item) => item.toEntity()).toList(),
      budgetLabel: budgetLabel,
      budgetValue: budgetValue,
      budgetScale: budgetScale,
      generateLabel: generateLabel,
      generateHelperText: generateHelperText,
      detailTitle: detailTitle,
      detailSubtitle: detailSubtitle,
      dayChips: dayChips,
      itinerary: itinerary.map((item) => item.toEntity()).toList(),
      detailActionLabel: detailActionLabel,
      placeDetail: placeDetail.toEntity(),
    );
  }
}
