import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/sos_feed.dart';
import '../../domain/usecases/get_sos_feed_usecase.dart';

part 'sos_event.dart';
part 'sos_state.dart';

class SosBloc extends Bloc<SosEvent, SosState> {
  final GetSosFeedUseCase getSosFeedUseCase;

  SosBloc({required this.getSosFeedUseCase}) : super(const SosState()) {
    on<SosStarted>(_onStarted);
    on<SosEmergencyTypeSelected>(_onEmergencyTypeSelected);
    on<SosVisibilityScopeSelected>(_onVisibilityScopeSelected);
    on<SosDescriptionChanged>(_onDescriptionChanged);
  }

  Future<void> _onStarted(SosStarted event, Emitter<SosState> emit) async {
    emit(state.copyWith(status: SosStatus.loading));

    try {
      final feed = await getSosFeedUseCase();
      emit(
        state.copyWith(
          status: SosStatus.success,
          feed: feed,
          errorMessage: null,
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

  void _onEmergencyTypeSelected(
    SosEmergencyTypeSelected event,
    Emitter<SosState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updated = currentFeed.emergencyTypes
        .map((item) => item.copyWith(isSelected: item.id == event.typeId))
        .toList(growable: false);

    emit(state.copyWith(feed: currentFeed.copyWith(emergencyTypes: updated)));
  }

  void _onVisibilityScopeSelected(
    SosVisibilityScopeSelected event,
    Emitter<SosState> emit,
  ) {
    final currentFeed = state.feed;
    if (currentFeed == null) return;

    final updated = currentFeed.visibilityScopes
        .map((item) => item.copyWith(isSelected: item.id == event.scopeId))
        .toList(growable: false);

    emit(state.copyWith(feed: currentFeed.copyWith(visibilityScopes: updated)));
  }

  void _onDescriptionChanged(
    SosDescriptionChanged event,
    Emitter<SosState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }
}
