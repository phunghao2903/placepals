import 'package:flutter/material.dart';

import '../../domain/entities/savedlist_feed.dart';
import 'saved_mark_visited_page.dart';

class MarkAsVisitedPage extends StatelessWidget {
  final WishlistPlace place;

  const MarkAsVisitedPage({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return SavedMarkVisitedPage(place: place);
  }
}
