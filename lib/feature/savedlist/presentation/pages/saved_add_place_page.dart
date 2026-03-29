import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/savedlist_feed.dart';
import '../widgets/saved_recent_place_tile.dart';
import '../widgets/saved_search_field.dart';
import '../widgets/save_to_collection_sheet.dart';

class SavedAddPlacePage extends StatefulWidget {
  final List<RecentPlace> nearbyPlaces;
  final List<RecentPlace> recentlyViewedPlaces;
  final List<CollectionChoice> collectionChoices;

  const SavedAddPlacePage({
    super.key,
    required this.nearbyPlaces,
    required this.recentlyViewedPlaces,
    required this.collectionChoices,
  });

  @override
  State<SavedAddPlacePage> createState() => _SavedAddPlacePageState();
}

class _SavedAddPlacePageState extends State<SavedAddPlacePage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final nearby = _filter(widget.nearbyPlaces);
    final recent = _filter(widget.recentlyViewedPlaces);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () => Navigator.of(context).maybePop(),
                    customBorder: const CircleBorder(),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.arrow_back_rounded, size: 28),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Add a Place',
                    style: AppTextStyles.heading5.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              SavedSearchField(
                hintText: 'Search places, cities...',
                trailing: const Icon(
                  Icons.mic_none_rounded,
                  color: Color(0xFFB7AAA6),
                ),
                onChanged: (value) {
                  setState(() {
                    _query = value;
                  });
                },
              ),
              const SizedBox(height: 26),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    _SectionHeader(title: 'Nearby Places', actionLabel: 'See all'),
                    const SizedBox(height: 12),
                    ...nearby.map(
                      (place) => Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: SavedRecentPlaceTile(
                          place: place,
                          onTap: () => _savePlace(place),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const _SectionHeader(title: 'Recently Viewed'),
                    const SizedBox(height: 12),
                    ...recent.map(
                      (place) => Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: SavedRecentPlaceTile(
                          place: place,
                          onTap: () => _savePlace(place),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<RecentPlace> _filter(List<RecentPlace> places) {
    if (_query.trim().isEmpty) return places;
    final normalized = _query.toLowerCase();
    return places
        .where(
          (place) =>
              place.name.toLowerCase().contains(normalized) ||
              place.address.toLowerCase().contains(normalized),
        )
        .toList(growable: false);
  }

  Future<void> _savePlace(RecentPlace place) async {
    final selected = await showSaveToCollectionSheet(
      context,
      placeName: place.name,
      choices: widget.collectionChoices,
    );
    if (!mounted || selected.isEmpty) {
      return;
    }
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;

  const _SectionHeader({required this.title, this.actionLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: AppTextStyles.heading4.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        if (actionLabel != null)
          Text(
            actionLabel!,
            style: AppTextStyles.body2.copyWith(
              color: AppColors.primary,
            ),
          ),
      ],
    );
  }
}
