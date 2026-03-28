import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'friend_profile_page.dart';

const Color _findFriendsCanvas = Color(0xFFFFFAF8);
const Color _findFriendsStroke = Color(0xFFF1E6E2);
const Color _findFriendsShadow = Color(0x14111827);
const Color _findFriendsAccent = Color(0xFFFF6B5A);
const Color _findFriendsSearchFill = Color(0xFFFFFFFF);

class FindFriendsPage extends StatefulWidget {
  const FindFriendsPage({super.key});

  @override
  State<FindFriendsPage> createState() => _FindFriendsPageState();
}

class _FindFriendsPageState extends State<FindFriendsPage> {
  static const List<FindFriendUser> _allUsers = <FindFriendUser>[
    FindFriendUser(
      id: 'emma',
      name: 'Emma',
      username: '@emmavii',
      bio: 'Food blogger & travel lover',
      placesCount: 32,
      followersLabel: '4,456 followers',
      isFollowing: false,
      avatarStyle: FindFriendAvatarStyle(
        background: Color(0xFFFFE8E2),
        foreground: Color(0xFF9B5E4B),
        initials: 'E',
      ),
    ),
    FindFriendUser(
      id: 'michael',
      name: 'Michael',
      username: '@michael',
      bio: 'Coffee enthusiast',
      placesCount: 32,
      followersLabel: '4,456 followers',
      isFollowing: true,
      avatarStyle: FindFriendAvatarStyle(
        background: Color(0xFFFFF0E3),
        foreground: Color(0xFF9A5A21),
        initials: 'M',
      ),
    ),
    FindFriendUser(
      id: 'sofia',
      name: 'Sofia',
      username: '@sofia_f',
      bio: 'Discovering hidden gems',
      placesCount: 45,
      followersLabel: '7,789 followers',
      isFollowing: true,
      avatarStyle: FindFriendAvatarStyle(
        background: Color(0xFFE7F4FF),
        foreground: Color(0xFF3F6F9E),
        initials: 'S',
      ),
    ),
    FindFriendUser(
      id: 'james',
      name: 'James',
      username: '@jamesr',
      bio: 'Urban explorer',
      placesCount: 19,
      followersLabel: '2,234 followers',
      isFollowing: true,
      avatarStyle: FindFriendAvatarStyle(
        background: Color(0xFFECECEC),
        foreground: Color(0xFF4B5563),
        initials: 'J',
      ),
    ),
    FindFriendUser(
      id: 'olivia',
      name: 'Olivia',
      username: '@olivia_tr',
      bio: 'Foodie & photographer',
      placesCount: 21,
      followersLabel: '6,912 followers',
      isFollowing: false,
      avatarStyle: FindFriendAvatarStyle(
        background: Color(0xFFFFE9F0),
        foreground: Color(0xFF9D4B6D),
        initials: 'O',
      ),
    ),
    FindFriendUser(
      id: 'daniel',
      name: 'Daniel Kim',
      username: '@dan_kim',
      bio: 'Adventure seeker',
      placesCount: 37,
      followersLabel: '8,612 followers',
      isFollowing: false,
      avatarStyle: FindFriendAvatarStyle(
        background: Color(0xFFE9F7EF),
        foreground: Color(0xFF3D7A57),
        initials: 'D',
      ),
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  late List<FindFriendUser> _users;

  @override
  void initState() {
    super.initState();
    _users = _allUsers;
    _searchController.addListener(_refresh);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final visibleUsers = _users
        .where((user) {
          if (query.isEmpty) {
            return true;
          }

          return user.name.toLowerCase().contains(query) ||
              user.username.toLowerCase().contains(query) ||
              user.bio.toLowerCase().contains(query);
        })
        .toList(growable: false);

    return Scaffold(
      backgroundColor: _findFriendsCanvas,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _FindFriendsHeader(
                foundCount: visibleUsers.length,
                onBack: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 14),
              _FindFriendsSearchField(
                controller: _searchController,
                hasQuery: query.isNotEmpty,
              ),
              const SizedBox(height: 14),
              if (visibleUsers.isEmpty)
                const _EmptySearchState()
              else
                Column(
                  children: visibleUsers
                      .map(
                        (user) => Padding(
                          padding: EdgeInsets.only(
                            bottom: user == visibleUsers.last ? 0 : 12,
                          ),
                          child: _FriendCard(
                            user: user,
                            onOpenProfile: () => _openProfile(user),
                            onToggleFollow: () => _toggleFollow(user.id),
                          ),
                        ),
                      )
                      .toList(growable: false),
                ),
              const SizedBox(height: 14),
              Text(
                'Suggested for you',
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Based on your places and connections',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleFollow(String userId) {
    setState(() {
      _users = _users
          .map(
            (user) => user.id == userId
                ? user.copyWith(isFollowing: !user.isFollowing)
                : user,
          )
          .toList(growable: false);
    });
  }

  void _openProfile(FindFriendUser user) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => FriendProfilePage(user: user)),
    );
  }
}

class _FindFriendsHeader extends StatelessWidget {
  final int foundCount;
  final VoidCallback onBack;

  const _FindFriendsHeader({required this.foundCount, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _CircleBackButton(onTap: onBack),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Find Friends',
                  style: AppTextStyles.heading6.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$foundCount users found',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FindFriendsSearchField extends StatelessWidget {
  final TextEditingController controller;
  final bool hasQuery;

  const _FindFriendsSearchField({
    required this.controller,
    required this.hasQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: _findFriendsSearchFill,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: hasQuery ? _findFriendsAccent : _findFriendsStroke,
        ),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 12),
          const Icon(
            Icons.search_rounded,
            size: 16,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              cursorColor: _findFriendsAccent,
              style: AppTextStyles.caption.copyWith(
                fontSize: 12,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: 'Search by name, username, or bio...',
                hintStyle: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          if (hasQuery)
            IconButton(
              onPressed: controller.clear,
              icon: const Icon(
                Icons.close_rounded,
                size: 16,
                color: AppColors.textSecondary,
              ),
              splashRadius: 18,
            )
          else
            const SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _FriendCard extends StatelessWidget {
  final FindFriendUser user;
  final VoidCallback onOpenProfile;
  final VoidCallback onToggleFollow;

  const _FriendCard({
    required this.user,
    required this.onOpenProfile,
    required this.onToggleFollow,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onOpenProfile,
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _findFriendsStroke),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: _findFriendsShadow,
                blurRadius: 18,
                offset: Offset(0, 12),
                spreadRadius: -14,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _FriendAvatar(style: user.avatarStyle),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                user.name,
                                style: AppTextStyles.body2.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 1),
                              Text(
                                user.username,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        _FollowButton(
                          isFollowing: user.isFollowing,
                          onTap: onToggleFollow,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.bio,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: <Widget>[
                        _MetricText(label: '${user.placesCount} places'),
                        const SizedBox(width: 18),
                        _MetricText(label: user.followersLabel),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onTap;

  const _FollowButton({required this.isFollowing, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          height: 24,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: isFollowing ? const Color(0xFFF5F5F5) : _findFriendsAccent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                isFollowing
                    ? Icons.person_add_alt_1_outlined
                    : Icons.person_add_alt_1_rounded,
                size: 10,
                color: isFollowing ? AppColors.textSecondary : Colors.white,
              ),
              const SizedBox(width: 4),
              Text(
                isFollowing ? 'Following' : 'Follow',
                style: AppTextStyles.caption.copyWith(
                  color: isFollowing ? AppColors.textSecondary : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FriendAvatar extends StatelessWidget {
  final FindFriendAvatarStyle style;

  const _FriendAvatar({required this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: style.background,
        shape: BoxShape.circle,
      ),
      child: Text(
        style.initials,
        style: AppTextStyles.caption.copyWith(
          color: style.foreground,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _MetricText extends StatelessWidget {
  final String label;

  const _MetricText({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.caption.copyWith(
        color: AppColors.textSecondary,
        fontSize: 12,
      ),
    );
  }
}

class _EmptySearchState extends StatelessWidget {
  const _EmptySearchState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _findFriendsStroke),
      ),
      child: Column(
        children: <Widget>[
          const Icon(
            Icons.group_outlined,
            size: 28,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 10),
          Text(
            'No friends matched your search',
            style: AppTextStyles.heading6.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Try searching with a different name or username.',
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CircleBackButton({required this.onTap});

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
            border: Border.all(color: _findFriendsStroke),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class FindFriendUser {
  final String id;
  final String name;
  final String username;
  final String bio;
  final int placesCount;
  final String followersLabel;
  final bool isFollowing;
  final FindFriendAvatarStyle avatarStyle;

  const FindFriendUser({
    required this.id,
    required this.name,
    required this.username,
    required this.bio,
    required this.placesCount,
    required this.followersLabel,
    required this.isFollowing,
    required this.avatarStyle,
  });

  FindFriendUser copyWith({
    String? id,
    String? name,
    String? username,
    String? bio,
    int? placesCount,
    String? followersLabel,
    bool? isFollowing,
    FindFriendAvatarStyle? avatarStyle,
  }) {
    return FindFriendUser(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      placesCount: placesCount ?? this.placesCount,
      followersLabel: followersLabel ?? this.followersLabel,
      isFollowing: isFollowing ?? this.isFollowing,
      avatarStyle: avatarStyle ?? this.avatarStyle,
    );
  }
}

class FindFriendAvatarStyle {
  final Color background;
  final Color foreground;
  final String initials;

  const FindFriendAvatarStyle({
    required this.background,
    required this.foreground,
    required this.initials,
  });
}
