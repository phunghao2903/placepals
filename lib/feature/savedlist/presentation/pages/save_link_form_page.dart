import 'package:flutter/material.dart';

import '../../domain/entities/savedlist_feed.dart';
import 'saved_save_link_page.dart';

class SaveLinkFormPage extends StatelessWidget {
  final List<CollectionChoice> choices;

  const SaveLinkFormPage({
    super.key,
    required this.choices,
  });

  static Route<void> route({required List<CollectionChoice> choices}) {
    return SavedSaveLinkPage.route(choices: choices);
  }

  @override
  Widget build(BuildContext context) {
    return SavedSaveLinkPage(choices: choices);
  }
}
