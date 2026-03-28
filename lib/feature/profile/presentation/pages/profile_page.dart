import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/firebase/firebase_auth_service.dart';
import '../../../../core/firebase/push_notification_service.dart';
import '../../domain/entities/profile_feed.dart';
import '../bloc/profile_bloc.dart';
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
      backgroundColor: AppColors.background,
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
  static const Color _profileCardStroke = Color(0xFFF3F4F6);
  static const Color _profileShadow = Color(0x1A000000);
  static const Color _profileOrange = Color(0xFFFF6B5A);
  static const Color _profileOrangeEnd = Color(0xFFFF6900);
  static const Color _profileSoftOrange = Color(0xFFFFD1CC);
  static const Color _softWhite = Color(0xCCFFFFFF);

  final ProfileFeed feed;

  const _ProfileContent({required this.feed});

  @override
  Widget build(BuildContext context) {
    final visiblePlaces = _resolvePlaces(feed);
    final isGrid = feed.viewMode == ProfileViewMode.grid;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 16, 15, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _ProfileHeader(title: feed.title),
          const SizedBox(height: 18),
          _ProfileHero(user: feed.user),
          const SizedBox(height: 20),
          SizedBox(
            height: 108,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: feed.quickActions.length,
              separatorBuilder: (_, _) => const SizedBox(width: 15),
              itemBuilder: (context, index) {
                final action = feed.quickActions[index];
                return ProfileActionTile(
                  label: action.label,
                  iconKey: action.iconKey,
                );
              },
            ),
          ),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
            decoration: BoxDecoration(
              color: _profileOrange,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: _profileShadow,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                  spreadRadius: -4,
                ),
                BoxShadow(
                  color: _profileShadow,
                  blurRadius: 15,
                  offset: Offset(0, 10),
                  spreadRadius: -3,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                const _SectionHeader(
                  title: 'This Month',
                  titleColor: Colors.white,
                  trailingColor: Colors.white,
                ),
                const SizedBox(height: 18),
                Row(
                  children: feed.insights
                      .map(
                        (insight) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: insight == feed.insights.last ? 0 : 16,
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
          const SizedBox(height: 22),
          SizedBox(
            height: 50,
            child: Row(
              children: feed.tabs
                  .map(
                    (tab) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: tab == feed.tabs.last ? 0 : 10,
                        ),
                        child: ProfileChip(
                          label: tab.label,
                          isSelected: tab.isSelected,
                          height: 40,
                          radius: 14,
                          selectedBackgroundColor: _profileOrange,
                          unselectedBackgroundColor: Colors.transparent,
                          selectedForegroundColor: Colors.white,
                          unselectedForegroundColor: AppColors.textPrimary,
                          unselectedBorderColor: Colors.transparent,
                          selectedFontWeight: FontWeight.w700,
                          unselectedFontWeight: FontWeight.w700,
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
          const SizedBox(height: 22),
          Row(
            children: <Widget>[
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                'Filter by City',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 38.2,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: feed.cityFilters.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final filter = feed.cityFilters[index];
                      return ProfileChip(
                        label: '${filter.label} (${filter.count})',
                        isSelected: filter.isSelected,
                        height: 38.2,
                        radius: 999,
                        selectedBackgroundColor: _profileOrange,
                        unselectedBackgroundColor: Colors.white,
                        selectedForegroundColor: Colors.white,
                        unselectedForegroundColor: AppColors.textPrimary,
                        unselectedBorderColor: const Color(0xFFE8E0DF),
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
              const SizedBox(width: 10),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE8E0DF)),
                ),
                child: const Icon(
                  Icons.expand_more_rounded,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: feed.sortOptions.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final sort = feed.sortOptions[index];
                      return ProfileChip(
                        label: sort.label,
                        isSelected: sort.isSelected,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 44,
                        radius: 10,
                        selectedBackgroundColor: _profileSoftOrange,
                        unselectedBackgroundColor: _softWhite,
                        selectedForegroundColor: AppColors.textPrimary,
                        unselectedForegroundColor: AppColors.textPrimary,
                        unselectedBorderColor: Colors.transparent,
                        selectedFontWeight: FontWeight.w600,
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
              const SizedBox(width: 10),
              Container(
                height: 36,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(18),
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
          const SizedBox(height: 16),
          if (isGrid)
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
      ),
    );
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
      try {
        await getIt<PushNotificationService>()
            .detachCurrentTokenFromCurrentUser();
      } catch (_) {}
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
        const Spacer(),
        Text(
          title,
          style: AppTextStyles.heading3.copyWith(color: AppColors.textPrimary),
        ),
        const Spacer(),
        _CircleIconButton(icon: Icons.settings_outlined, onTap: () {}),
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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _ProfileContent._profileCardStroke),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: _ProfileContent._profileShadow,
            blurRadius: 10,
            offset: Offset(0, 8),
            spreadRadius: -6,
          ),
          BoxShadow(
            color: _ProfileContent._profileShadow,
            blurRadius: 25,
            offset: Offset(0, 20),
            spreadRadius: -5,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                height: 128,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: <Color>[
                      Color(0x00FF6B5A),
                      _ProfileContent._profileOrange,
                      _ProfileContent._profileOrangeEnd,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 24,
                      top: 28,
                      child: Text(
                        'PlacePals',
                        style: AppTextStyles.heading5.copyWith(
                          color: SemanticTextColors.onBrand,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.primary,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 24,
                bottom: -44,
                child: Container(
                  width: 112,
                  height: 112,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: _ProfileContent._profileShadow,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(user.avatarPath, fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 44, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  user.name,
                  style: AppTextStyles.heading6.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.username,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user.bio,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      user.joinedLabel,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 14,
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
                                ),
                              ),
                              const SizedBox(height: 6),
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

  const _SectionHeader({
    required this.title,
    this.titleColor = AppColors.textPrimary,
    this.trailingColor = AppColors.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(title, style: AppTextStyles.heading3.copyWith(color: titleColor)),
        const Spacer(),
        Icon(Icons.chevron_right_rounded, size: 20, color: trailingColor),
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
        Text(
          insight.label,
          style: AppTextStyles.caption.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 18),
        Text(
          insight.value,
          style: AppTextStyles.heading5.copyWith(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          insight.delta,
          style: AppTextStyles.caption.copyWith(color: Colors.white),
        ),
      ],
    );
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
      color: isSelected ? AppSemanticColors.primary : Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 28,
          height: 28,
          child: Icon(
            icon,
            size: 16,
            color: isSelected
                ? SemanticTextColors.onBrand
                : AppColors.textSecondary,
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
      color: AppColors.surfaceSoft,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 20, color: AppColors.textPrimary),
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
