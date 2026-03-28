import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../map/presentation/pages/map_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../sos/presentation/pages/sos_page.dart';
import '../../domain/entities/notification_item.dart';
import '../../domain/entities/notifications_feed.dart';
import '../bloc/notifications_bloc.dart';
import '../widgets/notification_card.dart';
import '../widgets/notifications_empty_state.dart';
import '../widgets/notifications_filter_tab_bar.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsBloc>(
      create: (_) =>
          getIt<NotificationsBloc>()..add(const NotificationsStarted()),
      child: const _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            switch (state.status) {
              case NotificationsStatus.initial:
              case NotificationsStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case NotificationsStatus.failure:
                return Center(
                  child: Text(
                    state.errorMessage ?? 'Something went wrong.',
                    style: AppTextStyles.body2,
                  ),
                );
              case NotificationsStatus.success:
                final feed = state.feed;
                if (feed == null) {
                  return const SizedBox.shrink();
                }

                return _NotificationsContent(
                  state: state,
                  onOpenActions: () => _showActions(context, state),
                );
            }
          },
        ),
      ),
    );
  }

  Future<void> _showActions(
    BuildContext context,
    NotificationsState state,
  ) async {
    final feed = state.feed;
    if (feed == null) return;

    final hasUnread = feed.notifications.any(
      (notification) => !notification.isRead,
    );

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 46,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceMuted,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 18),
                ListTile(
                  enabled: hasUnread,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.done_all_rounded,
                    color: hasUnread
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                  title: Text(
                    'Mark all as read',
                    style: AppTextStyles.body1.copyWith(
                      color: hasUnread
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                  onTap: !hasUnread
                      ? null
                      : () {
                          Navigator.of(sheetContext).pop();
                          context.read<NotificationsBloc>().add(
                            const NotificationsMarkAllReadRequested(),
                          );
                        },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NotificationsContent extends StatelessWidget {
  final NotificationsState state;
  final VoidCallback onOpenActions;

  const _NotificationsContent({
    required this.state,
    required this.onOpenActions,
  });

  @override
  Widget build(BuildContext context) {
    final feed = state.feed!;
    final visibleNotifications = state.visibleNotifications
        .cast<NotificationItem>();
    final todayItems = visibleNotifications
        .where((item) => item.section == NotificationSection.today)
        .toList(growable: false);
    final yesterdayItems = visibleNotifications
        .where((item) => item.section == NotificationSection.yesterday)
        .toList(growable: false);

    return Column(
      children: <Widget>[
        _NotificationsHeader(
          title: feed.title,
          onBack: () => Navigator.of(context).maybePop(),
          onOpenActions: onOpenActions,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 20, 14, 0),
          child: NotificationsFilterTabBar(
            filters: feed.filters,
            onSelected: (tabId) {
              context.read<NotificationsBloc>().add(
                NotificationsTabSelected(tabId: tabId),
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        Expanded(
          child: visibleNotifications.isEmpty
              ? _buildEmptyState(feed)
              : ListView(
                  padding: const EdgeInsets.only(bottom: 24),
                  children: <Widget>[
                    if (todayItems.isNotEmpty) ...<Widget>[
                      const _SectionTitle(title: 'Today'),
                      ...todayItems.map(
                        (notification) => NotificationCard(
                          notification: notification,
                          onTap: () =>
                              _handleNotificationTap(context, notification),
                        ),
                      ),
                    ],
                    if (yesterdayItems.isNotEmpty) ...<Widget>[
                      const _SectionTitle(title: 'Yesterday'),
                      ...yesterdayItems.map(
                        (notification) => NotificationCard(
                          notification: notification,
                          onTap: () =>
                              _handleNotificationTap(context, notification),
                        ),
                      ),
                    ],
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(NotificationsFeed feed) {
    final selectedTab = feed.filters.firstWhere((filter) => filter.isSelected);

    switch (selectedTab.id) {
      case 'unread':
        return const NotificationsEmptyState(
          title: 'All caught up',
          message: 'You have no unread notifications at the moment.',
        );
      case 'sos':
        return const NotificationsEmptyState(
          title: 'No SOS alerts',
          message: 'Emergency alerts from nearby pals will appear here.',
        );
      case 'all':
      default:
        return const NotificationsEmptyState(
          title: 'No notifications yet',
          message: 'Updates from your pals and places will show up here.',
        );
    }
  }

  void _handleNotificationTap(
    BuildContext context,
    NotificationItem notification,
  ) {
    context.read<NotificationsBloc>().add(
      NotificationsOpened(notificationId: notification.id),
    );

    final Widget destinationPage = switch (notification.destination) {
      NotificationDestination.profile => const ProfilePage(),
      NotificationDestination.map => const MapPage(),
      NotificationDestination.sos => const SosPage(),
    };

    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => destinationPage));
  }
}

class _NotificationsHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onOpenActions;

  const _NotificationsHeader({
    required this.title,
    required this.onBack,
    required this.onOpenActions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
      child: SizedBox(
        height: 51,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: onBack,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 28,
                color: Color(0xFF101010),
              ),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.heading4.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF101010),
                ),
              ),
            ),
            IconButton(
              onPressed: onOpenActions,
              icon: const Icon(
                Icons.tune_rounded,
                size: 27,
                color: Color(0xFF101010),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
      child: Text(
        title,
        style: AppTextStyles.heading4.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
