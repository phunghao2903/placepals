import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../map/presentation/pages/map_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../sos/presentation/pages/sos_page.dart';
import '../../domain/entities/notification_item.dart';
import '../bloc/notifications_bloc.dart';
import '../widgets/notification_tab_bar.dart';
import '../widgets/notification_tile.dart';
import '../widgets/notifications_empty_state.dart';

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

enum _NotificationMenuAction { markAllRead }

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<NotificationsBloc, NotificationsState>(
          listenWhen: (previous, current) =>
              previous.pendingNotificationId != current.pendingNotificationId,
          listener: (context, state) {
            final target = state.pendingNavigationTarget;
            if (target == null) return;

            context.read<NotificationsBloc>().add(
              const NotificationsNavigationHandled(),
            );

            switch (target) {
              case NotificationNavigationTarget.profile:
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const ProfilePage()),
                );
              case NotificationNavigationTarget.map:
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const MapPage()),
                );
              case NotificationNavigationTarget.sos:
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const SosPage()),
                );
            }
          },
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
                if (feed == null) return const SizedBox.shrink();
                return _NotificationsContent(title: feed.title, state: state);
            }
          },
        ),
      ),
    );
  }
}

class _NotificationsContent extends StatelessWidget {
  final String title;
  final NotificationsState state;

  const _NotificationsContent({required this.title, required this.state});

  @override
  Widget build(BuildContext context) {
    final groupedSections = _groupNotifications(state.visibleItems);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 26,
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
              PopupMenuButton<_NotificationMenuAction>(
                tooltip: 'Notification actions',
                onSelected: (action) {
                  if (action == _NotificationMenuAction.markAllRead) {
                    context.read<NotificationsBloc>().add(
                      const NotificationsMarkAllReadRequested(),
                    );
                  }
                },
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.tune_rounded,
                  size: 28,
                  color: Color(0xFF101010),
                ),
                itemBuilder: (context) =>
                    <PopupMenuEntry<_NotificationMenuAction>>[
                      PopupMenuItem<_NotificationMenuAction>(
                        value: _NotificationMenuAction.markAllRead,
                        enabled: state.hasUnread,
                        child: Text(
                          'Mark all as read',
                          style: AppTextStyles.body2.copyWith(
                            color: state.hasUnread
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        NotificationTabBar(
          filters: state.filters,
          onSelected: (filterId) {
            context.read<NotificationsBloc>().add(
              NotificationsFilterSelected(filterId: filterId),
            );
          },
        ),
        const SizedBox(height: 22),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: groupedSections.isEmpty
                ? NotificationsEmptyState(
                    key: ValueKey<String>('empty-${state.activeFilterId}'),
                    title: 'You’re all caught up',
                    subtitle: state.activeFilterId == 'unread'
                        ? 'Unread notifications will appear here when something new happens.'
                        : 'There are no notifications in this section right now.',
                  )
                : ListView.builder(
                    key: ValueKey<String>(
                      'list-${state.activeFilterId}-${state.visibleItems.length}',
                    ),
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: groupedSections.length,
                    itemBuilder: (context, index) {
                      final section = groupedSections[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              15,
                              index == 0 ? 0 : 8,
                              15,
                              16,
                            ),
                            child: Text(
                              section.title,
                              style: AppTextStyles.heading4.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ...section.items.map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: NotificationTile(
                                item: item,
                                onTap: () {
                                  context.read<NotificationsBloc>().add(
                                    NotificationsItemTapped(
                                      notificationId: item.id,
                                    ),
                                  );
                                },
                                onMarkAsRead: () {
                                  context.read<NotificationsBloc>().add(
                                    NotificationsItemMarkedAsRead(
                                      notificationId: item.id,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  List<_NotificationSection> _groupNotifications(List<NotificationItem> items) {
    final Map<String, List<NotificationItem>> grouped =
        <String, List<NotificationItem>>{};

    for (final item in items) {
      grouped
          .putIfAbsent(item.sectionLabel, () => <NotificationItem>[])
          .add(item);
    }

    return grouped.entries
        .map(
          (entry) => _NotificationSection(title: entry.key, items: entry.value),
        )
        .toList(growable: false);
  }
}

class _NotificationSection {
  final String title;
  final List<NotificationItem> items;

  const _NotificationSection({required this.title, required this.items});
}
