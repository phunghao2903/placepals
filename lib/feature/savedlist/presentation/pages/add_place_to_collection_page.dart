import 'package:flutter/material.dart';

import '../../domain/entities/savedlist_feed.dart';
import 'saved_add_place_page.dart';

class AddPlaceToCollectionPage extends StatelessWidget {
  final List<RecentPlace> nearbyPlaces;
  final List<RecentPlace> recentlyViewedPlaces;
  final List<CollectionChoice> collectionChoices;

  const AddPlaceToCollectionPage({
    super.key,
    required this.nearbyPlaces,
    required this.recentlyViewedPlaces,
    required this.collectionChoices,
  });

  @override
  Widget build(BuildContext context) {
    return SavedAddPlacePage(
      nearbyPlaces: nearbyPlaces,
      recentlyViewedPlaces: recentlyViewedPlaces,
      collectionChoices: collectionChoices,
    );
  }
}
