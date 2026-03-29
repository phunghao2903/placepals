import 'package:flutter/material.dart';

import '../../domain/entities/savedlist_feed.dart';
import 'savedlist_feature_page.dart';

class SavedListPage extends StatelessWidget {
  final SavedTabType initialTab;

  const SavedListPage({
    super.key,
    this.initialTab = SavedTabType.wishlist,
  });

  @override
  Widget build(BuildContext context) {
    return SavedListFeaturePage(initialTab: initialTab);
  }
}
