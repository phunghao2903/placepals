import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/savedlist_feed.dart';
import '../pages/saved_edit_collection_page.dart';
import 'dashed_outline.dart';

Future<List<CollectionChoice>> showSaveToCollectionSheet(
  BuildContext context, {
  required String placeName,
  required List<CollectionChoice> choices,
}) async {
  final parentNavigator = Navigator.of(context);

  final result = await showModalBottomSheet<List<CollectionChoice>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (sheetContext) {
      String? selectedId = choices.isNotEmpty ? choices.first.id : null;

      return StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 48,
                    height: 6,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4B3C2A),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Save to...',
                              style: AppTextStyles.heading2.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              placeName,
                              style: AppTextStyles.body2.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Material(
                        color: const Color(0xFFE5E7EB),
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () => Navigator.of(sheetContext).pop(),
                          child: const SizedBox(
                            width: 42,
                            height: 42,
                            child: Icon(Icons.close_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  ...choices.map((choice) {
                    final style = _choiceStyleFor(choice.iconType);
                    final isSelected = selectedId == choice.id;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () {
                          setState(() {
                            selectedId = choice.id;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9F5F5),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFFFD1CC)
                                  : Colors.transparent,
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: style.backgroundColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  style.icon,
                                  color: style.iconColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      choice.name,
                                      style: AppTextStyles.body1.copyWith(
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${choice.itemCount} saved places',
                                      style: AppTextStyles.body2.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : const Color(0xFFD1D5DB),
                                    width: 1.6,
                                  ),
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.white,
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check_rounded,
                                        size: 14,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 6),
                  InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () async {
                      Navigator.of(sheetContext).pop();
                      await parentNavigator.push(
                        SavedEditCollectionPage.route(draft: _fallbackDraft),
                      );
                    },
                    child: DashedOutline(
                      color: const Color(0xFF5B524F),
                      radius: 18,
                      dashLength: 7,
                      gapLength: 5,
                      child: SizedBox(
                        height: 56,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Icon(
                                Icons.add_rounded,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'New Collection',
                                style: AppTextStyles.body1.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: selectedId == null
                          ? null
                          : () {
                              final selected = choices
                                  .where((choice) => choice.id == selectedId)
                                  .toList(growable: false);
                              Navigator.of(sheetContext).pop(selected);
                            },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        disabledBackgroundColor: const Color(0xFFCFD4DA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: AppTextStyles.body1.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );

  return result ?? const <CollectionChoice>[];
}

class _CollectionChoiceStyle {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const _CollectionChoiceStyle({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });
}

_CollectionChoiceStyle _choiceStyleFor(SavedCollectionIconType type) {
  switch (type) {
    case SavedCollectionIconType.heart:
      return const _CollectionChoiceStyle(
        icon: Icons.favorite_rounded,
        backgroundColor: Color(0xFFFFECE8),
        iconColor: AppColors.primary,
      );
    case SavedCollectionIconType.plane:
      return const _CollectionChoiceStyle(
        icon: Icons.flight_takeoff_rounded,
        backgroundColor: Color(0xFFE8F1FF),
        iconColor: Color(0xFF3B82F6),
      );
    case SavedCollectionIconType.coffee:
      return const _CollectionChoiceStyle(
        icon: Icons.local_cafe_rounded,
        backgroundColor: Color(0xFFFCEBD8),
        iconColor: Color(0xFFF59E0B),
      );
  }
}

const CollectionEditorDraft _fallbackDraft = CollectionEditorDraft(
  title: 'Japan Trip 24',
  description: 'A collection of coffee spots, day trips, and hidden gems.',
  coverImagePath: 'assets/images/cafe_tan.png',
  travelBuddies: <TravelBuddy>[
    TravelBuddy(
      name: 'Anna',
      imagePath: 'assets/images/profile.jpg',
      isOnline: true,
    ),
    TravelBuddy(
      name: 'Minh',
      imagePath: 'assets/images/profile.jpg',
    ),
    TravelBuddy(
      name: 'Add',
      isInviteAction: true,
    ),
  ],
  places: <EditableCollectionPlace>[
    EditableCollectionPlace(
      id: 'fallback-1',
      name: 'Blue Bottle Coffee',
      subtitle: 'Shibuya, Tokyo',
      imagePath: 'assets/images/bean_bloom.png',
    ),
    EditableCollectionPlace(
      id: 'fallback-2',
      name: 'Tsukiji Market',
      subtitle: 'Chuo City, Tokyo',
      imagePath: 'assets/images/korea_food.jpeg',
    ),
  ],
);
