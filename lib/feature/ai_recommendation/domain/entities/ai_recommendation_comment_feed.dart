import 'ai_recommendation_friend_review.dart';

class AiRecommendationCommentFeed {
  final String title;
  final String category;
  final String priceLabel;
  final String distanceLabel;
  final String imagePath;
  final String primaryActionLabel;
  final String secondaryActionLabel;
  final String friendsSectionTitle;
  final String friendsSectionSubtitle;
  final String ratingLabel;
  final List<AiRecommendationFriendReview> friendReviews;
  final String reviewsActionLabel;
  final String locationTitle;
  final String addressLabel;
  final String statusLabel;
  final String closingLabel;

  const AiRecommendationCommentFeed({
    required this.title,
    required this.category,
    required this.priceLabel,
    required this.distanceLabel,
    required this.imagePath,
    required this.primaryActionLabel,
    required this.secondaryActionLabel,
    required this.friendsSectionTitle,
    required this.friendsSectionSubtitle,
    required this.ratingLabel,
    required this.friendReviews,
    required this.reviewsActionLabel,
    required this.locationTitle,
    required this.addressLabel,
    required this.statusLabel,
    required this.closingLabel,
  });
}
