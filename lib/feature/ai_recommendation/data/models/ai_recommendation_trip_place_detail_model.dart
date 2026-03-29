import '../../domain/entities/ai_recommendation_trip_place_detail.dart';

class AiRecommendationTripPlaceDetailModel {
  final String headerImagePath;
  final String title;
  final String subtitle;
  final double rating;
  final List<String> tags;
  final String vibeTitle;
  final String vibeBadgeLabel;
  final String vibeSummary;
  final String vibeScoreLabel;
  final String positiveTitle;
  final String positiveDescription;
  final String cautionTitle;
  final String cautionDescription;
  final String filteredLabel;
  final String updatedLabel;
  final String aboutTitle;
  final String aboutDescription;
  final String aboutActionLabel;
  final String photosTitle;
  final String photosActionLabel;
  final List<String> photoPaths;
  final String mapButtonLabel;
  final String addButtonLabel;

  const AiRecommendationTripPlaceDetailModel({
    required this.headerImagePath,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.tags,
    required this.vibeTitle,
    required this.vibeBadgeLabel,
    required this.vibeSummary,
    required this.vibeScoreLabel,
    required this.positiveTitle,
    required this.positiveDescription,
    required this.cautionTitle,
    required this.cautionDescription,
    required this.filteredLabel,
    required this.updatedLabel,
    required this.aboutTitle,
    required this.aboutDescription,
    required this.aboutActionLabel,
    required this.photosTitle,
    required this.photosActionLabel,
    required this.photoPaths,
    required this.mapButtonLabel,
    required this.addButtonLabel,
  });

  AiRecommendationTripPlaceDetail toEntity() {
    return AiRecommendationTripPlaceDetail(
      headerImagePath: headerImagePath,
      title: title,
      subtitle: subtitle,
      rating: rating,
      tags: tags,
      vibeTitle: vibeTitle,
      vibeBadgeLabel: vibeBadgeLabel,
      vibeSummary: vibeSummary,
      vibeScoreLabel: vibeScoreLabel,
      positiveTitle: positiveTitle,
      positiveDescription: positiveDescription,
      cautionTitle: cautionTitle,
      cautionDescription: cautionDescription,
      filteredLabel: filteredLabel,
      updatedLabel: updatedLabel,
      aboutTitle: aboutTitle,
      aboutDescription: aboutDescription,
      aboutActionLabel: aboutActionLabel,
      photosTitle: photosTitle,
      photosActionLabel: photosActionLabel,
      photoPaths: photoPaths,
      mapButtonLabel: mapButtonLabel,
      addButtonLabel: addButtonLabel,
    );
  }
}
