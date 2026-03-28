import 'package:flutter/material.dart';

import '../../domain/entities/savedlist_feed.dart';
import 'saved_visited_timeline_page.dart';

class VisitedTimelinePage extends StatelessWidget {
  final List<TimelineMonth> timeline;

  const VisitedTimelinePage({
    super.key,
    required this.timeline,
  });

  @override
  Widget build(BuildContext context) {
    return SavedVisitedTimelinePage(timeline: timeline);
  }
}
