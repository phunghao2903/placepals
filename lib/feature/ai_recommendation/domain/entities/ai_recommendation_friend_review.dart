class AiRecommendationFriendReview {
  final String authorHandle;
  final String timeLabel;
  final String content;
  final String initials;
  final String? avatarImagePath;

  const AiRecommendationFriendReview({
    required this.authorHandle,
    required this.timeLabel,
    required this.content,
    required this.initials,
    this.avatarImagePath,
  });
}
