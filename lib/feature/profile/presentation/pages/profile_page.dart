import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/profile_feed.dart';
import '../bloc/profile_bloc.dart';
import 'profile_settings_page.dart';
import '../widgets/profile_action_tile.dart';
import '../widgets/profile_chip.dart';
import '../widgets/profile_place_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (_) => getIt<ProfileBloc>()..add(const ProfileStarted()),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _ProfileContent.profileCanvas,
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            switch (state.status) {
              case ProfileStatus.initial:
              case ProfileStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ProfileStatus.failure:
                return Center(
                  child: Text(
                    state.errorMessage ?? 'Something went wrong.',
                    style: AppTextStyles.body2,
                  ),
                );
              case ProfileStatus.success:
                final feed = state.feed;
                if (feed == null) {
                  return const SizedBox.shrink();
                }
                return _ProfileContent(feed: feed);
            }
          },
        ),
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  static const Color profileCanvas = Color(0xFFFFFAF8);
  static const Color profileCardStroke = Color(0xFFF5EAE7);
  static const Color profileShadow = Color(0x14111827);
  static const Color profileOrange = Color(0xFFFF6B5A);
  static const Color profileOrangeEnd = Color(0xFFFF6900);
  static const Color profileSoftOrange = Color(0xFFFFE4DE);

  final ProfileFeed feed;

  const _ProfileContent({required this.feed});

  @override
  Widget build(BuildContext context) {
    final visiblePlaces = _resolvePlaces(feed);
    final isGrid = feed.viewMode == ProfileViewMode.grid;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _ProfileHeader(title: feed.title),
          const SizedBox(height: 16),
          _ProfileHero(user: feed.user),
          const SizedBox(height: 16),
          Row(
            children: feed.quickActions
                .map(
                  (action) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: action == feed.quickActions.last ? 0 : 10,
                      ),
                      child: Center(
                        child: ProfileActionTile(
                          label: action.label,
                          iconKey: action.iconKey,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[Color(0xFFFF7F71), Color(0xFFFF6959)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: profileShadow,
                  blurRadius: 18,
                  offset: Offset(0, 14),
                  spreadRadius: -12,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                const _SectionHeader(
                  title: 'This Month',
                  titleColor: Colors.white,
                  trailingColor: Colors.white,
                  icon: Icons.keyboard_arrow_up_rounded,
                ),
                const SizedBox(height: 14),
                Row(
                  children: feed.insights
                      .map(
                        (insight) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: insight == feed.insights.last ? 0 : 10,
                            ),
                            child: _InsightCard(insight: insight),
                          ),
                        ),
                      )
                      .toList(growable: false),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: profileCardStroke),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: profileShadow,
                  blurRadius: 14,
                  offset: Offset(0, 10),
                  spreadRadius: -12,
                ),
              ],
            ),
            child: Row(
              children: feed.tabs
                  .map(
                    (tab) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: tab == feed.tabs.last ? 0 : 4,
                        ),
                        child: ProfileChip(
                          label: tab.label,
                          isSelected: tab.isSelected,
                          height: 36,
                          radius: 14,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          selectedBackgroundColor: profileOrange,
                          unselectedBackgroundColor: Colors.white,
                          selectedForegroundColor: Colors.white,
                          unselectedForegroundColor: AppColors.textPrimary,
                          unselectedBorderColor: Colors.white,
                          selectedFontWeight: FontWeight.w700,
                          unselectedFontWeight: FontWeight.w600,
                          onTap: () {
                            context.read<ProfileBloc>().add(
                              ProfileTabSelected(tabId: tab.id),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              const Icon(
                Icons.place_outlined,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                'Filter by City',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: feed.cityFilters.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final filter = feed.cityFilters[index];
                      return ProfileChip(
                        label: '${filter.label} (${filter.count})',
                        isSelected: filter.isSelected,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        height: 36,
                        radius: 999,
                        selectedBackgroundColor: profileOrange,
                        unselectedBackgroundColor: Colors.white,
                        selectedForegroundColor: Colors.white,
                        unselectedForegroundColor: AppColors.textPrimary,
                        unselectedBorderColor: profileCardStroke,
                        selectedFontWeight: FontWeight.w600,
                        unselectedFontWeight: FontWeight.w500,
                        onTap: () {
                          context.read<ProfileBloc>().add(
                            ProfileCityFilterSelected(filterId: filter.id),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: profileCardStroke),
                ),
                child: const Icon(
                  Icons.more_horiz_rounded,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 34,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: feed.sortOptions.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 6),
                    itemBuilder: (context, index) {
                      final sort = feed.sortOptions[index];
                      return ProfileChip(
                        label: sort.label,
                        isSelected: sort.isSelected,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 34,
                        radius: 10,
                        selectedBackgroundColor: profileSoftOrange,
                        unselectedBackgroundColor: Colors.transparent,
                        selectedForegroundColor: AppColors.textPrimary,
                        unselectedForegroundColor: AppColors.textPrimary,
                        unselectedBorderColor: Colors.transparent,
                        selectedFontWeight: FontWeight.w600,
                        unselectedFontWeight: FontWeight.w500,
                        onTap: () {
                          context.read<ProfileBloc>().add(
                            ProfileSortSelected(sortId: sort.id),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: profileCardStroke),
                ),
                child: Row(
                  children: <Widget>[
                    _ViewToggleButton(
                      icon: Icons.grid_view_rounded,
                      isSelected: isGrid,
                      onTap: () {
                        context.read<ProfileBloc>().add(
                          const ProfileViewModeChanged(
                            viewMode: ProfileViewMode.grid,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 4),
                    _ViewToggleButton(
                      icon: Icons.view_agenda_rounded,
                      isSelected: !isGrid,
                      onTap: () {
                        context.read<ProfileBloc>().add(
                          const ProfileViewModeChanged(
                            viewMode: ProfileViewMode.list,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (isGrid)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: visiblePlaces.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                return ProfilePlaceTile(
                  place: visiblePlaces[index],
                  compact: false,
                );
              },
            )
          else
            Column(
              children: visiblePlaces
                  .map(
                    (place) => Padding(
                      padding: EdgeInsets.only(
                        bottom: place == visiblePlaces.last ? 0 : 12,
                      ),
                      child: ProfilePlaceTile(place: place, compact: true),
                    ),
                  )
                  .toList(growable: false),
            ),
        ],
      ),
    );
  }

  List<ProfilePlaceItem> _resolvePlaces(ProfileFeed feed) {
    final selectedTab = feed.tabs.firstWhere(
      (tab) => tab.isSelected,
      orElse: () => feed.tabs.first,
    );
    final selectedCity = feed.cityFilters.firstWhere(
      (filter) => filter.isSelected,
      orElse: () => feed.cityFilters.first,
    );
    final selectedSort = feed.sortOptions.firstWhere(
      (sort) => sort.isSelected,
      orElse: () => feed.sortOptions.first,
    );

    Iterable<ProfilePlaceItem> result = feed.places;

    if (selectedTab.id == 'saved') {
      result = result.where((place) => place.isSaved);
    }

    if (selectedCity.id != 'all') {
      final cityLabel = selectedCity.label.toLowerCase();
      result = result.where((place) => place.city.toLowerCase() == cityLabel);
    }

    final list = result.toList(growable: false);

    switch (selectedSort.id) {
      case 'views':
        list.sort((a, b) => b.views.compareTo(a.views));
        break;
      case 'rating':
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      default:
        break;
    }

    if (selectedTab.id == 'insights') {
      list.sort((a, b) => b.likes.compareTo(a.likes));
    }

    return list;
  }
}

class _ProfileHeader extends StatelessWidget {
  final String title;

  const _ProfileHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _CircleIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: () => Navigator.of(context).maybePop(),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.heading6.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        _CircleIconButton(
          icon: Icons.settings_outlined,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const ProfileSettingsPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ProfileHero extends StatelessWidget {
  final ProfileUser user;

  const _ProfileHero({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _ProfileContent.profileCardStroke),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: _ProfileContent.profileShadow,
            blurRadius: 24,
            offset: Offset(0, 18),
            spreadRadius: -18,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                height: 96,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  gradient: const LinearGradient(
                    colors: <Color>[
                      Color(0xFFFFE3D6),
                      _ProfileContent.profileOrange,
                      _ProfileContent.profileOrangeEnd,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: -20,
                      top: 14,
                      child: Container(
                        width: 120,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -10,
                      bottom: -6,
                      child: Container(
                        width: 160,
                        height: 72,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(70),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      top: 16,
                      child: Text(
                        'PlacePals',
                        style: AppTextStyles.heading6.copyWith(
                          color: SemanticTextColors.onBrand,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 14,
                      bottom: 14,
                      child: Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.primary,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 16,
                bottom: -28,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      width: 76,
                      height: 76,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: _ProfileContent.profileShadow,
                            blurRadius: 18,
                            offset: Offset(0, 10),
                            spreadRadius: -10,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(user.avatarPath, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _ProfileContent.profileOrange,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.add_a_photo_rounded,
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 38, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  user.name,
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
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  user.bio,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 13,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      user.joinedLabel,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: user.summaryStats
                      .map(
                        (stat) => Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                stat.value,
                                style: AppTextStyles.heading6.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                stat.label,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(growable: false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Color trailingColor;
  final IconData icon;

  const _SectionHeader({
    required this.title,
    this.titleColor = AppColors.textPrimary,
    this.trailingColor = AppColors.textSecondary,
    this.icon = Icons.chevron_right_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: AppTextStyles.heading6.copyWith(
            color: titleColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Icon(icon, size: 18, color: trailingColor),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  final ProfileInsight insight;

  const _InsightCard({required this.insight});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              _iconForInsight(insight.id),
              size: 10,
              color: Colors.white.withValues(alpha: 0.92),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                insight.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          insight.value,
          style: AppTextStyles.heading5.copyWith(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          insight.delta,
          style: AppTextStyles.caption.copyWith(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  IconData _iconForInsight(String id) {
    switch (id) {
      case 'views':
        return Icons.visibility_outlined;
      case 'likes':
        return Icons.favorite_border_rounded;
      case 'followers':
        return Icons.person_add_alt_1_rounded;
      default:
        return Icons.circle_outlined;
    }
  }
}

class _ViewToggleButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ViewToggleButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppSemanticColors.primary : const Color(0xFFF6EFED),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(
          width: 30,
          height: 30,
          child: Center(
            child: Icon(
              icon,
              size: 15,
              color: isSelected
                  ? SemanticTextColors.onBrand
                  : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _ProfileContent.profileCardStroke),
            ),
            child: Icon(icon, size: 18, color: AppColors.textPrimary),
          ),
        ),
      ),
    );
  }
}
