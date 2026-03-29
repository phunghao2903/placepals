import 'ai_recommendation_trip_itinerary_item.dart';
import 'ai_recommendation_trip_pick.dart';
import 'ai_recommendation_trip_place_detail.dart';
import 'ai_recommendation_trip_traveler.dart';
import 'ai_recommendation_trip_trend_spot.dart';
import 'ai_recommendation_trip_vibe_option.dart';

class AiRecommendationTripPlanner {
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
  final List<AiRecommendationTripPick> picks;
  final List<String> browseVibes;
  final String trendingTitle;
  final List<AiRecommendationTripTrendSpot> trendingSpots;
  final String travelersTitle;
  final String travelersActionLabel;
  final List<AiRecommendationTripTraveler> travelers;
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
  final List<AiRecommendationTripVibeOption> vibeOptions;
  final String budgetLabel;
  final String budgetValue;
  final List<String> budgetScale;
  final String generateLabel;
  final String generateHelperText;
  final String detailTitle;
  final String detailSubtitle;
  final List<String> dayChips;
  final List<AiRecommendationTripItineraryItem> itinerary;
  final String detailActionLabel;
  final AiRecommendationTripPlaceDetail placeDetail;

  const AiRecommendationTripPlanner({
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
}
