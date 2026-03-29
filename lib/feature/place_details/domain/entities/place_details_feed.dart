class PlaceDetailsFeed {
  final PlaceDetailData detail;
  final PlaceCommentData comment;
  final PlaceReviewInsightsData reviewInsights;
  final PlaceMapData map;

  const PlaceDetailsFeed({
    required this.detail,
    required this.comment,
    required this.reviewInsights,
    required this.map,
  });
}

class PlaceDetailData {
  final String placeId;
  final String headerTitle;
  final String heroImagePath;
  final String statusLabel;
  final double rating;
  final String title;
  final String locationLabel;
  final String aboutTitle;
  final String aboutDescription;
  final List<PlaceDetailTag> tags;
  final PlaceMapSnippetData mapSnippet;
  final String reviewsTitle;
  final String reviewsActionLabel;
  final List<PlaceReviewPreview> previewReviews;

  const PlaceDetailData({
    required this.placeId,
    required this.headerTitle,
    required this.heroImagePath,
    required this.statusLabel,
    required this.rating,
    required this.title,
    required this.locationLabel,
    required this.aboutTitle,
    required this.aboutDescription,
    required this.tags,
    required this.mapSnippet,
    required this.reviewsTitle,
    required this.reviewsActionLabel,
    required this.previewReviews,
  });
}

class PlaceDetailTag {
  final String label;
  final String iconKey;

  const PlaceDetailTag({
    required this.label,
    required this.iconKey,
  });
}

class PlaceMapSnippetData {
  final String imagePath;
  final String buttonLabel;
  final String openingHoursTitle;
  final List<PlaceOpeningHour> openingHours;

  const PlaceMapSnippetData({
    required this.imagePath,
    required this.buttonLabel,
    required this.openingHoursTitle,
    required this.openingHours,
  });
}

class PlaceOpeningHour {
  final String dayLabel;
  final String hoursLabel;
  final bool isHighlighted;

  const PlaceOpeningHour({
    required this.dayLabel,
    required this.hoursLabel,
    this.isHighlighted = false,
  });
}

class PlaceReviewPreview {
  final String author;
  final String? avatarImagePath;
  final String initials;
  final int rating;
  final String content;

  const PlaceReviewPreview({
    required this.author,
    this.avatarImagePath,
    required this.initials,
    required this.rating,
    required this.content,
  });
}

class PlaceCommentData {
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
  final List<PlaceFriendReview> friendReviews;
  final String reviewsActionLabel;
  final String locationTitle;
  final String addressLabel;
  final String statusLabel;
  final String closingLabel;

  const PlaceCommentData({
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

class PlaceFriendReview {
  final String authorHandle;
  final String timeLabel;
  final String content;
  final String initials;
  final String? avatarImagePath;

  const PlaceFriendReview({
    required this.authorHandle,
    required this.timeLabel,
    required this.content,
    required this.initials,
    this.avatarImagePath,
  });
}

class PlaceReviewInsightsData {
  final String title;
  final String summaryTitle;
  final String sentimentValue;
  final String sentimentLabel;
  final String basedOnLabel;
  final List<PlaceReviewBreakdown> breakdowns;
  final String themesTitle;
  final List<String> themes;
  final String transparencyTitle;
  final String transparencySubtitle;
  final String recentReviewsTitle;
  final String sortLabel;
  final List<PlaceReviewItem> reviews;

  const PlaceReviewInsightsData({
    required this.title,
    required this.summaryTitle,
    required this.sentimentValue,
    required this.sentimentLabel,
    required this.basedOnLabel,
    required this.breakdowns,
    required this.themesTitle,
    required this.themes,
    required this.transparencyTitle,
    required this.transparencySubtitle,
    required this.recentReviewsTitle,
    required this.sortLabel,
    required this.reviews,
  });
}

class PlaceReviewBreakdown {
  final String label;
  final String valueLabel;
  final double progress;

  const PlaceReviewBreakdown({
    required this.label,
    required this.valueLabel,
    required this.progress,
  });
}

class PlaceReviewItem {
  final String id;
  final String? author;
  final String? meta;
  final String? content;
  final int rating;
  final List<String> tags;
  final bool isHidden;
  final String initials;
  final String? hiddenTitle;
  final String? hiddenSubtitle;
  final String? flaggedTitle;
  final String? flaggedDescription;
  final String? actionLabel;

  const PlaceReviewItem({
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

class PlaceMapData {
  final String title;
  final String refineLabel;
  final String mapImagePath;
  final String centerBadgeLabel;
  final String sheetTitle;
  final String navigationActionLabel;
  final List<PlaceMapPick> picks;

  const PlaceMapData({
    required this.title,
    required this.refineLabel,
    required this.mapImagePath,
    required this.centerBadgeLabel,
    required this.sheetTitle,
    required this.navigationActionLabel,
    required this.picks,
  });
}

class PlaceMapPick {
  final String id;
  final String title;
  final String subtitle;
  final String imagePath;
  final String markerLabel;
  final String? badgeLabel;
  final String? highlightLabel;
  final double rating;
  final bool isFeatured;

  const PlaceMapPick({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.markerLabel,
    required this.rating,
    this.badgeLabel,
    this.highlightLabel,
    this.isFeatured = false,
  });
}
