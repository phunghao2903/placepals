import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'find_friends_page.dart';

const Color _friendProfileCanvas = Color(0xFFFFFAF8);
const Color _friendProfileStroke = Color(0xFFF1E6E2);
const Color _friendProfileShadow = Color(0x14111827);
const Color _friendProfileAccent = Color(0xFFFF6B5A);
const Color _friendProfileSoft = Color(0xFFFFF1EE);

class FriendProfilePage extends StatefulWidget {
  final FindFriendUser user;

  const FriendProfilePage({super.key, required this.user});

  @override
  State<FriendProfilePage> createState() => _FriendProfilePageState();
}

class _FriendProfilePageState extends State<FriendProfilePage> {
  bool _isFollowing = true;
  String _selectedTab = 'places';

  late final List<_FriendPlaceCardData> _places;
  late final List<_FriendPlaceCardData> _savedPlaces;

  @override
  void initState() {
    super.initState();
    _isFollowing = widget.user.isFollowing;
    _places = _seedPlaces(widget.user.id);
    _savedPlaces = _seedSavedPlaces(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    final visiblePlaces = _selectedTab == 'places' ? _places : _savedPlaces;

    return Scaffold(
      backgroundColor: _friendProfileCanvas,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _FriendTopBar(
                onBack: () => Navigator.of(context).pop(),
                onMenu: _showMoreMenu,
              ),
              _FriendHero(
                user: widget.user,
                isFollowing: _isFollowing,
                onToggleFollow: () {
                  setState(() {
                    _isFollowing = !_isFollowing;
                  });
                },
                onShare: _showShareDialog,
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: <Widget>[
                    _ProfileTabChip(
                      label: 'Places (${_places.length})',
                      isSelected: _selectedTab == 'places',
                      onTap: () => setState(() => _selectedTab = 'places'),
                    ),
                    const SizedBox(width: 8),
                    _ProfileTabChip(
                      label: 'Saved (${_savedPlaces.length})',
                      isSelected: _selectedTab == 'saved',
                      onTap: () => setState(() => _selectedTab = 'saved'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: visiblePlaces.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.86,
                  ),
                  itemBuilder: (context, index) {
                    return _FriendPlaceCard(place: visiblePlaces[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showShareDialog() async {
    await showDialog<void>(
      context: context,
      barrierColor: const Color(0x66000000),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 36),
          child: _ShareProfileDialog(
            user: widget.user,
            onClose: () => Navigator.of(dialogContext).pop(),
          ),
        );
      },
    );
  }

  Future<void> _showMoreMenu() async {
    final overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox?;
    if (overlay == null) {
      return;
    }

    final result = await showMenu<String>(
      context: context,
      color: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      position: RelativeRect.fromLTRB(
        overlay.size.width - 92,
        112,
        20,
        overlay.size.height - 180,
      ),
      items: const <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'copy',
          child: _PopupActionRow(
            icon: Icons.link_rounded,
            label: 'Copy Profile Link',
          ),
        ),
        PopupMenuItem<String>(
          value: 'report',
          child: _PopupActionRow(
            icon: Icons.flag_outlined,
            label: 'Report User',
          ),
        ),
        PopupMenuItem<String>(
          value: 'block',
          child: _PopupActionRow(
            icon: Icons.block_outlined,
            label: 'Block User',
            color: _friendProfileAccent,
          ),
        ),
      ],
    );

    if (!mounted || result == null) {
      return;
    }

    final message = switch (result) {
      'copy' => 'Profile link copied.',
      'report' => 'Report flow is not implemented yet.',
      'block' => 'Block flow is not implemented yet.',
      _ => null,
    };

    if (message != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  List<_FriendPlaceCardData> _seedPlaces(String userId) {
    return <_FriendPlaceCardData>[
      const _FriendPlaceCardData(
        title: 'Artisan Bakery',
        imagePath: 'assets/images/korea_food.jpeg',
        rating: '4.8',
      ),
      const _FriendPlaceCardData(
        title: 'Rooftop Garden',
        imagePath: 'assets/images/cafe_tan.png',
        rating: '4.9',
      ),
      const _FriendPlaceCardData(
        title: 'Vintage Records',
        imagePath: 'assets/images/bean_bloom.png',
        rating: '4.7',
      ),
      const _FriendPlaceCardData(
        title: 'Sunset Beach Bar',
        imagePath: 'assets/images/cafe_tan.png',
        rating: '4.9',
      ),
    ];
  }

  List<_FriendPlaceCardData> _seedSavedPlaces(String userId) {
    return const <_FriendPlaceCardData>[
      _FriendPlaceCardData(
        title: 'Mountain Lodge',
        imagePath: 'assets/images/map.png',
        rating: '4.9',
      ),
    ];
  }
}

class _FriendTopBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;

  const _FriendTopBar({required this.onBack, required this.onMenu});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Row(
        children: <Widget>[
          _CircleTopButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: onBack,
          ),
          const Spacer(),
          _CircleTopButton(icon: Icons.more_vert_rounded, onTap: onMenu),
        ],
      ),
    );
  }
}

class _FriendHero extends StatelessWidget {
  final FindFriendUser user;
  final bool isFollowing;
  final VoidCallback onToggleFollow;
  final VoidCallback onShare;

  const _FriendHero({
    required this.user,
    required this.isFollowing,
    required this.onToggleFollow,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _friendProfileStroke),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: _friendProfileShadow,
              blurRadius: 20,
              offset: Offset(0, 14),
              spreadRadius: -16,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/images/map.png',
                    height: 72,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: -26,
                  child: Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: user.avatarStyle.background,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: Text(
                      user.avatarStyle.initials,
                      style: AppTextStyles.heading5.copyWith(
                        color: user.avatarStyle.foreground,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 34, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${user.name} Wilson',
                    style: AppTextStyles.heading6.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.username,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${user.bio} ✈️\nExploring the world one plate at a time\nDM for collabs',
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const <Widget>[
                      _FriendStatCard(
                        icon: Icons.place_outlined,
                        value: '32',
                        label: 'Places',
                      ),
                      SizedBox(width: 8),
                      _FriendStatCard(
                        icon: Icons.person_outline_rounded,
                        value: '456',
                        label: 'Followers',
                      ),
                      SizedBox(width: 8),
                      _FriendStatCard(
                        icon: Icons.favorite_border_rounded,
                        value: '234',
                        label: 'Following',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: onToggleFollow,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: _friendProfileAccent,
                            minimumSize: const Size.fromHeight(34),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          icon: Icon(
                            isFollowing
                                ? Icons.person_remove_alt_1_outlined
                                : Icons.person_add_alt_1_rounded,
                            size: 12,
                            color: Colors.white,
                          ),
                          label: Text(
                            isFollowing ? 'Following' : 'Follow',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _CircleAction(icon: Icons.share_outlined, onTap: onShare),
                    ],
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

class _FriendStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _FriendStatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _friendProfileStroke),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: _friendProfileShadow,
              blurRadius: 14,
              offset: Offset(0, 10),
              spreadRadius: -14,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Icon(icon, size: 12, color: _friendProfileAccent),
            const SizedBox(height: 4),
            Text(
              value,
              style: AppTextStyles.heading6.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTabChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ProfileTabChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          height: 28,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected ? _friendProfileAccent : Colors.white,
            borderRadius: BorderRadius.circular(999),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _FriendPlaceCard extends StatelessWidget {
  final _FriendPlaceCardData place;

  const _FriendPlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _friendProfileStroke),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.asset(place.imagePath, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      height: 18,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xE62D2D2D),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.star_rounded,
                            size: 10,
                            color: AppColors.warning,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            place.rating,
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
              child: Text(
                place.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleTopButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleTopButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _friendProfileStroke),
          ),
          child: Icon(icon, size: 14, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _CircleAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleAction({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _friendProfileStroke),
          ),
          child: Icon(icon, size: 14, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _PopupActionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _PopupActionRow({
    required this.icon,
    required this.label,
    this.color = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: color),
        ),
      ],
    );
  }
}

class _ShareProfileDialog extends StatelessWidget {
  final FindFriendUser user;
  final VoidCallback onClose;

  const _ShareProfileDialog({required this.user, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 28,
            offset: Offset(0, 18),
            spreadRadius: -16,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: _friendProfileSoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.share_outlined,
              size: 16,
              color: _friendProfileAccent,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Share Profile',
            style: AppTextStyles.heading6.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Share ${user.name} Wilson\'s profile with your friends',
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F3F1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Profile Link',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'placepal.app/user/${user.id}',
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: _friendProfileAccent,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Copy',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              _ShareApp(
                icon: Icons.facebook,
                label: 'Facebook',
                color: Color(0xFF1877F2),
              ),
              _ShareApp(
                icon: Icons.camera_alt_outlined,
                label: 'Instagram',
                color: Color(0xFFE1306C),
              ),
              _ShareApp(
                icon: Icons.flutter_dash_rounded,
                label: 'Twitter',
                color: Color(0xFF1DA1F2),
              ),
              _ShareApp(
                icon: Icons.message_outlined,
                label: 'Message',
                color: Color(0xFF22C55E),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: onClose,
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFF3F4F6),
                minimumSize: const Size.fromHeight(34),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: Text(
                'Close',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShareApp extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ShareApp({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      child: Column(
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, size: 14, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _FriendPlaceCardData {
  final String title;
  final String imagePath;
  final String rating;

  const _FriendPlaceCardData({
    required this.title,
    required this.imagePath,
    required this.rating,
  });
}
