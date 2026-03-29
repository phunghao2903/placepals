import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/notification_filter.dart';
import '../../domain/entities/notification_item.dart';
import '../../domain/entities/notifications_feed.dart';
import '../../domain/usecases/get_notifications_feed_usecase.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsFeedUseCase getNotificationsFeedUseCase;

  NotificationsBloc({required this.getNotificationsFeedUseCase})
    : super(const NotificationsState()) {
    on<NotificationsStarted>(_onStarted);
    on<NotificationsTabSelected>(_onTabSelected);
    on<NotificationsOpened>(_onOpened);
    on<NotificationsMarkAllReadRequested>(_onMarkAllReadRequested);
  }

  Future<void> _onStarted(
    NotificationsStarted event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(state.copyWith(status: NotificationsStatus.loading));

    try {
      final feed = await getNotificationsFeedUseCase();
      emit(
        state.copyWith(
          status: NotificationsStatus.success,
          feed: feed,
          visibleNotifications: _filterNotifications(
            notifications: feed.notifications,
            selectedTabId: _selectedTabId(feed.filters),
          ),
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: NotificationsStatus.failure,
          errorMessage: 'Unable to load notifications.',
        ),
      );
    }
  }

  void _onTabSelected(
    NotificationsTabSelected event,
    Emitter<NotificationsState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedFilters = currentFeed.filters
        .map((filter) => filter.copyWith(isSelected: filter.id == event.tabId))
        .toList(growable: false);

    final updatedFeed = currentFeed.copyWith(filters: updatedFilters);
    emit(
      state.copyWith(
        feed: updatedFeed,
        visibleNotifications: _filterNotifications(
          notifications: updatedFeed.notifications,
          selectedTabId: event.tabId,
        ),
      ),
    );
  }

  void _onOpened(NotificationsOpened event, Emitter<NotificationsState> emit) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedNotifications = currentFeed.notifications
        .map((notification) {
          if (notification.id != event.notificationId) {
            return notification;
          }

          return notification.copyWith(isRead: true);
        })
        .toList(growable: false);

    final updatedFeed = currentFeed.copyWith(
      notifications: updatedNotifications,
    );
    emit(
      state.copyWith(
        feed: updatedFeed,
        visibleNotifications: _filterNotifications(
          notifications: updatedFeed.notifications,
          selectedTabId: _selectedTabId(updatedFeed.filters),
        ),
      ),
    );
  }

  void _onMarkAllReadRequested(
    NotificationsMarkAllReadRequested event,
    Emitter<NotificationsState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedNotifications = currentFeed.notifications
        .map((notification) => notification.copyWith(isRead: true))
        .toList(growable: false);

    final updatedFeed = currentFeed.copyWith(
      notifications: updatedNotifications,
    );
    emit(
      state.copyWith(
        feed: updatedFeed,
        visibleNotifications: _filterNotifications(
          notifications: updatedFeed.notifications,
          selectedTabId: _selectedTabId(updatedFeed.filters),
        ),
      ),
    );
  }

  String _selectedTabId(List<NotificationFilter> filters) {
    return filters.firstWhere((filter) => filter.isSelected).id;
  }

  List<NotificationItem> _filterNotifications({
    required List<NotificationItem> notifications,
    required String selectedTabId,
  }) {
    switch (selectedTabId) {
      case 'unread':
        return notifications
            .where((notification) => !notification.isRead)
            .toList(growable: false);
      case 'sos':
        return notifications
            .where(
              (notification) => notification.type == NotificationType.sosAlert,
            )
            .toList(growable: false);
      case 'all':
      default:
        return notifications;
    }
  }
}
