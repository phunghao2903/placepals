class AiRecommendationReviewItem {
  final String id;
  final String? author;
  final String? meta;
  final String? content;
  final int rating;
  final List<String> tags;
  final bool isHidden;
  final String? hiddenTitle;
  final String? hiddenSubtitle;
  final String? flaggedTitle;
  final String? flaggedDescription;
  final String? actionLabel;
  final String initials;

  const AiRecommendationReviewItem({
    required this.id,
    required this.rating,
    required this.tags,
    required this.isHidden,
    required this.initials,
    this.author,
    this.meta,
    this.content,
    this.hiddenTitle,
    this.hiddenSubtitle,
    this.flaggedTitle,
    this.flaggedDescription,
    this.actionLabel,
  });
}
