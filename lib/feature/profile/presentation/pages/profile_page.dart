import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/firebase/firebase_auth_service.dart';
import '../../domain/entities/profile_feed.dart';
import '../bloc/profile_bloc.dart';
import 'find_friends_page.dart';
import 'profile_achievements_page.dart';
import 'profile_privacy_page.dart';
import 'profile_settings_page.dart';
import '../widgets/profile_action_tile.dart';
import '../widgets/profile_chip.dart';
import '../widgets/profile_place_tile.dart';
import '../../../signup_signin/presentation/pages/splash_page.dart';

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
    final selectedTab = _selectedTab(feed);
    final isInsightsTab = selectedTab.id == 'insights';
    final isSavedTab = selectedTab.id == 'saved';
    final selectedCity = _selectedCity(feed);
    final groupedCitySections = _resolveCitySections(feed);
    final showsCitySections =
        selectedTab.id == 'places' && selectedCity.id == 'all';

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
                          onTap: () =>
                              _handleQuickActionTap(context, action),
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
          if (isInsightsTab) ...<Widget>[
            _InsightsDashboard(places: _resolveInsightsPlaces(feed)),
          ] else if (isSavedTab) ...<Widget>[
            _SavedPlacesSection(places: _resolveSavedPlaces(feed)),
          ] else ...<Widget>[
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
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => _showCitySelectorSheet(context),
                    child: Container(
                      width: 40,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: profileCardStroke),
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                    ),
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
            if (showsCitySections)
              Column(
                children: groupedCitySections
                    .map(
                      (section) => Padding(
                        padding: EdgeInsets.only(
                          bottom:
                              section == groupedCitySections.last ? 0 : 18,
                        ),
                        child: _CitySectionPreview(
                          section: section,
                          onViewAll: () {
                            context.read<ProfileBloc>().add(
                              ProfileCityFilterSelected(
                                filterId: section.filter.id,
                              ),
                            );
                          },
                        ),
                      ),
                    )
                    .toList(growable: false),
              )
            else if (isGrid)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: visiblePlaces.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.98,
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
            const SizedBox(height: 28),
            _ProfileLogoutButton(onTap: () => _handleLogout(context)),
          ],
        ],
      ),
    );
  }

  void _handleQuickActionTap(BuildContext context, ProfileQuickAction action) {
    switch (action.id) {
      case 'friends':
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const FindFriendsPage()),
        );
        break;
      case 'achievements':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const ProfileAchievementsPage(),
          ),
        );
        break;
      case 'privacy':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const ProfilePrivacyPage(),
          ),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${action.label} is not implemented yet.')),
        );
        break;
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            'Sign out?',
            style: AppTextStyles.heading4.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          content: Text(
            'Are you sure you want to sign out of your PlacePals account?',
            style: AppTextStyles.body2.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                'Cancel',
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Sign Out',
                style: AppTextStyles.body2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true || !context.mounted) {
      return;
    }

    try {
      await getIt<FirebaseAuthService>().signOut();
      if (!context.mounted) {
        return;
      }
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (_) => const SplashPage(showWhatsNewOnComplete: false),
        ),
        (route) => false,
      );
    } catch (_) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to sign out right now. Please try again.'),
        ),
      );
    }
  }

  List<ProfilePlaceItem> _resolvePlaces(ProfileFeed feed) {
    return _resolvePlacesForFilter(feed: feed);
  }

  List<ProfilePlaceItem> _resolveInsightsPlaces(ProfileFeed feed) {
    return feed.places.take(4).toList(growable: false);
  }

  List<ProfilePlaceItem> _resolveSavedPlaces(ProfileFeed feed) {
    return feed.places
        .where((place) => place.isSaved)
        .toList(growable: false);
  }

  ProfileTabOption _selectedTab(ProfileFeed feed) {
    return feed.tabs.firstWhere(
      (tab) => tab.isSelected,
      orElse: () => feed.tabs.first,
    );
  }

  ProfileFilterOption _selectedCity(ProfileFeed feed) {
    return feed.cityFilters.firstWhere(
      (filter) => filter.isSelected,
      orElse: () => feed.cityFilters.first,
    );
  }

  List<ProfilePlaceItem> _resolvePlacesForFilter({
    required ProfileFeed feed,
    String? overrideCityId,
  }) {
    final selectedTab = _selectedTab(feed);
    final selectedSort = feed.sortOptions.firstWhere(
      (sort) => sort.isSelected,
      orElse: () => feed.sortOptions.first,
    );
    final selectedCity = overrideCityId == null
        ? _selectedCity(feed)
        : feed.cityFilters.firstWhere(
            (filter) => filter.id == overrideCityId,
            orElse: () => feed.cityFilters.first,
          );

    Iterable<ProfilePlaceItem> result = feed.places;

    if (selectedTab.id == 'saved') {
      result = result.where((place) => place.isSaved);
    }

    if (selectedCity.id != 'all') {
      final cityLabel = selectedCity.label.toLowerCase();
      result = result.where(
        (place) => place.city.toLowerCase() == cityLabel,
      );
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

  List<_CitySectionData> _resolveCitySections(ProfileFeed feed) {
    return feed.cityFilters
        .where((filter) => filter.id != 'all')
        .map(
          (filter) => _CitySectionData(
            filter: filter,
            places: _resolvePlacesForFilter(
              feed: feed,
              overrideCityId: filter.id,
            ),
          ),
        )
        .where((section) => section.places.isNotEmpty)
        .toList(growable: false);
  }

  Future<void> _showCitySelectorSheet(BuildContext context) {
    final selectedCity = _selectedCity(feed);

    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: _CitySelectorSheet(
              options: feed.cityFilters,
              selectedFilterId: selectedCity.id,
              onSelected: (filterId) {
                context.read<ProfileBloc>().add(
                  ProfileCityFilterSelected(filterId: filterId),
                );
                Navigator.of(sheetContext).pop();
              },
            ),
          ),
        );
      },
    );
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
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  user.bio,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textPrimary,
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
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          insight.value,
          style: AppTextStyles.heading4.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          insight.delta,
          style: AppTextStyles.caption.copyWith(
            color: Colors.white.withValues(alpha: 0.92),
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

class _ProfileLogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ProfileLogoutButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(18, 18, 16, 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFF0E6E4)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 10,
                offset: Offset(0, 4),
                spreadRadius: -4,
              ),
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 18,
                offset: Offset(0, 12),
                spreadRadius: -8,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1EF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Sign out',
                      style: AppTextStyles.heading6.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'End your current session and return to the welcome screen.',
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.surfaceSoft,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InsightsDashboard extends StatelessWidget {
  final List<ProfilePlaceItem> places;

  const _InsightsDashboard({required this.places});

  @override
  Widget build(BuildContext context) {
    final rankedPlaces = places.take(3).toList(growable: false);
    final averageRating = places.isEmpty
        ? 0.0
        : places
                .map((place) => place.rating)
                .reduce((value, element) => value + element) /
            places.length;
    final totalEngagement = places.fold<int>(
      0,
      (sum, place) => sum + place.views,
    );
    final ratingProgress = (averageRating / 5).clamp(0.0, 1.0).toDouble();
    final engagementProgress =
        (totalEngagement / 1500).clamp(0.0, 1.0).toDouble();

    return Column(
      children: <Widget>[
        _InsightsSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _InsightsSectionTitle(
                icon: Icons.trending_up_rounded,
                title: 'Top Performing Places',
              ),
              const SizedBox(height: 12),
              Column(
                children: rankedPlaces
                    .asMap()
                    .entries
                    .map(
                      (entry) => Padding(
                        padding: EdgeInsets.only(
                          bottom: entry.key == rankedPlaces.length - 1 ? 0 : 12,
                        ),
                        child: _TopPerformerRow(
                          rank: entry.key + 1,
                          place: entry.value,
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _InsightsSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _InsightsSectionTitle(
                icon: Icons.insert_chart_outlined_rounded,
                title: 'Engagement Overview',
              ),
              const SizedBox(height: 12),
              _EngagementMetricBar(
                label: 'Average Rating',
                valueLabel: averageRating.toStringAsFixed(2),
                progress: ratingProgress,
                gradient: const <Color>[
                  BrandColors.primary200,
                  BrandColors.primary500,
                ],
              ),
              const SizedBox(height: 12),
              _EngagementMetricBar(
                label: 'Total Engagement',
                valueLabel: _formatWithCommas(totalEngagement),
                progress: engagementProgress,
                gradient: const <Color>[
                  BrandColors.primary600,
                  BrandColors.primary700,
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InsightsSurface extends StatelessWidget {
  final Widget child;

  const _InsightsSurface({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(21, 21, 21, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3E8E5)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _InsightsSectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _InsightsSectionTitle({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: AppTextStyles.heading6.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _SavedPlacesSection extends StatelessWidget {
  final List<ProfilePlaceItem> places;

  const _SavedPlacesSection({required this.places});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.bookmark_border_rounded,
              size: 14,
              color: BrandColors.primary500,
            ),
            const SizedBox(width: 6),
            Text(
              'Saved Places',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              '${places.length} places',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (places.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _ProfileContent.profileCardStroke),
            ),
            child: Text(
              'No saved places yet.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: places.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.98,
            ),
            itemBuilder: (context, index) {
              return _SavedPlaceTile(place: places[index]);
            },
          ),
      ],
    );
  }
}

class _SavedPlaceTile extends StatelessWidget {
  final ProfilePlaceItem place;

  const _SavedPlaceTile({required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _ProfileContent.profileCardStroke),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: _ProfileContent.profileShadow,
            blurRadius: 16,
            offset: Offset(0, 12),
            spreadRadius: -12,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(place.imagePath, fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: <Color>[
                      Color(0xC2161616),
                      Color(0x5A161616),
                      Color(0x00000000),
                    ],
                    stops: <double>[0, 0.35, 1],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: _SavedBookmarkBadge(
                onTap: () => _showUnsaveDialog(context),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: _SavedRatingBadge(rating: place.rating),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on_outlined,
                        size: 12,
                        color: Colors.white.withValues(alpha: 0.82),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          place.city,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white.withValues(alpha: 0.82),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _savedTitle(place),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
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

  Future<void> _showUnsaveDialog(BuildContext context) async {
    final shouldUnsave = await showDialog<bool>(
      context: context,
      builder: (_) => _UnsavePlaceDialog(
        placeTitle: _savedTitle(place),
      ),
    );

    if (shouldUnsave == true && context.mounted) {
      context.read<ProfileBloc>().add(
        ProfilePlaceSaveToggled(placeId: place.id, isSaved: false),
      );
    }
  }

  String _savedTitle(ProfilePlaceItem place) {
    switch (place.id) {
      case 'bean_bloom':
        return 'Mountain View';
      case 'garden_terrace':
        return 'Ocean Breeze';
      default:
        return place.title;
    }
  }
}

class _SavedBookmarkBadge extends StatelessWidget {
  final VoidCallback onTap;

  const _SavedBookmarkBadge({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x29000000),
                blurRadius: 12,
                offset: Offset(0, 4),
                spreadRadius: -8,
              ),
            ],
          ),
          child: const Icon(
            Icons.bookmark_rounded,
            size: 16,
            color: BrandColors.primary500,
          ),
        ),
      ),
    );
  }
}

class _SavedRatingBadge extends StatelessWidget {
  final double rating;

  const _SavedRatingBadge({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: SemanticSurfaceColors.overlayDark70,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.star_rounded,
            size: 12,
            color: AppColors.warning,
          ),
          const SizedBox(width: 2),
          Text(
            rating.toStringAsFixed(1),
            style: AppTextStyles.caption.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _UnsavePlaceDialog extends StatelessWidget {
  final String placeTitle;

  const _UnsavePlaceDialog({required this.placeTitle});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 56),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _ProfileContent.profileCardStroke),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: _ProfileContent.profileShadow,
              blurRadius: 26,
              offset: Offset(0, 18),
              spreadRadius: -16,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: BrandColors.primary50,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bookmark_border_rounded,
                size: 18,
                color: BrandColors.primary500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Unsave Place?',
              style: AppTextStyles.heading6.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Do you want to remove "$placeTitle" from your saved places?',
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BrandColors.primary500,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Unsave',
                      style: AppTextStyles.body2.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TopPerformerRow extends StatelessWidget {
  final int rank;
  final ProfilePlaceItem place;

  const _TopPerformerRow({
    required this.rank,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: BrandColors.primary200,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$rank',
            style: AppTextStyles.caption.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            place.imagePath,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                place.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.heading7.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${place.views} views \u2022 ${place.likes} likes',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EngagementMetricBar extends StatelessWidget {
  final String label;
  final String valueLabel;
  final double progress;
  final List<Color> gradient;

  const _EngagementMetricBar({
    required this.label,
    required this.valueLabel,
    required this.progress,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              label,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.textPrimary,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Text(
              valueLabel,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                height: 8,
                width: double.infinity,
                color: NeutralColors.neutral100,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: constraints.maxWidth * progress,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: gradient),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

String _formatWithCommas(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();

  for (int index = 0; index < digits.length; index++) {
    final reversedIndex = digits.length - index;
    buffer.write(digits[index]);
    if (reversedIndex > 1 && reversedIndex % 3 == 1) {
      buffer.write(',');
    }
  }

  return buffer.toString();
}

class _CitySectionData {
  final ProfileFilterOption filter;
  final List<ProfilePlaceItem> places;

  const _CitySectionData({
    required this.filter,
    required this.places,
  });
}

class _CitySectionPreview extends StatelessWidget {
  final _CitySectionData section;
  final VoidCallback onViewAll;

  const _CitySectionPreview({
    required this.section,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final previewPlaces = section.places.take(2).toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.location_on_outlined,
              size: 14,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    section.filter.label,
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${section.places.length} places',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: onViewAll,
              style: TextButton.styleFrom(
                foregroundColor: _ProfileContent.profileOrange,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                minimumSize: const Size(0, 28),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'View all',
                style: AppTextStyles.caption.copyWith(
                  color: _ProfileContent.profileOrange,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: previewPlaces.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.98,
          ),
          itemBuilder: (context, index) {
            return ProfilePlaceTile(
              place: previewPlaces[index],
              compact: false,
            );
          },
        ),
      ],
    );
  }
}

class _CitySelectorSheet extends StatelessWidget {
  final List<ProfileFilterOption> options;
  final String selectedFilterId;
  final ValueChanged<String> onSelected;

  const _CitySelectorSheet({
    required this.options,
    required this.selectedFilterId,
    required this.onSelected,
  });

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
            blurRadius: 28,
            offset: Offset(0, 16),
            spreadRadius: -16,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 12, 6),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Select City',
                        style: AppTextStyles.heading6.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Filter places by location',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 14),
            child: Column(
              children: options
                  .map(
                    (option) => Padding(
                      padding: EdgeInsets.only(
                        bottom: option == options.last ? 0 : 10,
                      ),
                      child: _CitySelectorOptionTile(
                        option: option,
                        isSelected: option.id == selectedFilterId,
                        onTap: () => onSelected(option.id),
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }
}

class _CitySelectorOptionTile extends StatelessWidget {
  final ProfileFilterOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _CitySelectorOptionTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? _ProfileContent.profileOrange
                : const Color(0xFFFFFBFA),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : _ProfileContent.profileCardStroke,
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.18)
                      : const Color(0xFFFFF1ED),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: isSelected
                      ? Colors.white
                      : _ProfileContent.profileOrange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      option.label,
                      style: AppTextStyles.body2.copyWith(
                        color: isSelected
                            ? Colors.white
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${option.count} places',
                      style: AppTextStyles.caption.copyWith(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.86)
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Colors.white
                        : _ProfileContent.profileCardStroke,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Center(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: SizedBox(width: 6, height: 6),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
