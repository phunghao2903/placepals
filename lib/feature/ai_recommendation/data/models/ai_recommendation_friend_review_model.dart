import '../../domain/entities/ai_recommendation_friend_review.dart';

class AiRecommendationFriendReviewModel {
  final String authorHandle;
  final String timeLabel;
  final String content;
  final String initials;
  final String? avatarImagePath;

  const AiRecommendationFriendReviewModel({
    required this.authorHandle,
    required this.timeLabel,
    required this.content,
    required this.initials,
    this.avatarImagePath,
  });

  AiRecommendationFriendReview toEntity() {
    return AiRecommendationFriendReview(
      authorHandle: authorHandle,
      timeLabel: timeLabel,
      content: content,
      initials: initials,
      avatarImagePath: avatarImagePath,
    );
  }
}
