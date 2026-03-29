import 'package:flutter/material.dart';

import '../../domain/entities/savedlist_feed.dart';
import 'saved_recent_place_tile.dart';

class RecentPlaceTile extends StatelessWidget {
  final RecentPlace place;
  final VoidCallback onTap;
  final bool showTrailingAdd;

  const RecentPlaceTile({
    super.key,
    required this.place,
    required this.onTap,
    this.showTrailingAdd = true,
  });

  @override
  Widget build(BuildContext context) {
    return SavedRecentPlaceTile(
      place: place,
      onTap: onTap,
      showTrailingAdd: showTrailingAdd,
    );
  }
}
