import '../../domain/entities/ai_recommendation_comment_feed.dart';
import 'ai_recommendation_friend_review_model.dart';

class AiRecommendationCommentFeedModel {
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
  final List<AiRecommendationFriendReviewModel> friendReviews;
  final String reviewsActionLabel;
  final String locationTitle;
  final String addressLabel;
  final String statusLabel;
  final String closingLabel;

  const AiRecommendationCommentFeedModel({
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

  AiRecommendationCommentFeed toEntity() {
    return AiRecommendationCommentFeed(
      title: title,
      category: category,
      priceLabel: priceLabel,
      distanceLabel: distanceLabel,
      imagePath: imagePath,
      primaryActionLabel: primaryActionLabel,
      secondaryActionLabel: secondaryActionLabel,
      friendsSectionTitle: friendsSectionTitle,
      friendsSectionSubtitle: friendsSectionSubtitle,
      ratingLabel: ratingLabel,
      friendReviews: friendReviews.map((item) => item.toEntity()).toList(),
      reviewsActionLabel: reviewsActionLabel,
      locationTitle: locationTitle,
      addressLabel: addressLabel,
      statusLabel: statusLabel,
      closingLabel: closingLabel,
    );
  }
}
