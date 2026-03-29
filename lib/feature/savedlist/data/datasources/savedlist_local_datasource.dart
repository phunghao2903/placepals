import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/savedlist_feed.dart';
import '../models/savedlist_feed_model.dart';

abstract class SavedListLocalDataSource {
  Future<SavedListFeedModel> getSavedListFeed();
}

class SavedListLocalDataSourceImpl implements SavedListLocalDataSource {
  @override
  Future<SavedListFeedModel> getSavedListFeed() async {
    await Future<void>.delayed(const Duration(milliseconds: 160));

    return const SavedListFeedModel(
      title: 'Saved',
      tabs: <SavedTabModel>[
        SavedTabModel(type: SavedTabType.wishlist, label: 'Wishlist'),
        SavedTabModel(type: SavedTabType.visited, label: 'Visited'),
        SavedTabModel(type: SavedTabType.collections, label: 'Collections'),
      ],
      wishlistPlaces: <WishlistPlaceModel>[
        WishlistPlaceModel(
          id: 'wish-1',
          name: 'Blue Bottle Coffee',
          subtitle: 'Tokyo, Japan',
          imagePath: 'assets/images/bean_bloom.png',
          rating: 4.8,
          badgeLabel: 'Popular',
        ),
        WishlistPlaceModel(
          id: 'wish-2',
          name: 'Top 10 Tokyo spots',
          subtitle: 'TikTok • 1.4M views',
          imagePath: 'assets/images/cafe_tan.png',
          rating: 4.9,
          badgeLabel: 'Video',
          showPlayOverlay: true,
          showExternalLinkIcon: true,
        ),
        WishlistPlaceModel(
          id: 'wish-3',
          name: 'Central Park',
          subtitle: 'New York, USA',
          imagePath: 'assets/images/map.png',
          rating: 4.7,
        ),
        WishlistPlaceModel(
          id: 'wish-4',
          name: 'Bean Bloom',
          subtitle: 'Seoul, Korea',
          imagePath: 'assets/images/korea_food.jpeg',
          rating: 4.6,
          badgeLabel: 'Cafe',
        ),
        WishlistPlaceModel(
          id: 'wish-5',
          name: 'Cafe Tan',
          subtitle: 'Ho Chi Minh City, Vietnam',
          imagePath: 'assets/images/cafe_tan.png',
          rating: 4.7,
        ),
        WishlistPlaceModel(
          id: 'wish-6',
          name: 'Omakase Sushi',
          subtitle: 'Shibuya, Tokyo',
          imagePath: 'assets/images/bean_bloom.png',
          rating: 4.9,
          badgeLabel: 'Hot',
        ),
      ],
      visitedStats: <VisitedStatModel>[
        VisitedStatModel(
          id: 'visited-countries',
          label: 'Countries',
          value: '3',
          accentColor: AppColors.primary,
        ),
        VisitedStatModel(
          id: 'visited-cities',
          label: 'Cities',
          value: '25',
          accentColor: Color(0xFF8B5CF6),
        ),
        VisitedStatModel(
          id: 'visited-trips',
          label: 'Trips',
          value: '3',
          accentColor: Color(0xFFF59E0B),
        ),
      ],
      visitedTrips: <VisitedTripModel>[
        VisitedTripModel(
          id: 'trip-1',
          monthLabel: 'April 2024',
          title: 'Japan Trip 2024',
          subtitle: 'Tokyo, Osaka, Kyoto',
          placesCount: 8,
          imagePath: 'assets/images/cafe_tan.png',
        ),
        VisitedTripModel(
          id: 'trip-2',
          monthLabel: 'October 2023',
          title: 'Da Nang tour',
          subtitle: 'Da Nang, Vietnam',
          placesCount: 5,
          imagePath: 'assets/images/map.png',
        ),
        VisitedTripModel(
          id: 'trip-3',
          monthLabel: 'June 2023',
          title: 'European Summer',
          subtitle: 'Italy, Greece, Europe',
          placesCount: 12,
          imagePath: 'assets/images/korea_food.jpeg',
        ),
      ],
      collections: <CollectionItemModel>[
        CollectionItemModel(
          id: 'collection-1',
          title: 'Japan trip 24',
          subtitle: 'Tokyo, Japan',
          imagePath: 'assets/images/cafe_tan.png',
          placesCount: 12,
        ),
        CollectionItemModel(
          id: 'collection-2',
          title: 'Da Nang tour',
          subtitle: 'Da Nang, Vietnam',
          imagePath: 'assets/images/map.png',
          placesCount: 5,
        ),
        CollectionItemModel(
          id: 'collection-3',
          title: 'European Summer',
          subtitle: 'Italy, Greece, Europe',
          imagePath: 'assets/images/korea_food.jpeg',
          placesCount: 9,
        ),
      ],
      nearbyPlaces: <RecentPlaceModel>[
        RecentPlaceModel(
          id: 'near-1',
          name: 'Blue Bottle Coffee',
          address: 'Shibuya • 0.3 km away',
          rating: 4.8,
          imagePath: 'assets/images/bean_bloom.png',
        ),
        RecentPlaceModel(
          id: 'near-2',
          name: 'Central Park Zoo',
          address: 'Midtown • 0.9 km away',
          rating: 4.5,
          imagePath: 'assets/images/map.png',
        ),
        RecentPlaceModel(
          id: 'near-3',
          name: 'Nobu Downtown',
          address: 'Tribeca • 1.2 km away',
          rating: 4.7,
          imagePath: 'assets/images/korea_food.jpeg',
        ),
      ],
      recentlyViewedPlaces: <RecentPlaceModel>[
        RecentPlaceModel(
          id: 'recent-1',
          name: 'Queens Night Market',
          address: 'Flushing Meadows',
          rating: 4.6,
          imagePath: 'assets/images/cafe_tan.png',
        ),
        RecentPlaceModel(
          id: 'recent-2',
          name: 'MoMA',
          address: '11 W 53rd St',
          rating: 4.7,
          imagePath: 'assets/images/map.png',
        ),
        RecentPlaceModel(
          id: 'recent-3',
          name: 'Notus Overview',
          address: 'Old Quarter, Hanoi',
          rating: 4.5,
          imagePath: 'assets/images/bean_bloom.png',
        ),
      ],
      collectionChoices: <CollectionChoiceModel>[
        CollectionChoiceModel(
          id: 'choice-1',
          name: 'Favorites',
          itemCount: 12,
          iconType: SavedCollectionIconType.heart,
        ),
        CollectionChoiceModel(
          id: 'choice-2',
          name: 'Japan Trip 2024',
          itemCount: 8,
          iconType: SavedCollectionIconType.plane,
        ),
        CollectionChoiceModel(
          id: 'choice-3',
          name: 'Weekend Coffee',
          itemCount: 4,
          iconType: SavedCollectionIconType.coffee,
        ),
      ],
      timeline: <TimelineMonthModel>[
        TimelineMonthModel(
          title: 'November 2024',
          entries: <TimelineEntryModel>[
            TimelineEntryModel(
              id: 'timeline-1',
              placeName: 'Coffee House',
              visitedAt: 'Shibuya • Nov 18',
              note: 'Loved the quiet vibe and the hand-drip selection.',
              imagePath: 'assets/images/bean_bloom.png',
              tags: <String>['cafe', 'coffee'],
            ),
            TimelineEntryModel(
              id: 'timeline-2',
              placeName: 'Downtown Hotel',
              visitedAt: 'Tokyo • Nov 04',
              note: 'Compact room but perfect location for a weekend walk.',
              imagePath: 'assets/images/cafe_tan.png',
              tags: <String>['stay'],
            ),
          ],
        ),
        TimelineMonthModel(
          title: 'October 2024',
          entries: <TimelineEntryModel>[
            TimelineEntryModel(
              id: 'timeline-3',
              placeName: 'Skyline Bar',
              visitedAt: 'Seoul • Oct 21',
              note: 'Sunset view was worth the wait for a window seat.',
              imagePath: 'assets/images/korea_food.jpeg',
              tags: <String>['bar', 'sunset'],
            ),
          ],
        ),
      ],
      collectionEditorDraft: CollectionEditorDraftModel(
        title: 'Japan Trip 24',
        description: 'A curated list for our Tokyo coffee, food, and day-trip stops.',
        coverImagePath: 'assets/images/cafe_tan.png',
        travelBuddies: <TravelBuddyModel>[
          TravelBuddyModel(
            name: 'Anna',
            imagePath: 'assets/images/profile.jpg',
            isOnline: true,
          ),
          TravelBuddyModel(
            name: 'Minh',
            imagePath: 'assets/images/profile.jpg',
          ),
          TravelBuddyModel(
            name: 'Add',
            isInviteAction: true,
          ),
        ],
        places: <EditableCollectionPlaceModel>[
          EditableCollectionPlaceModel(
            id: 'draft-place-1',
            name: 'Blue Bottle Coffee',
            subtitle: 'Shibuya, Tokyo',
            imagePath: 'assets/images/bean_bloom.png',
          ),
          EditableCollectionPlaceModel(
            id: 'draft-place-2',
            name: 'Tsukiji Market',
            subtitle: 'Chuo City, Tokyo',
            imagePath: 'assets/images/korea_food.jpeg',
          ),
          EditableCollectionPlaceModel(
            id: 'draft-place-3',
            name: 'Gotokuji',
            subtitle: 'Setagaya, Tokyo',
            imagePath: 'assets/images/map.png',
          ),
        ],
      ),
    );
  }
}
