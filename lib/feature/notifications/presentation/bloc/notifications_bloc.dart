import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/notifications_feed.dart';
import '../../domain/usecases/get_notifications_feed_usecase.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsFeedUseCase getNotificationsFeedUseCase;

  NotificationsBloc({
    required this.getNotificationsFeedUseCase,
  }) : super(const NotificationsState()) {
    on<NotificationsStarted>(_onStarted);
    on<NotificationsItemOpened>(_onItemOpened);
    on<NotificationsMarkAllReadPressed>(_onMarkAllReadPressed);
    on<NotificationsTabSelected>(_onTabSelected);
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
          selectedTab: NotificationsFilterTab.all,
          openedNotificationId: null,
          openedNotificationTick: 0,
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

  void _onItemOpened(
    NotificationsItemOpened event,
    Emitter<NotificationsState> emit,
  ) {
    final NotificationsFeed? currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedItems = currentFeed.items
        .map(
          (item) => item.id == event.notificationId
              ? item.copyWith(isUnread: false)
              : item,
        )
        .toList(growable: false);

    emit(
      state.copyWith(
        feed: NotificationsFeed(
          title: currentFeed.title,
          markAllReadLabel: currentFeed.markAllReadLabel,
          items: updatedItems,
        ),
        openedNotificationId: event.notificationId,
        openedNotificationTick: state.openedNotificationTick + 1,
      ),
    );
  }

  void _onMarkAllReadPressed(
    NotificationsMarkAllReadPressed event,
    Emitter<NotificationsState> emit,
  ) {
    final NotificationsFeed? currentFeed = state.feed;
    if (currentFeed == null) return;

    emit(
      state.copyWith(
        feed: NotificationsFeed(
          title: currentFeed.title,
          markAllReadLabel: currentFeed.markAllReadLabel,
          items: currentFeed.items
              .map((item) => item.copyWith(isUnread: false))
              .toList(growable: false),
        ),
      ),
    );
  }

  void _onTabSelected(
    NotificationsTabSelected event,
    Emitter<NotificationsState> emit,
  ) {
    emit(
      state.copyWith(
        selectedTab: event.tab,
      ),
    );
  }
}
