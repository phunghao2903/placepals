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
    on<NotificationsFilterSelected>(_onFilterSelected);
    on<NotificationsMarkAllReadRequested>(_onMarkAllReadRequested);
    on<NotificationsItemMarkedAsRead>(_onItemMarkedAsRead);
    on<NotificationsItemTapped>(_onItemTapped);
    on<NotificationsNavigationHandled>(_onNavigationHandled);
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
          filters: feed.filters,
          activeFilterId: _selectedFilterId(feed.filters),
          visibleItems: _applyFilter(
            feed.items,
            _selectedFilterType(feed.filters),
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

  void _onFilterSelected(
    NotificationsFilterSelected event,
    Emitter<NotificationsState> emit,
  ) {
    final feed = state.feed;
    if (feed == null) return;

    final filters = state.filters
        .map((item) => item.copyWith(isSelected: item.id == event.filterId))
        .toList(growable: false);

    emit(
      state.copyWith(
        filters: filters,
        activeFilterId: event.filterId,
        visibleItems: _applyFilter(feed.items, _selectedFilterType(filters)),
      ),
    );
  }

  void _onMarkAllReadRequested(
    NotificationsMarkAllReadRequested event,
    Emitter<NotificationsState> emit,
  ) {
    final feed = state.feed;
    if (feed == null) return;

    final updatedItems = feed.items
        .map((item) => item.copyWith(isRead: true))
        .toList(growable: false);
    final updatedFeed = feed.copyWith(items: updatedItems);

    emit(
      state.copyWith(
        feed: updatedFeed,
        visibleItems: _applyFilter(
          updatedItems,
          _selectedFilterType(state.filters),
        ),
      ),
    );
  }

  void _onItemMarkedAsRead(
    NotificationsItemMarkedAsRead event,
    Emitter<NotificationsState> emit,
  ) {
    final feed = state.feed;
    if (feed == null) return;

    final updatedFeed = _updateItemReadState(
      feed: feed,
      notificationId: event.notificationId,
      isRead: true,
    );

    emit(
      state.copyWith(
        feed: updatedFeed,
        visibleItems: _applyFilter(
          updatedFeed.items,
          _selectedFilterType(state.filters),
        ),
      ),
    );
  }

  void _onItemTapped(
    NotificationsItemTapped event,
    Emitter<NotificationsState> emit,
  ) {
    final feed = state.feed;
    if (feed == null) return;

    final tappedItem = feed.items.firstWhere(
      (item) => item.id == event.notificationId,
    );
    final updatedFeed = _updateItemReadState(
      feed: feed,
      notificationId: event.notificationId,
      isRead: true,
    );

    emit(
      state.copyWith(
        feed: updatedFeed,
        visibleItems: _applyFilter(
          updatedFeed.items,
          _selectedFilterType(state.filters),
        ),
        pendingNavigationTarget: tappedItem.navigationTarget,
        pendingNotificationId: tappedItem.id,
      ),
    );
  }

  void _onNavigationHandled(
    NotificationsNavigationHandled event,
    Emitter<NotificationsState> emit,
  ) {
    emit(
      state.copyWith(
        pendingNavigationTarget: null,
        pendingNotificationId: null,
      ),
    );
  }

  NotificationsFeed _updateItemReadState({
    required NotificationsFeed feed,
    required String notificationId,
    required bool isRead,
  }) {
    final updatedItems = feed.items
        .map(
          (item) =>
              item.id == notificationId ? item.copyWith(isRead: isRead) : item,
        )
        .toList(growable: false);

    return feed.copyWith(items: updatedItems);
  }

  String _selectedFilterId(List<NotificationFilter> filters) {
    return filters.firstWhere((item) => item.isSelected).id;
  }

  NotificationFilterType _selectedFilterType(List<NotificationFilter> filters) {
    return filters.firstWhere((item) => item.isSelected).type;
  }

  List<NotificationItem> _applyFilter(
    List<NotificationItem> items,
    NotificationFilterType filterType,
  ) {
    switch (filterType) {
      case NotificationFilterType.all:
        return items;
      case NotificationFilterType.unread:
        return items.where((item) => !item.isRead).toList(growable: false);
      case NotificationFilterType.sosAlerts:
        return items
            .where((item) => item.type == NotificationItemType.sosAlert)
            .toList(growable: false);
    }
  }
}
