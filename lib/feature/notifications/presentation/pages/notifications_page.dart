import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../help_sos/presentation/pages/help_sos_page.dart';
import '../../domain/entities/notifications_feed.dart';
import '../bloc/notifications_bloc.dart';
import '../widgets/notification_tile.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsBloc>(
      create: (_) => getIt<NotificationsBloc>()..add(const NotificationsStarted()),
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
        child: BlocListener<NotificationsBloc, NotificationsState>(
          listenWhen: (previous, current) =>
              previous.openedNotificationTick != current.openedNotificationTick &&
              current.openedNotificationId != null,
          listener: (context, state) {
            final NotificationsFeed? feed = state.feed;
            final String? openedId = state.openedNotificationId;
            if (feed == null || openedId == null) return;

            final NotificationItem item = feed.items.firstWhere(
              (element) => element.id == openedId,
            );

            if (item.type == 'help_sos') {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const HelpSosPage(),
                ),
              );
            }
          },
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
                  final NotificationsFeed? feed = state.feed;
                  if (feed == null) return const SizedBox.shrink();
                  final visibleItems = state.visibleItems;
                  final sectionLabels = visibleItems
                      .map((item) => item.sectionLabel)
                      .toSet()
                      .toList(growable: false);

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => Navigator.of(context).maybePop(),
                                child: const SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 18,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  feed.title,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.heading5.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: PopupMenuButton<String>(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.more_horiz_rounded,
                                    color: AppColors.textPrimary,
                                  ),
                                  onSelected: (_) {
                                    context.read<NotificationsBloc>().add(
                                          const NotificationsMarkAllReadPressed(),
                                        );
                                  },
                                  itemBuilder: (_) => <PopupMenuEntry<String>>[
                                    PopupMenuItem<String>(
                                      value: 'read-all',
                                      child: Text(
                                        feed.markAllReadLabel,
                                        style: AppTextStyles.body2.copyWith(
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: <Widget>[
                              _NotificationsTab(
                                label: 'All',
                                isSelected:
                                    state.selectedTab == NotificationsFilterTab.all,
                                onTap: () {
                                  context.read<NotificationsBloc>().add(
                                        const NotificationsTabSelected(
                                          tab: NotificationsFilterTab.all,
                                        ),
                                      );
                                },
                              ),
                              const SizedBox(width: 24),
                              _NotificationsTab(
                                label: 'Unread',
                                isSelected:
                                    state.selectedTab == NotificationsFilterTab.unread,
                                onTap: () {
                                  context.read<NotificationsBloc>().add(
                                        const NotificationsTabSelected(
                                          tab: NotificationsFilterTab.unread,
                                        ),
                                      );
                                },
                              ),
                              const SizedBox(width: 24),
                              _NotificationsTab(
                                label: 'SOS Alerts',
                                isSelected: state.selectedTab ==
                                    NotificationsFilterTab.sosAlerts,
                                onTap: () {
                                  context.read<NotificationsBloc>().add(
                                        const NotificationsTabSelected(
                                          tab: NotificationsFilterTab.sosAlerts,
                                        ),
                                      );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Divider(height: 1, color: NeutralColors.neutral300),
                        Expanded(
                          child: visibleItems.isEmpty
                              ? Center(
                                  child: Text(
                                    'No notifications yet.',
                                    style: AppTextStyles.body2.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                                  itemCount: sectionLabels.length,
                                  itemBuilder: (context, sectionIndex) {
                                    final section = sectionLabels[sectionIndex];
                                    final sectionItems = visibleItems
                                        .where((item) => item.sectionLabel == section)
                                        .toList(growable: false);

                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: sectionIndex == sectionLabels.length - 1
                                            ? 0
                                            : 24,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            section,
                                            style: AppTextStyles.heading6.copyWith(
                                              color: AppColors.textPrimary,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 14),
                                          ...List<Widget>.generate(
                                            sectionItems.length,
                                            (index) {
                                              final item = sectionItems[index];
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                  bottom: index == sectionItems.length - 1
                                                      ? 0
                                                      : 10,
                                                ),
                                                child: NotificationTile(
                                                  item: item,
                                                  onTap: () {
                                                    context
                                                        .read<NotificationsBloc>()
                                                        .add(
                                                          NotificationsItemOpened(
                                                            notificationId: item.id,
                                                          ),
                                                        );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _NotificationsTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NotificationsTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: AppTextStyles.body2.copyWith(
              color: isSelected ? AppSemanticColors.primary : AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 18,
            height: 3,
            decoration: BoxDecoration(
              color: isSelected ? AppSemanticColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ],
      ),
    );
  }
}
