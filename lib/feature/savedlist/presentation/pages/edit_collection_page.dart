import 'package:flutter/material.dart';

import '../../domain/entities/savedlist_feed.dart';
import 'saved_edit_collection_page.dart';

class EditCollectionPage extends StatelessWidget {
  final CollectionItem? initialCollection;
  final CollectionEditorDraft draft;

  const EditCollectionPage({
    super.key,
    this.initialCollection,
    required this.draft,
  });

  static Route<void> route({
    CollectionItem? initialCollection,
    required CollectionEditorDraft draft,
  }) {
    return SavedEditCollectionPage.route(
      initialCollection: initialCollection,
      draft: draft,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SavedEditCollectionPage(
      initialCollection: initialCollection,
      draft: draft,
    );
  }
}
