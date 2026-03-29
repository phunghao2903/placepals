import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/savedlist_feed.dart';
import '../bloc/savedlist_bloc.dart';
import '../widgets/add_new_option_tile.dart';
import '../widgets/collection_item_card.dart';
import '../widgets/saved_search_field.dart';
import '../widgets/saved_tab_selector.dart';
import '../widgets/visited_stat_tile.dart';
import '../widgets/visited_trip_card.dart';
import '../widgets/wishlist_place_card.dart';
import 'add_place_to_collection_page.dart';
import 'saved_edit_collection_page.dart';
import 'saved_mark_visited_page.dart';
import 'saved_save_link_page.dart';
import 'saved_visited_timeline_page.dart';

class SavedListFeaturePage extends StatelessWidget {
  final SavedTabType initialTab;

  const SavedListFeaturePage({
    super.key,
    this.initialTab = SavedTabType.wishlist,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SavedListBloc>(
      create: (_) =>
          getIt<SavedListBloc>()..add(SavedListStarted(initialTab: initialTab)),
      child: const _SavedListFeatureView(),
    );
  }
}

class _SavedListFeatureView extends StatelessWidget {
  const _SavedListFeatureView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: BlocBuilder<SavedListBloc, SavedListState>(
          builder: (context, state) {
            switch (state.status) {
              case SavedListStatus.initial:
              case SavedListStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case SavedListStatus.failure:
                return Center(
                  child: Text(
                    state.errorMessage ?? 'Unable to load saved places.',
                    style: AppTextStyles.body2,
                  ),
                );
              case SavedListStatus.success:
                final feed = state.feed;
                if (feed == null) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                  child: Column(
                    children: <Widget>[
                      _SavedHeader(
                        title: feed.title,
                        showAddButton: state.activeTab == SavedTabType.wishlist,
                        onAddNew: () => _openWishlistMarkVisited(context, feed),
                      ),
                      const SizedBox(height: 16),
                      SavedTabSelector(
                        tabs: feed.tabs,
                        activeTab: state.activeTab,
                        onTabChanged: (tab) {
                          context.read<SavedListBloc>().add(
                            SavedListTabChanged(tab: tab),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      SavedSearchField(
                        hintText: _searchHintForTab(state.activeTab),
                        onChanged: (value) {
                          context.read<SavedListBloc>().add(
                            SavedListSearchChanged(query: value),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          child: switch (state.activeTab) {
                            SavedTabType.wishlist => _WishlistTab(
                              key: const ValueKey<String>('wishlist'),
                              places: _filterWishlist(
                                feed.wishlistPlaces,
                                state.searchQuery,
                              ),
                              choices: feed.collectionChoices,
                            ),
                            SavedTabType.visited => _VisitedTab(
                              key: const ValueKey<String>('visited'),
                              stats: feed.visitedStats,
                              trips: _filterTrips(
                                feed.visitedTrips,
                                state.searchQuery,
                              ),
                              timeline: feed.timeline,
                              collectionChoices: feed.collectionChoices,
                            ),
                            SavedTabType.collections => _CollectionsTab(
                              key: const ValueKey<String>('collections'),
                              collections: _filterCollections(
                                feed.collections,
                                state.searchQuery,
                              ),
                              draft: feed.collectionEditorDraft,
                              nearbyPlaces: feed.nearbyPlaces,
                              recentlyViewedPlaces: feed.recentlyViewedPlaces,
                              collectionChoices: feed.collectionChoices,
                            ),
                          },
                        ),
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  List<WishlistPlace> _filterWishlist(List<WishlistPlace> items, String query) {
    if (query.trim().isEmpty) return items;
    final normalized = query.toLowerCase();
    return items
        .where(
          (item) =>
              item.name.toLowerCase().contains(normalized) ||
              item.subtitle.toLowerCase().contains(normalized),
        )
        .toList(growable: false);
  }

  List<VisitedTrip> _filterTrips(List<VisitedTrip> items, String query) {
    if (query.trim().isEmpty) return items;
    final normalized = query.toLowerCase();
    return items
        .where(
          (item) =>
              item.title.toLowerCase().contains(normalized) ||
              item.subtitle.toLowerCase().contains(normalized),
        )
        .toList(growable: false);
  }

  List<CollectionItem> _filterCollections(
    List<CollectionItem> items,
    String query,
  ) {
    if (query.trim().isEmpty) return items;
    final normalized = query.toLowerCase();
    return items
        .where(
          (item) =>
              item.title.toLowerCase().contains(normalized) ||
              item.subtitle.toLowerCase().contains(normalized),
        )
        .toList(growable: false);
  }

  String _searchHintForTab(SavedTabType tab) {
    switch (tab) {
      case SavedTabType.wishlist:
        return 'Search your saved places...';
      case SavedTabType.visited:
        return 'Search visited places...';
      case SavedTabType.collections:
        return 'Search your collections';
    }
  }

  Future<void> _openWishlistMarkVisited(
    BuildContext context,
    SavedListFeed feed,
  ) async {
    if (feed.wishlistPlaces.isEmpty) return;

    final selectedPlace = feed.wishlistPlaces.first;
    final marked = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => SavedMarkVisitedPage(place: selectedPlace),
      ),
    );

    if (!context.mounted || marked != true) return;
    context.read<SavedListBloc>().add(
      SavedListPlaceMarkedVisited(placeId: selectedPlace.id),
    );
  }
}

class _SavedHeader extends StatelessWidget {
  final String title;
  final bool showAddButton;
  final VoidCallback onAddNew;

  const _SavedHeader({
    required this.title,
    required this.showAddButton,
    required this.onAddNew,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 40,
            height: 40,
            child: Navigator.of(context).canPop()
                ? Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: AppTextStyles.heading5.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          if (showAddButton)
            Material(
              color: const Color(0xFFE9E9EB),
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onAddNew,
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(Icons.add_rounded, color: AppColors.textPrimary),
                ),
              ),
            )
          else
            const SizedBox(width: 40, height: 40),
        ],
      ),
    );
  }
}

class _WishlistTab extends StatelessWidget {
  final List<WishlistPlace> places;
  final List<CollectionChoice> choices;

  const _WishlistTab({
    super.key,
    required this.places,
    required this.choices,
  });

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return const _EmptyState(
        title: 'No saved places yet',
        subtitle: 'Tap the heart icon on home to save your first place.',
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 18,
        childAspectRatio: 0.88,
      ),
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return WishlistPlaceCard(
          place: place,
          onToggleFavorite: () {
            context.read<SavedListBloc>().add(
              SavedListWishlistToggled(placeId: place.id),
            );
          },
        );
      },
    );
  }
}

class _VisitedTab extends StatelessWidget {
  final List<VisitedStat> stats;
  final List<VisitedTrip> trips;
  final List<TimelineMonth> timeline;
  final List<CollectionChoice> collectionChoices;

  const _VisitedTab({
    super.key,
    required this.stats,
    required this.trips,
    required this.timeline,
    required this.collectionChoices,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Row(
          children: stats
              .map(
                (stat) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: stat == stats.last ? 0 : 12),
                    child: VisitedStatTile(stat: stat),
                  ),
                ),
              )
              .toList(growable: false),
        ),
        const SizedBox(height: 24),
        GridView.builder(
          itemCount: trips.length + 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 24,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            if (index == 0) {
              return VisitedTripCard(
                trip: const VisitedTrip(
                  id: 'add-trip',
                  monthLabel: '',
                  title: '',
                  subtitle: '',
                  placesCount: 0,
                  imagePath: '',
                ),
                isAddPlaceholder: true,
                onTap: trips.isEmpty
                    ? null
                    : () => _openAddNewTripSheet(context),
              );
            }

            final trip = trips[index - 1];
            return VisitedTripCard(
              trip: trip,
              showBookmarkIcon: index == 1,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => SavedVisitedTimelinePage(timeline: timeline),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Future<void> _openAddNewTripSheet(BuildContext context) async {
    final options = trips.take(3).toList(growable: false);
    final selectedTrip = await showModalBottomSheet<VisitedTrip>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 48,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Text(
                      'Add New',
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 30,
                      ),
                    ),
                    const Spacer(),
                    Material(
                      color: const Color(0xFFE5E7EB),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => Navigator.of(context).pop(),
                        child: const SizedBox(
                          width: 44,
                          height: 44,
                          child: Icon(Icons.close_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...options.map(
                  (trip) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AddNewOptionTile(
                      icon: Icons.location_on_outlined,
                      title: trip.title,
                      subtitle: trip.subtitle,
                      iconBackground: const Color(0xFFFDE6C8),
                      iconColor: const Color(0xFFF97316),
                      onTap: () => Navigator.of(context).pop(trip),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (!context.mounted || selectedTrip == null) return;
    await Navigator.of(context).push(
      SavedSaveLinkPage.route(
        choices: collectionChoices,
        title: 'Save timeline',
        firstFieldLabel: 'Caption',
        firstFieldInitialValue: '',
        firstFieldHintText: 'Add caption',
        showPasteIcon: false,
        actionButtonLabel: 'Save to timeline',
        saveToCollectionOnSubmit: false,
      ),
    );
  }
}

class _CollectionsTab extends StatelessWidget {
  final List<CollectionItem> collections;
  final CollectionEditorDraft draft;
  final List<RecentPlace> nearbyPlaces;
  final List<RecentPlace> recentlyViewedPlaces;
  final List<CollectionChoice> collectionChoices;

  const _CollectionsTab({
    super.key,
    required this.collections,
    required this.draft,
    required this.nearbyPlaces,
    required this.recentlyViewedPlaces,
    required this.collectionChoices,
  });

  @override
  Widget build(BuildContext context) {
    if (collections.isEmpty) {
      return const _EmptyState(
        title: 'No collections found',
        subtitle: 'Create a collection to organize your saved places.',
      );
    }

    return ListView(
      children: <Widget>[
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => AddPlaceToCollectionPage(
                  nearbyPlaces: nearbyPlaces,
                  recentlyViewedPlaces: recentlyViewedPlaces,
                  collectionChoices: collectionChoices,
                ),
              ),
            );
          },
          child: Container(
            height: 76,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: BoxDecoration(
              color: const Color(0x1AFF6B5A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0x33FF6B5A)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Create New',
                        style: AppTextStyles.body1.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Organize your next adventure',
                        style: AppTextStyles.caption.copyWith(
                          color: const Color(0xFFFF9C90),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add_rounded, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        ...collections.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: CollectionItemCard(
              item: item,
              onTap: () {
                Navigator.of(context).push(
                  SavedEditCollectionPage.route(
                    initialCollection: item,
                    draft: draft,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;

  const _EmptyState({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E8EB),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(
                Icons.bookmark_border_rounded,
                color: Color(0xFF9C9493),
                size: 32,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: AppTextStyles.heading3.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
