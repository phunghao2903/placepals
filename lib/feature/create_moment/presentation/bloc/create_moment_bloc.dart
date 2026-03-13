import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/create_moment_feed.dart';
import '../../domain/usecases/get_create_moment_feed_usecase.dart';

part 'create_moment_event.dart';
part 'create_moment_state.dart';

class CreateMomentBloc extends Bloc<CreateMomentEvent, CreateMomentState> {
  final GetCreateMomentFeedUseCase getCreateMomentFeedUseCase;

  CreateMomentBloc({
    required this.getCreateMomentFeedUseCase,
  }) : super(const CreateMomentState()) {
    on<CreateMomentStarted>(_onStarted);
    on<CreateMomentRatingChanged>(_onRatingChanged);
    on<CreateMomentCaptionChanged>(_onCaptionChanged);
    on<CreateMomentLocationChanged>(_onLocationChanged);
  }

  Future<void> _onStarted(
    CreateMomentStarted event,
    Emitter<CreateMomentState> emit,
  ) async {
    emit(state.copyWith(status: CreateMomentStatus.loading));

    try {
      final feed = await getCreateMomentFeedUseCase();
      emit(
        state.copyWith(
          status: CreateMomentStatus.success,
          feed: feed,
          rating: 1.0,
          caption: '',
          location: '',
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: CreateMomentStatus.failure,
          errorMessage: 'Unable to load create moment screen.',
        ),
      );
    }
  }

  void _onRatingChanged(
    CreateMomentRatingChanged event,
    Emitter<CreateMomentState> emit,
  ) {
    emit(state.copyWith(rating: event.rating));
  }

  void _onCaptionChanged(
    CreateMomentCaptionChanged event,
    Emitter<CreateMomentState> emit,
  ) {
    emit(state.copyWith(caption: event.caption));
  }

  void _onLocationChanged(
    CreateMomentLocationChanged event,
    Emitter<CreateMomentState> emit,
  ) {
    emit(state.copyWith(location: event.location));
  }
}
