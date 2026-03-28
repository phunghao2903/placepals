import '../../domain/entities/place_details_feed.dart';

class PlaceDetailsFeedModel {
  final PlaceDetailDataModel detail;
  final PlaceCommentDataModel comment;
  final PlaceReviewInsightsDataModel reviewInsights;
  final PlaceMapDataModel map;

  const PlaceDetailsFeedModel({
    required this.detail,
    required this.comment,
    required this.reviewInsights,
    required this.map,
  });

  PlaceDetailsFeed toEntity() {
    return PlaceDetailsFeed(
      detail: detail.toEntity(),
      comment: comment.toEntity(),
      reviewInsights: reviewInsights.toEntity(),
      map: map.toEntity(),
    );
  }
}

class PlaceDetailDataModel {
  final String placeId;
  final String headerTitle;
  final String heroImagePath;
  final String statusLabel;
  final double rating;
  final String title;
  final String locationLabel;
  final String aboutTitle;
  final String aboutDescription;
  final List<PlaceDetailTagModel> tags;
  final PlaceMapSnippetDataModel mapSnippet;
  final String reviewsTitle;
  final String reviewsActionLabel;
  final List<PlaceReviewPreviewModel> previewReviews;

  const PlaceDetailDataModel({
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

  PlaceDetailData toEntity() {
    return PlaceDetailData(
      placeId: placeId,
      headerTitle: headerTitle,
      heroImagePath: heroImagePath,
      statusLabel: statusLabel,
      rating: rating,
      title: title,
      locationLabel: locationLabel,
      aboutTitle: aboutTitle,
      aboutDescription: aboutDescription,
      tags: tags.map((item) => item.toEntity()).toList(growable: false),
      mapSnippet: mapSnippet.toEntity(),
      reviewsTitle: reviewsTitle,
      reviewsActionLabel: reviewsActionLabel,
      previewReviews: previewReviews
          .map((item) => item.toEntity())
          .toList(growable: false),
    );
  }
}

class PlaceDetailTagModel {
  final String label;
  final String iconKey;

  const PlaceDetailTagModel({
    required this.label,
    required this.iconKey,
  });

  PlaceDetailTag toEntity() {
    return PlaceDetailTag(label: label, iconKey: iconKey);
  }
}

class PlaceMapSnippetDataModel {
  final String imagePath;
  final String buttonLabel;
  final String openingHoursTitle;
  final List<PlaceOpeningHourModel> openingHours;

  const PlaceMapSnippetDataModel({
    required this.imagePath,
    required this.buttonLabel,
    required this.openingHoursTitle,
    required this.openingHours,
  });

  PlaceMapSnippetData toEntity() {
    return PlaceMapSnippetData(
      imagePath: imagePath,
      buttonLabel: buttonLabel,
      openingHoursTitle: openingHoursTitle,
      openingHours: openingHours
          .map((item) => item.toEntity())
          .toList(growable: false),
    );
  }
}

class PlaceOpeningHourModel {
  final String dayLabel;
  final String hoursLabel;
  final bool isHighlighted;

  const PlaceOpeningHourModel({
    required this.dayLabel,
    required this.hoursLabel,
    this.isHighlighted = false,
  });

  PlaceOpeningHour toEntity() {
    return PlaceOpeningHour(
      dayLabel: dayLabel,
      hoursLabel: hoursLabel,
      isHighlighted: isHighlighted,
    );
  }
}

class PlaceReviewPreviewModel {
  final String author;
  final String? avatarImagePath;
  final String initials;
  final int rating;
  final String content;

  const PlaceReviewPreviewModel({
    required this.author,
    this.avatarImagePath,
    required this.initials,
    required this.rating,
    required this.content,
  });

  PlaceReviewPreview toEntity() {
    return PlaceReviewPreview(
      author: author,
      avatarImagePath: avatarImagePath,
      initials: initials,
      rating: rating,
      content: content,
    );
  }
}

class PlaceCommentDataModel {
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
  final List<PlaceFriendReviewModel> friendReviews;
  final String reviewsActionLabel;
  final String locationTitle;
  final String addressLabel;
  final String statusLabel;
  final String closingLabel;

  const PlaceCommentDataModel({
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

  PlaceCommentData toEntity() {
    return PlaceCommentData(
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
      friendReviews: friendReviews
          .map((item) => item.toEntity())
          .toList(growable: false),
      reviewsActionLabel: reviewsActionLabel,
      locationTitle: locationTitle,
      addressLabel: addressLabel,
      statusLabel: statusLabel,
      closingLabel: closingLabel,
    );
  }
}

class PlaceFriendReviewModel {
  final String authorHandle;
  final String timeLabel;
  final String content;
  final String initials;
  final String? avatarImagePath;

  const PlaceFriendReviewModel({
    required this.authorHandle,
    required this.timeLabel,
    required this.content,
    required this.initials,
    this.avatarImagePath,
  });

  PlaceFriendReview toEntity() {
    return PlaceFriendReview(
      authorHandle: authorHandle,
      timeLabel: timeLabel,
      content: content,
      initials: initials,
      avatarImagePath: avatarImagePath,
    );
  }
}

class PlaceReviewInsightsDataModel {
  final String title;
  final String summaryTitle;
  final String sentimentValue;
  final String sentimentLabel;
  final String basedOnLabel;
  final List<PlaceReviewBreakdownModel> breakdowns;
  final String themesTitle;
  final List<String> themes;
  final String transparencyTitle;
  final String transparencySubtitle;
  final String recentReviewsTitle;
  final String sortLabel;
  final List<PlaceReviewItemModel> reviews;

  const PlaceReviewInsightsDataModel({
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

  PlaceReviewInsightsData toEntity() {
    return PlaceReviewInsightsData(
      title: title,
      summaryTitle: summaryTitle,
      sentimentValue: sentimentValue,
      sentimentLabel: sentimentLabel,
      basedOnLabel: basedOnLabel,
      breakdowns:
          breakdowns.map((item) => item.toEntity()).toList(growable: false),
      themesTitle: themesTitle,
      themes: themes,
      transparencyTitle: transparencyTitle,
      transparencySubtitle: transparencySubtitle,
      recentReviewsTitle: recentReviewsTitle,
      sortLabel: sortLabel,
      reviews: reviews.map((item) => item.toEntity()).toList(growable: false),
    );
  }
}

class PlaceReviewBreakdownModel {
  final String label;
  final String valueLabel;
  final double progress;

  const PlaceReviewBreakdownModel({
    required this.label,
    required this.valueLabel,
    required this.progress,
  });

  PlaceReviewBreakdown toEntity() {
    return PlaceReviewBreakdown(
      label: label,
      valueLabel: valueLabel,
      progress: progress,
    );
  }
}

class PlaceReviewItemModel {
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

  const PlaceReviewItemModel({
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

  PlaceReviewItem toEntity() {
    return PlaceReviewItem(
      id: id,
      author: author,
      meta: meta,
      content: content,
      rating: rating,
      tags: tags,
      isHidden: isHidden,
      initials: initials,
      hiddenTitle: hiddenTitle,
      hiddenSubtitle: hiddenSubtitle,
      flaggedTitle: flaggedTitle,
      flaggedDescription: flaggedDescription,
      actionLabel: actionLabel,
    );
  }
}

class PlaceMapDataModel {
  final String title;
  final String refineLabel;
  final String mapImagePath;
  final String centerBadgeLabel;
  final String sheetTitle;
  final String navigationActionLabel;
  final List<PlaceMapPickModel> picks;

  const PlaceMapDataModel({
    required this.title,
    required this.refineLabel,
    required this.mapImagePath,
    required this.centerBadgeLabel,
    required this.sheetTitle,
    required this.navigationActionLabel,
    required this.picks,
  });

  PlaceMapData toEntity() {
    return PlaceMapData(
      title: title,
      refineLabel: refineLabel,
      mapImagePath: mapImagePath,
      centerBadgeLabel: centerBadgeLabel,
      sheetTitle: sheetTitle,
      navigationActionLabel: navigationActionLabel,
      picks: picks.map((item) => item.toEntity()).toList(growable: false),
    );
  }
}

class PlaceMapPickModel {
  final String id;
  final String title;
  final String subtitle;
  final String imagePath;
  final String markerLabel;
  final String? badgeLabel;
  final String? highlightLabel;
  final double rating;
  final bool isFeatured;

  const PlaceMapPickModel({
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

  PlaceMapPick toEntity() {
    return PlaceMapPick(
      id: id,
      title: title,
      subtitle: subtitle,
      imagePath: imagePath,
      markerLabel: markerLabel,
      badgeLabel: badgeLabel,
      highlightLabel: highlightLabel,
      rating: rating,
      isFeatured: isFeatured,
    );
  }
}
