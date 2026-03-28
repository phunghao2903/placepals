import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/savedlist_feed.dart';
import 'saved_add_place_page.dart';
import '../widgets/dashed_outline.dart';

class SavedEditCollectionPage extends StatefulWidget {
  final CollectionItem? initialCollection;
  final CollectionEditorDraft draft;

  const SavedEditCollectionPage({
    super.key,
    this.initialCollection,
    required this.draft,
  });

  static Route<void> route({
    CollectionItem? initialCollection,
    required CollectionEditorDraft draft,
  }) {
    return MaterialPageRoute<void>(
      builder: (_) => SavedEditCollectionPage(
        initialCollection: initialCollection,
        draft: draft,
      ),
    );
  }

  @override
  State<SavedEditCollectionPage> createState() => _SavedEditCollectionPageState();
}

class _SavedEditCollectionPageState extends State<SavedEditCollectionPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.initialCollection?.title ?? widget.draft.title,
    );
    _descriptionController = TextEditingController(
      text: widget.draft.description,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Row(
                children: <Widget>[
                  _TopActionChip(
                    label: 'Cancel',
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  const Spacer(),
                  _TopActionChip(
                    label: 'Done',
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
                children: <Widget>[
                  Text(
                    'Edit Collection',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading5.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          widget.initialCollection?.imagePath ??
                              widget.draft.coverImagePath,
                          height: 136,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          right: 12,
                          bottom: 12,
                          child: FilledButton.icon(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xCCDB7B71),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            icon: const Icon(Icons.photo_camera_outlined, size: 16),
                            label: Text(
                              'Change Cover',
                              style: AppTextStyles.caption.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  _InputLabelField(
                    label: 'Collection Name',
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _InputLabelField(
                    label: 'Description',
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Divider(height: 1, color: Color(0xFF9C9493)),
                  const SizedBox(height: 14),
                  Row(
                    children: <Widget>[
                      Text(
                        'Travel Buddies',
                        style: AppTextStyles.heading6.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Manage',
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 72,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.draft.travelBuddies.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final buddy = widget.draft.travelBuddies[index];
                        return _TravelBuddyChip(buddy: buddy);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Places (${widget.draft.places.length})',
                    style: AppTextStyles.heading6.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...widget.draft.places.map(
                    (place) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F5F5),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              Icons.drag_indicator_rounded,
                              color: Color(0xFF6B7280),
                            ),
                            const SizedBox(width: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                place.imagePath,
                                width: 44,
                                height: 44,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    place.name,
                                    style: AppTextStyles.body1.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: <Widget>[
                                      const Icon(
                                        Icons.location_on_outlined,
                                        size: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 2),
                                      Expanded(
                                        child: Text(
                                          place.subtitle,
                                          style: AppTextStyles.caption.copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.delete_outline_rounded,
                              color: Color(0xFF8B817F),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const SavedAddPlacePage(
                            nearbyPlaces: _fallbackNearbyPlaces,
                            recentlyViewedPlaces: _fallbackRecentlyViewedPlaces,
                            collectionChoices: _fallbackCollectionChoices,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: DashedOutline(
                      color: const Color(0xFF5B524F),
                      radius: 18,
                      dashLength: 7,
                      gapLength: 5,
                      child: SizedBox(
                        height: 52,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Icon(
                                Icons.location_on_outlined,
                                size: 18,
                                color: Color(0xFF9C9493),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Add a place',
                                style: AppTextStyles.body1.copyWith(
                                  color: const Color(0xFF9C9493),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton.icon(
                      onPressed: () => Navigator.of(context).maybePop(),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      icon: const Icon(
                        Icons.save_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Save Changes',
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
          ],
        ),
      ),
    );
  }
}

const List<RecentPlace> _fallbackNearbyPlaces = <RecentPlace>[
  RecentPlace(
    id: 'near-1',
    name: 'Blue Bottle Coffee',
    address: '123 Main St, Downtown',
    rating: 4.8,
    imagePath: 'assets/images/bean_bloom.png',
  ),
  RecentPlace(
    id: 'near-2',
    name: 'Central Park Zoo',
    address: '64th St and 5th Ave',
    rating: 4.5,
    imagePath: 'assets/images/cafe_tan.png',
  ),
];

const List<RecentPlace> _fallbackRecentlyViewedPlaces = <RecentPlace>[
  RecentPlace(
    id: 'recent-1',
    name: 'MoMA',
    address: '11 W 53rd St',
    rating: 4.7,
    imagePath: 'assets/images/map.png',
  ),
  RecentPlace(
    id: 'recent-2',
    name: 'Queens Night Market',
    address: 'Flushing Meadows Corona Park',
    rating: 4.6,
    imagePath: 'assets/images/bean_bloom.png',
  ),
];

const List<CollectionChoice> _fallbackCollectionChoices = <CollectionChoice>[
  CollectionChoice(
    id: 'choice-1',
    name: 'Favorites',
    itemCount: 12,
    iconType: SavedCollectionIconType.heart,
  ),
  CollectionChoice(
    id: 'choice-2',
    name: 'Japan Trip 2024',
    itemCount: 8,
    iconType: SavedCollectionIconType.plane,
  ),
  CollectionChoice(
    id: 'choice-3',
    name: 'Weekend Coffee',
    itemCount: 4,
    iconType: SavedCollectionIconType.coffee,
  ),
];

class _TopActionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _TopActionChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        minimumSize: const Size(0, 24),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InputLabelField extends StatelessWidget {
  final String label;
  final Widget child;

  const _InputLabelField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: AppTextStyles.body1.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F5F5),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: child,
        ),
      ],
    );
  }
}

class _TravelBuddyChip extends StatelessWidget {
  final TravelBuddy buddy;

  const _TravelBuddyChip({required this.buddy});

  @override
  Widget build(BuildContext context) {
    if (buddy.isInviteAction) {
      return Column(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFF3E3224),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add_rounded, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            buddy.name,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      );
    }

    return Column(
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFF4C9AE),
                  width: 1.5,
                ),
              ),
              child: ClipOval(
                child: buddy.imagePath != null
                    ? Image.asset(buddy.imagePath!, fit: BoxFit.cover)
                    : Container(
                        color: const Color(0xFFE5E7EB),
                        alignment: Alignment.center,
                        child: Text(
                          buddy.name.isNotEmpty ? buddy.name[0] : '?',
                          style: AppTextStyles.body1.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
              ),
            ),
            if (buddy.isOnline)
              Positioned(
                right: -1,
                bottom: -1,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          buddy.name,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
