import 'package:flutter/material.dart';

import '../../../../core/core.dart';

const Color _achievementCanvas = Color(0xFFFFFAF8);
const Color _achievementStroke = Color(0xFFF3E8E5);
const Color _achievementShadow = Color(0x14111827);
const Color _achievementAccent = Color(0xFFFF6B5A);
const Color _achievementSoftAccent = Color(0xFFFFF1EE);

class ProfileAchievementsPage extends StatefulWidget {
  const ProfileAchievementsPage({super.key});

  @override
  State<ProfileAchievementsPage> createState() =>
      _ProfileAchievementsPageState();
}

class _ProfileAchievementsPageState extends State<ProfileAchievementsPage> {
  static const List<_AchievementFilter> _filters = <_AchievementFilter>[
    _AchievementFilter(
      id: 'all',
      label: 'All',
      icon: Icons.workspace_premium_outlined,
    ),
    _AchievementFilter(
      id: 'unlocked',
      label: 'Unlocked',
      icon: Icons.verified_rounded,
    ),
    _AchievementFilter(
      id: 'progress',
      label: 'In Progress',
      icon: Icons.timelapse_rounded,
    ),
  ];

  static const List<_AchievementItem> _achievements = <_AchievementItem>[
    _AchievementItem(
      id: 'first_step',
      title: 'First Step',
      subtitle: 'Share your first place',
      progressLabel: '1/1',
      percent: 1,
      icon: Icons.place_outlined,
      iconColor: Colors.white,
      iconBackground: Color(0xFF4D7CFE),
      accentColor: _achievementAccent,
      status: _AchievementStatus.unlocked,
      earnedLabel: 'Dec 15',
    ),
    _AchievementItem(
      id: 'social_butterfly',
      title: 'Social Butterfly',
      subtitle: 'Follow 10 friends',
      progressLabel: '10/10',
      percent: 1,
      icon: Icons.group_outlined,
      iconColor: Colors.white,
      iconBackground: Color(0xFF22C55E),
      accentColor: _achievementAccent,
      status: _AchievementStatus.unlocked,
      earnedLabel: 'Dec 20',
    ),
    _AchievementItem(
      id: 'popular_creator',
      title: 'Popular Creator',
      subtitle: 'Get 50 likes on your places',
      progressLabel: '50/50',
      percent: 1,
      icon: Icons.favorite_border_rounded,
      iconColor: Colors.white,
      iconBackground: Color(0xFFEB5C49),
      accentColor: _achievementAccent,
      status: _AchievementStatus.unlocked,
      earnedLabel: 'Jan 5',
    ),
    _AchievementItem(
      id: 'photographer',
      title: 'Photographer',
      subtitle: 'Upload 20 quality photos',
      progressLabel: '20/20',
      percent: 1,
      icon: Icons.photo_camera_outlined,
      iconColor: Colors.white,
      iconBackground: Color(0xFF2D2D2D),
      accentColor: _achievementAccent,
      status: _AchievementStatus.unlocked,
      earnedLabel: 'Jan 12',
    ),
    _AchievementItem(
      id: 'place_collector',
      title: 'Place Collector',
      subtitle: 'Share 50 places',
      progressLabel: '28/50',
      percent: 0.56,
      icon: Icons.place_outlined,
      iconColor: Colors.white,
      iconBackground: Color(0xFF4D7CFE),
      accentColor: Color(0xFF4D7CFE),
      status: _AchievementStatus.inProgress,
    ),
    _AchievementItem(
      id: 'trendsetter',
      title: 'Trendsetter',
      subtitle: 'Have 5 places featured',
      progressLabel: '2/5',
      percent: 0.40,
      icon: Icons.trending_up_rounded,
      iconColor: Colors.white,
      iconBackground: Color(0xFFF59E0B),
      accentColor: _achievementAccent,
      status: _AchievementStatus.inProgress,
    ),
    _AchievementItem(
      id: 'community_leader',
      title: 'Community Leader',
      subtitle: 'Get 100 followers',
      progressLabel: '67/100',
      percent: 0.67,
      icon: Icons.group_outlined,
      iconColor: Colors.white,
      iconBackground: Color(0xFF22C55E),
      accentColor: Color(0xFF22C55E),
      status: _AchievementStatus.inProgress,
    ),
    _AchievementItem(
      id: 'city_explorer',
      title: 'City Explorer',
      subtitle: 'Visit 10 different cities',
      progressLabel: '6/10',
      percent: 0.60,
      icon: Icons.star_border_rounded,
      iconColor: Colors.white,
      iconBackground: Color(0xFFF59E0B),
      accentColor: Color(0xFFF59E0B),
      status: _AchievementStatus.inProgress,
    ),
    _AchievementItem(
      id: 'legendary',
      title: 'Legendary',
      subtitle: 'Share 100 places',
      progressLabel: '28/100',
      percent: 0.28,
      icon: Icons.emoji_events_outlined,
      iconColor: Colors.white,
      iconBackground: Color(0xFFF59E0B),
      accentColor: Color(0xFF2D2D2D),
      status: _AchievementStatus.inProgress,
    ),
    _AchievementItem(
      id: 'super_star',
      title: 'Super Star',
      subtitle: 'Get 500 total likes',
      progressLabel: '142/500',
      percent: 0.284,
      icon: Icons.star_border_rounded,
      iconColor: Colors.white,
      iconBackground: Color(0xFFF59E0B),
      accentColor: Color(0xFFF59E0B),
      status: _AchievementStatus.inProgress,
    ),
    _AchievementItem(
      id: 'world_traveler',
      title: 'World Traveler',
      subtitle: 'Share places in 20 cities',
      progressLabel: '6/20',
      percent: 0.30,
      icon: Icons.location_on_outlined,
      iconColor: Colors.white,
      iconBackground: Color(0xFF22C55E),
      accentColor: Color(0xFF22C55E),
      status: _AchievementStatus.inProgress,
    ),
    _AchievementItem(
      id: 'influencer',
      title: 'Influencer',
      subtitle: 'Get 1000 followers',
      progressLabel: '67/1000',
      percent: 0.07,
      icon: Icons.trending_up_rounded,
      iconColor: Colors.white,
      iconBackground: Color(0xFFF59E0B),
      accentColor: _achievementAccent,
      status: _AchievementStatus.inProgress,
    ),
  ];

  String _selectedFilterId = 'all';

  @override
  Widget build(BuildContext context) {
    final unlockedCount = _achievements
        .where((item) => item.status == _AchievementStatus.unlocked)
        .length;
    final progress = unlockedCount / _achievements.length;
    final visibleAchievements = _visibleAchievements;

    return Scaffold(
      backgroundColor: _achievementCanvas,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _AchievementsHeader(
                unlockedCount: unlockedCount,
                totalCount: _achievements.length,
              ),
              const SizedBox(height: 16),
              _AchievementsOverviewCard(
                unlockedCount: unlockedCount,
                totalCount: _achievements.length,
                progress: progress,
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    final isSelected = filter.id == _selectedFilterId;

                    return _AchievementFilterChip(
                      filter: filter,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          _selectedFilterId = filter.id;
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
              ListView.separated(
                itemCount: visibleAchievements.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _AchievementCard(item: visibleAchievements[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<_AchievementItem> get _visibleAchievements {
    switch (_selectedFilterId) {
      case 'unlocked':
        return _achievements
            .where((item) => item.status == _AchievementStatus.unlocked)
            .toList(growable: false);
      case 'progress':
        return _achievements
            .where((item) => item.status == _AchievementStatus.inProgress)
            .toList(growable: false);
      default:
        return _achievements;
    }
  }
}

class _AchievementsHeader extends StatelessWidget {
  final int unlockedCount;
  final int totalCount;

  const _AchievementsHeader({
    required this.unlockedCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _CircleActionButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: () => Navigator.of(context).pop(),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Achievements',
                style: AppTextStyles.heading6.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$unlockedCount of $totalCount unlocked',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _achievementAccent,
            borderRadius: BorderRadius.circular(999),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: _achievementShadow,
                blurRadius: 16,
                offset: Offset(0, 10),
                spreadRadius: -12,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.workspace_premium_outlined,
                size: 15,
                color: Colors.white,
              ),
              const SizedBox(width: 4),
              Text(
                '$unlockedCount',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AchievementsOverviewCard extends StatelessWidget {
  final int unlockedCount;
  final int totalCount;
  final double progress;

  const _AchievementsOverviewCard({
    required this.unlockedCount,
    required this.totalCount,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final progressPercent = (progress * 100).round();

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _achievementStroke),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: _achievementShadow,
            blurRadius: 22,
            offset: Offset(0, 16),
            spreadRadius: -16,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Your Progress',
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Keep collecting achievements!',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: _achievementAccent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events_outlined,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: const Color(0xFFF5EFED),
              valueColor: const AlwaysStoppedAnimation<Color>(
                _achievementAccent,
              ),
            ),
          ),
          const SizedBox(height: 7),
          Row(
            children: <Widget>[
              Text(
                'Progress',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                ),
              ),
              const Spacer(),
              Text(
                '$progressPercent%',
                style: AppTextStyles.caption.copyWith(
                  color: _achievementAccent,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$unlockedCount of $totalCount achievements earned',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementFilterChip extends StatelessWidget {
  final _AchievementFilter filter;
  final bool isSelected;
  final VoidCallback onTap;

  const _AchievementFilterChip({
    required this.filter,
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? _achievementSoftAccent : Colors.white,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isSelected ? _achievementAccent : _achievementStroke,
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                filter.icon,
                size: 14,
                color: isSelected
                    ? _achievementAccent
                    : AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                filter.label,
                style: AppTextStyles.caption.copyWith(
                  color: isSelected
                      ? _achievementAccent
                      : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final _AchievementItem item;

  const _AchievementCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final isUnlocked = item.status == _AchievementStatus.unlocked;
    final percentLabel = '${(item.percent * 100).round()}%';

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isUnlocked ? _achievementAccent : _achievementStroke,
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: _achievementShadow,
            blurRadius: 18,
            offset: Offset(0, 12),
            spreadRadius: -14,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: item.iconBackground,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(item.icon, size: 18, color: item.iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.title,
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (isUnlocked && item.earnedLabel != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 1),
                        child: Text(
                          item.earnedLabel!,
                          style: AppTextStyles.caption.copyWith(
                            color: _achievementAccent,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if (isUnlocked)
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Container(
                          width: 18,
                          height: 18,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: _achievementAccent,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.workspace_premium_outlined,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  item.subtitle,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
                if (!isUnlocked) ...<Widget>[
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Text(
                        item.progressLabel,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        percentLabel,
                        style: AppTextStyles.caption.copyWith(
                          color: item.accentColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: item.percent,
                      minHeight: 5,
                      backgroundColor: const Color(0xFFF4EFED),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        item.accentColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _achievementStroke),
          ),
          child: Icon(icon, size: 18, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

enum _AchievementStatus { unlocked, inProgress }

class _AchievementFilter {
  final String id;
  final String label;
  final IconData icon;

  const _AchievementFilter({
    required this.id,
    required this.label,
    required this.icon,
  });
}

class _AchievementItem {
  final String id;
  final String title;
  final String subtitle;
  final String progressLabel;
  final double percent;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final Color accentColor;
  final _AchievementStatus status;
  final String? earnedLabel;

  const _AchievementItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.progressLabel,
    required this.percent,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.accentColor,
    required this.status,
    this.earnedLabel,
  });
}
