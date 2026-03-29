import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/help_sos_feed.dart';
import '../../domain/usecases/get_help_sos_feed_usecase.dart';

part 'help_sos_event.dart';
part 'help_sos_state.dart';

class HelpSosBloc extends Bloc<HelpSosEvent, HelpSosState> {
  final GetHelpSosFeedUseCase getHelpSosFeedUseCase;

  HelpSosBloc({
    required this.getHelpSosFeedUseCase,
  }) : super(const HelpSosState()) {
    on<HelpSosStarted>(_onStarted);
    on<HelpSosAlertTypeSelected>(_onAlertTypeSelected);
    on<HelpSosGoToLocationTapped>(_onGoToLocationTapped);
    on<HelpSosCallNowTapped>(_onCallNowTapped);
    on<HelpSosBackPressed>(_onBackPressed);
    on<HelpSosArrivedTapped>(_onArrivedTapped);
    on<HelpSosCallEnded>(_onCallEnded);
  }

  Future<void> _onStarted(
    HelpSosStarted event,
    Emitter<HelpSosState> emit,
  ) async {
    emit(state.copyWith(status: HelpSosStatus.loading));

    try {
      final feed = await getHelpSosFeedUseCase();
      final String selectedId;
      if (feed.alerts.isEmpty) {
        selectedId = '';
      } else {
        final int initialIndex =
            feed.initialAlertIndex.clamp(0, feed.alerts.length - 1) as int;
        selectedId = feed.alerts[initialIndex].id;
      }

      emit(
        state.copyWith(
          status: HelpSosStatus.success,
          feed: feed,
          selectedAlertId: selectedId,
          screen: HelpSosScreen.alert,
          resumeScreen: HelpSosScreen.alert,
          hasArrived: false,
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: HelpSosStatus.failure,
          errorMessage: 'Unable to load Help SOS feature.',
        ),
      );
    }
  }

  void _onAlertTypeSelected(
    HelpSosAlertTypeSelected event,
    Emitter<HelpSosState> emit,
  ) {
    emit(state.copyWith(selectedAlertId: event.alertId));
  }

  void _onGoToLocationTapped(
    HelpSosGoToLocationTapped event,
    Emitter<HelpSosState> emit,
  ) {
    emit(
      state.copyWith(
        screen: HelpSosScreen.rescueMap,
        resumeScreen: HelpSosScreen.rescueMap,
      ),
    );
  }

  void _onCallNowTapped(
    HelpSosCallNowTapped event,
    Emitter<HelpSosState> emit,
  ) {
    emit(
      state.copyWith(
        resumeScreen: state.screen,
        screen: HelpSosScreen.call,
      ),
    );
  }

  void _onBackPressed(
    HelpSosBackPressed event,
    Emitter<HelpSosState> emit,
  ) {
    switch (state.screen) {
      case HelpSosScreen.alert:
        return;
      case HelpSosScreen.rescueMap:
        emit(
          state.copyWith(
            screen: HelpSosScreen.alert,
          ),
        );
        return;
      case HelpSosScreen.call:
        emit(
          state.copyWith(
            screen: state.resumeScreen,
          ),
        );
        return;
    }
  }

  void _onArrivedTapped(
    HelpSosArrivedTapped event,
    Emitter<HelpSosState> emit,
  ) {
    emit(
      state.copyWith(
        hasArrived: true,
      ),
    );
  }

  void _onCallEnded(
    HelpSosCallEnded event,
    Emitter<HelpSosState> emit,
  ) {
    emit(
      state.copyWith(
        screen: state.resumeScreen,
      ),
    );
  }
}
