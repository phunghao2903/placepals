import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/appointment_feed.dart';
import '../../domain/usecases/get_appointment_feed_usecase.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final GetAppointmentFeedUseCase getAppointmentFeedUseCase;

  AppointmentBloc({
    required this.getAppointmentFeedUseCase,
  }) : super(const AppointmentState()) {
    on<AppointmentStarted>(_onStarted);
    on<AppointmentPlanNameChanged>(_onPlanNameChanged);
    on<AppointmentDescriptionChanged>(_onDescriptionChanged);
    on<AppointmentDateChanged>(_onDateChanged);
    on<AppointmentTimeChanged>(_onTimeChanged);
    on<AppointmentInviteTapped>(_onInviteTapped);
    on<AppointmentInviteesUpdated>(_onInviteesUpdated);
    on<AppointmentInviteeToggled>(_onInviteeToggled);
  }

  Future<void> _onStarted(
    AppointmentStarted event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(status: AppointmentStatus.loading));

    try {
      final feed = await getAppointmentFeedUseCase();
      emit(
        state.copyWith(
          status: AppointmentStatus.success,
          feed: feed,
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: AppointmentStatus.failure,
          errorMessage: 'Unable to load hangout plan.',
        ),
      );
    }
  }

  void _onPlanNameChanged(
    AppointmentPlanNameChanged event,
    Emitter<AppointmentState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    emit(
      state.copyWith(
        status: AppointmentStatus.success,
        feed: currentFeed.copyWith(planName: event.value),
        infoMessage: null,
      ),
    );
  }

  void _onDescriptionChanged(
    AppointmentDescriptionChanged event,
    Emitter<AppointmentState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    emit(
      state.copyWith(
        status: AppointmentStatus.success,
        feed: currentFeed.copyWith(description: event.value),
        infoMessage: null,
      ),
    );
  }

  void _onDateChanged(
    AppointmentDateChanged event,
    Emitter<AppointmentState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    emit(
      state.copyWith(
        status: AppointmentStatus.success,
        feed: currentFeed.copyWith(dateLabel: event.label),
        infoMessage: null,
      ),
    );
  }

  void _onTimeChanged(
    AppointmentTimeChanged event,
    Emitter<AppointmentState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    emit(
      state.copyWith(
        status: AppointmentStatus.success,
        feed: currentFeed.copyWith(timeLabel: event.label),
        infoMessage: null,
      ),
    );
  }

  void _onInviteTapped(
    AppointmentInviteTapped event,
    Emitter<AppointmentState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final nextInvitee = currentFeed.invitees.firstWhere(
      (invitee) => !invitee.isSelected,
      orElse: () => const AppointmentInvitee(
        id: '',
        name: '',
        subtitle: '',
        avatarAssetPath: '',
        isSelected: true,
        isMuted: false,
        showRemoveBadge: false,
      ),
    );

    if (nextInvitee.id.isEmpty) {
      emit(
        state.copyWith(
          status: AppointmentStatus.success,
          feed: currentFeed,
          infoMessage: 'Everyone is already invited.',
        ),
      );
      return;
    }

    final updatedInvitees = currentFeed.invitees
        .map(
          (invitee) => invitee.id == nextInvitee.id
              ? invitee.copyWith(
                  isSelected: true,
                  isMuted: false,
                )
              : invitee,
        )
        .toList(growable: false);

    emit(
      state.copyWith(
        status: AppointmentStatus.success,
        feed: currentFeed.copyWith(invitees: updatedInvitees),
        infoMessage: null,
      ),
    );
  }

  void _onInviteesUpdated(
    AppointmentInviteesUpdated event,
    Emitter<AppointmentState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    emit(
      state.copyWith(
        status: AppointmentStatus.success,
        feed: currentFeed.copyWith(invitees: event.invitees),
        infoMessage: null,
      ),
    );
  }

  void _onInviteeToggled(
    AppointmentInviteeToggled event,
    Emitter<AppointmentState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updatedInvitees = currentFeed.invitees
        .map((invitee) {
          if (invitee.id != event.inviteeId) {
            return invitee;
          }

          final nextSelected = !invitee.isSelected;
          return invitee.copyWith(
            isSelected: nextSelected,
            isMuted: !nextSelected,
          );
        })
        .toList(growable: false);

    if (!updatedInvitees.any((invitee) => invitee.isSelected)) {
      emit(
        state.copyWith(
          status: AppointmentStatus.success,
          feed: currentFeed.copyWith(invitees: updatedInvitees),
          infoMessage: 'Select at least one friend for the hangout.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: AppointmentStatus.success,
        feed: currentFeed.copyWith(invitees: updatedInvitees),
        infoMessage: null,
      ),
    );
  }
}
