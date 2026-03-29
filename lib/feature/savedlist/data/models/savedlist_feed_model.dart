import 'package:flutter/material.dart';

import '../../domain/entities/savedlist_feed.dart';

class SavedListFeedModel {
  final String title;
  final List<SavedTabModel> tabs;
  final List<WishlistPlaceModel> wishlistPlaces;
  final List<VisitedStatModel> visitedStats;
  final List<VisitedTripModel> visitedTrips;
  final List<CollectionItemModel> collections;
  final List<RecentPlaceModel> nearbyPlaces;
  final List<RecentPlaceModel> recentlyViewedPlaces;
  final List<CollectionChoiceModel> collectionChoices;
  final List<TimelineMonthModel> timeline;
  final CollectionEditorDraftModel collectionEditorDraft;

  const SavedListFeedModel({
    required this.title,
    required this.tabs,
    required this.wishlistPlaces,
    required this.visitedStats,
    required this.visitedTrips,
    required this.collections,
    required this.nearbyPlaces,
    required this.recentlyViewedPlaces,
    required this.collectionChoices,
    required this.timeline,
    required this.collectionEditorDraft,
  });

  SavedListFeed toEntity() {
    return SavedListFeed(
      title: title,
      tabs: tabs.map((item) => item.toEntity()).toList(growable: false),
      wishlistPlaces: wishlistPlaces
          .map((item) => item.toEntity())
          .toList(growable: false),
      visitedStats: visitedStats
          .map((item) => item.toEntity())
          .toList(growable: false),
      visitedTrips: visitedTrips
          .map((item) => item.toEntity())
          .toList(growable: false),
      collections: collections
          .map((item) => item.toEntity())
          .toList(growable: false),
      nearbyPlaces: nearbyPlaces
          .map((item) => item.toEntity())
          .toList(growable: false),
      recentlyViewedPlaces: recentlyViewedPlaces
          .map((item) => item.toEntity())
          .toList(growable: false),
      collectionChoices: collectionChoices
          .map((item) => item.toEntity())
          .toList(growable: false),
      timeline: timeline.map((item) => item.toEntity()).toList(growable: false),
      collectionEditorDraft: collectionEditorDraft.toEntity(),
    );
  }
}

class SavedTabModel {
  final SavedTabType type;
  final String label;

  const SavedTabModel({
    required this.type,
    required this.label,
  });

  SavedTab toEntity() {
    return SavedTab(type: type, label: label);
  }
}

class WishlistPlaceModel {
  final String id;
  final String name;
  final String subtitle;
  final String imagePath;
  final double rating;
  final String? badgeLabel;
  final bool isFavorite;
  final bool showPlayOverlay;
  final bool showExternalLinkIcon;

  const WishlistPlaceModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.imagePath,
    required this.rating,
    this.badgeLabel,
    this.isFavorite = true,
    this.showPlayOverlay = false,
    this.showExternalLinkIcon = false,
  });

  WishlistPlace toEntity() {
    return WishlistPlace(
      id: id,
      name: name,
      subtitle: subtitle,
      imagePath: imagePath,
      rating: rating,
      badgeLabel: badgeLabel,
      isFavorite: isFavorite,
      showPlayOverlay: showPlayOverlay,
      showExternalLinkIcon: showExternalLinkIcon,
    );
  }
}

class VisitedStatModel {
  final String id;
  final String label;
  final String value;
  final Color accentColor;

  const VisitedStatModel({
    required this.id,
    required this.label,
    required this.value,
    required this.accentColor,
  });

  VisitedStat toEntity() {
    return VisitedStat(
      id: id,
      label: label,
      value: value,
      accentColor: accentColor,
    );
  }
}

class VisitedTripModel {
  final String id;
  final String monthLabel;
  final String title;
  final String subtitle;
  final int placesCount;
  final String imagePath;

  const VisitedTripModel({
    required this.id,
    required this.monthLabel,
    required this.title,
    required this.subtitle,
    required this.placesCount,
    required this.imagePath,
  });

  VisitedTrip toEntity() {
    return VisitedTrip(
      id: id,
      monthLabel: monthLabel,
      title: title,
      subtitle: subtitle,
      placesCount: placesCount,
      imagePath: imagePath,
    );
  }
}

class CollectionItemModel {
  final String id;
  final String title;
  final String subtitle;
  final String imagePath;
  final int placesCount;

  const CollectionItemModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.placesCount,
  });

  CollectionItem toEntity() {
    return CollectionItem(
      id: id,
      title: title,
      subtitle: subtitle,
      imagePath: imagePath,
      placesCount: placesCount,
    );
  }
}

class RecentPlaceModel {
  final String id;
  final String name;
  final String address;
  final double rating;
  final String imagePath;

  const RecentPlaceModel({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.imagePath,
  });

  RecentPlace toEntity() {
    return RecentPlace(
      id: id,
      name: name,
      address: address,
      rating: rating,
      imagePath: imagePath,
    );
  }
}

class CollectionChoiceModel {
  final String id;
  final String name;
  final int itemCount;
  final SavedCollectionIconType iconType;

  const CollectionChoiceModel({
    required this.id,
    required this.name,
    required this.itemCount,
    required this.iconType,
  });

  CollectionChoice toEntity() {
    return CollectionChoice(
      id: id,
      name: name,
      itemCount: itemCount,
      iconType: iconType,
    );
  }
}

class TimelineMonthModel {
  final String title;
  final List<TimelineEntryModel> entries;

  const TimelineMonthModel({
    required this.title,
    required this.entries,
  });

  TimelineMonth toEntity() {
    return TimelineMonth(
      title: title,
      entries: entries.map((item) => item.toEntity()).toList(growable: false),
    );
  }
}

class TimelineEntryModel {
  final String id;
  final String placeName;
  final String visitedAt;
  final String note;
  final String imagePath;
  final List<String> tags;

  const TimelineEntryModel({
    required this.id,
    required this.placeName,
    required this.visitedAt,
    required this.note,
    required this.imagePath,
    required this.tags,
  });

  TimelineEntry toEntity() {
    return TimelineEntry(
      id: id,
      placeName: placeName,
      visitedAt: visitedAt,
      note: note,
      imagePath: imagePath,
      tags: tags,
    );
  }
}

class CollectionEditorDraftModel {
  final String title;
  final String description;
  final String coverImagePath;
  final List<TravelBuddyModel> travelBuddies;
  final List<EditableCollectionPlaceModel> places;

  const CollectionEditorDraftModel({
    required this.title,
    required this.description,
    required this.coverImagePath,
    required this.travelBuddies,
    required this.places,
  });

  CollectionEditorDraft toEntity() {
    return CollectionEditorDraft(
      title: title,
      description: description,
      coverImagePath: coverImagePath,
      travelBuddies: travelBuddies
          .map((item) => item.toEntity())
          .toList(growable: false),
      places: places.map((item) => item.toEntity()).toList(growable: false),
    );
  }
}

class TravelBuddyModel {
  final String name;
  final String? imagePath;
  final bool isOnline;
  final bool isInviteAction;

  const TravelBuddyModel({
    required this.name,
    this.imagePath,
    this.isOnline = false,
    this.isInviteAction = false,
  });

  TravelBuddy toEntity() {
    return TravelBuddy(
      name: name,
      imagePath: imagePath,
      isOnline: isOnline,
      isInviteAction: isInviteAction,
    );
  }
}

class EditableCollectionPlaceModel {
  final String id;
  final String name;
  final String subtitle;
  final String imagePath;

  const EditableCollectionPlaceModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.imagePath,
  });

  EditableCollectionPlace toEntity() {
    return EditableCollectionPlace(
      id: id,
      name: name,
      subtitle: subtitle,
      imagePath: imagePath,
    );
  }
}
