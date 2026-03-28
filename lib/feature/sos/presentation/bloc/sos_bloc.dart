import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/sos_feed.dart';
import '../../domain/usecases/get_sos_feed_usecase.dart';

part 'sos_event.dart';
part 'sos_state.dart';

class SosBloc extends Bloc<SosEvent, SosState> {
  final GetSosFeedUseCase getSosFeedUseCase;

  SosBloc({
    required this.getSosFeedUseCase,
  }) : super(const SosState()) {
    on<SosStarted>(_onStarted);
    on<SosComposerOpened>(_onComposerOpened);
    on<SosBackPressed>(_onBackPressed);
    on<SosEmergencyTypeSelected>(_onEmergencyTypeSelected);
    on<SosVisibilityScopeSelected>(_onVisibilityScopeSelected);
    on<SosDescriptionChanged>(_onDescriptionChanged);
    on<SosAlertSubmitted>(_onAlertSubmitted);
    on<SosMarkedSafe>(_onMarkedSafe);
  }

  Future<void> _onStarted(
    SosStarted event,
    Emitter<SosState> emit,
  ) async {
    emit(state.copyWith(status: SosStatus.loading));

    try {
      final feed = await getSosFeedUseCase();
      emit(
        state.copyWith(
          status: SosStatus.success,
          feed: feed,
          viewStep: SosViewStep.intro,
          description: '',
          errorMessage: null,
          isSendingAlert: false,
          showActiveResponders: false,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: SosStatus.failure,
          errorMessage: 'Unable to load SOS screen.',
        ),
      );
    }
  }

  void _onComposerOpened(
    SosComposerOpened event,
    Emitter<SosState> emit,
  ) {
    emit(
      state.copyWith(
        viewStep: SosViewStep.helpComposer,
      ),
    );
  }

  void _onBackPressed(
    SosBackPressed event,
    Emitter<SosState> emit,
  ) {
    switch (state.viewStep) {
      case SosViewStep.intro:
        return;
      case SosViewStep.helpComposer:
        emit(
          state.copyWith(
            viewStep: SosViewStep.intro,
            isSendingAlert: false,
          ),
        );
        return;
      case SosViewStep.activeAlert:
        emit(
          state.copyWith(
            viewStep: SosViewStep.helpComposer,
            showActiveResponders: false,
          ),
        );
        return;
    }
  }

  void _onEmergencyTypeSelected(
    SosEmergencyTypeSelected event,
    Emitter<SosState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updated = currentFeed.helpComposer.emergencyTypes
        .map((item) => item.copyWith(isSelected: item.id == event.typeId))
        .toList(growable: false);

    emit(
      state.copyWith(
        feed: currentFeed.copyWith(
          helpComposer: currentFeed.helpComposer.copyWith(
            emergencyTypes: updated,
          ),
        ),
      ),
    );
  }

  void _onVisibilityScopeSelected(
    SosVisibilityScopeSelected event,
    Emitter<SosState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updated = currentFeed.helpComposer.visibilityScopes
        .map((item) => item.copyWith(isSelected: item.id == event.scopeId))
        .toList(growable: false);

    emit(
      state.copyWith(
        feed: currentFeed.copyWith(
          helpComposer: currentFeed.helpComposer.copyWith(
            visibilityScopes: updated,
          ),
        ),
      ),
    );
  }

  void _onDescriptionChanged(
    SosDescriptionChanged event,
    Emitter<SosState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onAlertSubmitted(
    SosAlertSubmitted event,
    Emitter<SosState> emit,
  ) async {
    emit(
      state.copyWith(
        isSendingAlert: true,
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 450));
    emit(
      state.copyWith(
        isSendingAlert: false,
        viewStep: SosViewStep.activeAlert,
        showActiveResponders: false,
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (isClosed || state.viewStep != SosViewStep.activeAlert) {
      return;
    }

    emit(
      state.copyWith(
        showActiveResponders: true,
      ),
    );
  }

  void _onMarkedSafe(
    SosMarkedSafe event,
    Emitter<SosState> emit,
  ) {
    emit(
      state.copyWith(
        viewStep: SosViewStep.intro,
        description: '',
        isSendingAlert: false,
        showActiveResponders: false,
      ),
    );
  }
}
