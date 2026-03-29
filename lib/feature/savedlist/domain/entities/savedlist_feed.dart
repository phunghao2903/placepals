import 'package:flutter/material.dart';

enum SavedTabType { wishlist, visited, collections }

enum SavedCollectionIconType { heart, plane, coffee }

class SavedListFeed {
  final String title;
  final List<SavedTab> tabs;
  final List<WishlistPlace> wishlistPlaces;
  final List<VisitedStat> visitedStats;
  final List<VisitedTrip> visitedTrips;
  final List<CollectionItem> collections;
  final List<RecentPlace> nearbyPlaces;
  final List<RecentPlace> recentlyViewedPlaces;
  final List<CollectionChoice> collectionChoices;
  final List<TimelineMonth> timeline;
  final CollectionEditorDraft collectionEditorDraft;

  const SavedListFeed({
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

  SavedListFeed copyWith({
    String? title,
    List<SavedTab>? tabs,
    List<WishlistPlace>? wishlistPlaces,
    List<VisitedStat>? visitedStats,
    List<VisitedTrip>? visitedTrips,
    List<CollectionItem>? collections,
    List<RecentPlace>? nearbyPlaces,
    List<RecentPlace>? recentlyViewedPlaces,
    List<CollectionChoice>? collectionChoices,
    List<TimelineMonth>? timeline,
    CollectionEditorDraft? collectionEditorDraft,
  }) {
    return SavedListFeed(
      title: title ?? this.title,
      tabs: tabs ?? this.tabs,
      wishlistPlaces: wishlistPlaces ?? this.wishlistPlaces,
      visitedStats: visitedStats ?? this.visitedStats,
      visitedTrips: visitedTrips ?? this.visitedTrips,
      collections: collections ?? this.collections,
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
      recentlyViewedPlaces: recentlyViewedPlaces ?? this.recentlyViewedPlaces,
      collectionChoices: collectionChoices ?? this.collectionChoices,
      timeline: timeline ?? this.timeline,
      collectionEditorDraft:
          collectionEditorDraft ?? this.collectionEditorDraft,
    );
  }
}

class SavedTab {
  final SavedTabType type;
  final String label;

  const SavedTab({
    required this.type,
    required this.label,
  });
}

class WishlistPlace {
  final String id;
  final String name;
  final String subtitle;
  final String imagePath;
  final double rating;
  final String? badgeLabel;
  final bool isFavorite;
  final bool showPlayOverlay;
  final bool showExternalLinkIcon;

  const WishlistPlace({
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

  WishlistPlace copyWith({
    String? id,
    String? name,
    String? subtitle,
    String? imagePath,
    double? rating,
    String? badgeLabel,
    bool? isFavorite,
    bool? showPlayOverlay,
    bool? showExternalLinkIcon,
  }) {
    return WishlistPlace(
      id: id ?? this.id,
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      imagePath: imagePath ?? this.imagePath,
      rating: rating ?? this.rating,
      badgeLabel: badgeLabel ?? this.badgeLabel,
      isFavorite: isFavorite ?? this.isFavorite,
      showPlayOverlay: showPlayOverlay ?? this.showPlayOverlay,
      showExternalLinkIcon:
          showExternalLinkIcon ?? this.showExternalLinkIcon,
    );
  }
}

class VisitedStat {
  final String id;
  final String label;
  final String value;
  final Color accentColor;

  const VisitedStat({
    required this.id,
    required this.label,
    required this.value,
    required this.accentColor,
  });

  VisitedStat copyWith({
    String? id,
    String? label,
    String? value,
    Color? accentColor,
  }) {
    return VisitedStat(
      id: id ?? this.id,
      label: label ?? this.label,
      value: value ?? this.value,
      accentColor: accentColor ?? this.accentColor,
    );
  }
}

class VisitedTrip {
  final String id;
  final String monthLabel;
  final String title;
  final String subtitle;
  final int placesCount;
  final String imagePath;

  const VisitedTrip({
    required this.id,
    required this.monthLabel,
    required this.title,
    required this.subtitle,
    required this.placesCount,
    required this.imagePath,
  });

  VisitedTrip copyWith({
    String? id,
    String? monthLabel,
    String? title,
    String? subtitle,
    int? placesCount,
    String? imagePath,
  }) {
    return VisitedTrip(
      id: id ?? this.id,
      monthLabel: monthLabel ?? this.monthLabel,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      placesCount: placesCount ?? this.placesCount,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

class CollectionItem {
  final String id;
  final String title;
  final String subtitle;
  final String imagePath;
  final int placesCount;

  const CollectionItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.placesCount,
  });
}

class RecentPlace {
  final String id;
  final String name;
  final String address;
  final double rating;
  final String imagePath;

  const RecentPlace({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.imagePath,
  });
}

class CollectionChoice {
  final String id;
  final String name;
  final int itemCount;
  final SavedCollectionIconType iconType;

  const CollectionChoice({
    required this.id,
    required this.name,
    required this.itemCount,
    required this.iconType,
  });
}

class TimelineMonth {
  final String title;
  final List<TimelineEntry> entries;

  const TimelineMonth({
    required this.title,
    required this.entries,
  });
}

class TimelineEntry {
  final String id;
  final String placeName;
  final String visitedAt;
  final String note;
  final String imagePath;
  final List<String> tags;

  const TimelineEntry({
    required this.id,
    required this.placeName,
    required this.visitedAt,
    required this.note,
    required this.imagePath,
    required this.tags,
  });
}

class CollectionEditorDraft {
  final String title;
  final String description;
  final String coverImagePath;
  final List<TravelBuddy> travelBuddies;
  final List<EditableCollectionPlace> places;

  const CollectionEditorDraft({
    required this.title,
    required this.description,
    required this.coverImagePath,
    required this.travelBuddies,
    required this.places,
  });
}

class TravelBuddy {
  final String name;
  final String? imagePath;
  final bool isOnline;
  final bool isInviteAction;

  const TravelBuddy({
    required this.name,
    this.imagePath,
    this.isOnline = false,
    this.isInviteAction = false,
  });
}

class EditableCollectionPlace {
  final String id;
  final String name;
  final String subtitle;
  final String imagePath;

  const EditableCollectionPlace({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.imagePath,
  });
}
