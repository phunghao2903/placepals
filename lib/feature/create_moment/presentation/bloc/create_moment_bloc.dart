import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/create_moment_feed.dart';
import '../../domain/entities/create_moment_photo.dart';
import '../../domain/entities/create_moment_vibe_tag.dart';
import '../../domain/usecases/get_create_moment_feed_usecase.dart';

part 'create_moment_event.dart';
part 'create_moment_state.dart';

class CreateMomentBloc extends Bloc<CreateMomentEvent, CreateMomentState> {
  final GetCreateMomentFeedUseCase getCreateMomentFeedUseCase;

  CreateMomentBloc({required this.getCreateMomentFeedUseCase})
    : super(const CreateMomentState()) {
    on<CreateMomentStarted>(_onStarted);
    on<CreateMomentRatingChanged>(_onRatingChanged);
    on<CreateMomentCaptionChanged>(_onCaptionChanged);
    on<CreateMomentMediaToggled>(_onMediaToggled);
    on<CreateMomentCameraCaptured>(_onCameraCaptured);
    on<CreateMomentLocationQueryChanged>(_onLocationQueryChanged);
    on<CreateMomentLocationSelected>(_onLocationSelected);
    on<CreateMomentVibeTagToggled>(_onVibeTagToggled);
    on<CreateMomentCustomTagAdded>(_onCustomTagAdded);
    on<CreateMomentFriendSearchChanged>(_onFriendSearchChanged);
    on<CreateMomentFriendToggled>(_onFriendToggled);
    on<CreateMomentPrivacySelected>(_onPrivacySelected);
    on<CreateMomentSubmitted>(_onSubmitted);
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
          selectedMediaIds: feed.photos
              .where((photo) => !photo.isPlaceholder)
              .take(1)
              .map((photo) => photo.id)
              .toList(),
          capturedPhotos: const <CreateMomentPhoto>[],
          selectedTagIds: feed.vibeTags
              .where((tag) => tag.isDefaultSelected)
              .map((tag) => tag.id)
              .toList(),
          selectedPrivacyId: feed.privacyOptions.isEmpty
              ? ''
              : feed.privacyOptions.first.id,
          selectedLocationId: null,
          selectedFriendIds: const <String>[],
          customVibeTags: const <CreateMomentVibeTag>[],
          locationQuery: '',
          friendQuery: '',
          submissionStatus: CreateMomentSubmissionStatus.idle,
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
    emit(
      state.copyWith(
        rating: event.rating,
        submissionStatus: CreateMomentSubmissionStatus.idle,
        errorMessage: null,
      ),
    );
  }

  void _onCaptionChanged(
    CreateMomentCaptionChanged event,
    Emitter<CreateMomentState> emit,
  ) {
    emit(
      state.copyWith(
        caption: event.caption,
        submissionStatus: CreateMomentSubmissionStatus.idle,
        errorMessage: null,
      ),
    );
  }

  void _onMediaToggled(
    CreateMomentMediaToggled event,
    Emitter<CreateMomentState> emit,
  ) {
    CreateMomentPhoto? photo;
    for (final item in state.availablePhotos) {
      if (item.id == event.photoId) {
        photo = item;
        break;
      }
    }
    if (photo == null || photo.isPlaceholder) return;

    final selected = List<String>.from(state.selectedMediaIds);
    if (selected.contains(event.photoId)) {
      selected.remove(event.photoId);
    } else {
      selected.add(event.photoId);
    }

    emit(
      state.copyWith(
        selectedMediaIds: selected,
        submissionStatus: CreateMomentSubmissionStatus.idle,
        errorMessage: null,
      ),
    );
  }

  void _onCameraCaptured(
    CreateMomentCameraCaptured event,
    Emitter<CreateMomentState> emit,
  ) {
    final imagePath = event.imagePath.trim();
    if (imagePath.isEmpty) return;

    final capturedPhotos = List<CreateMomentPhoto>.from(state.capturedPhotos);
    final selectedMediaIds = List<String>.from(state.selectedMediaIds);
    final capturedPhoto = CreateMomentPhoto(
      id: 'captured-${capturedPhotos.length + 1}',
      imagePath: imagePath,
    );

    capturedPhotos.insert(0, capturedPhoto);
    selectedMediaIds.add(capturedPhoto.id);

    emit(
      state.copyWith(
        capturedPhotos: capturedPhotos,
        selectedMediaIds: selectedMediaIds,
        submissionStatus: CreateMomentSubmissionStatus.idle,
        errorMessage: null,
      ),
    );
  }

  void _onLocationQueryChanged(
    CreateMomentLocationQueryChanged event,
    Emitter<CreateMomentState> emit,
  ) {
    emit(state.copyWith(locationQuery: event.query));
  }

  void _onLocationSelected(
    CreateMomentLocationSelected event,
    Emitter<CreateMomentState> emit,
  ) {
    emit(
      state.copyWith(
        selectedLocationId: event.placeId,
        locationQuery: '',
        submissionStatus: CreateMomentSubmissionStatus.idle,
        errorMessage: null,
      ),
    );
  }

  void _onVibeTagToggled(
    CreateMomentVibeTagToggled event,
    Emitter<CreateMomentState> emit,
  ) {
    if (event.tagId == 'add-tag') return;

    final selected = List<String>.from(state.selectedTagIds);
    if (selected.contains(event.tagId)) {
      selected.remove(event.tagId);
    } else {
      selected.add(event.tagId);
    }

    emit(
      state.copyWith(
        selectedTagIds: selected,
        submissionStatus: CreateMomentSubmissionStatus.idle,
        errorMessage: null,
      ),
    );
  }

  void _onCustomTagAdded(
    CreateMomentCustomTagAdded event,
    Emitter<CreateMomentState> emit,
  ) {
    final label = event.label.trim();
    if (label.isEmpty) return;

    final customTags = List<CreateMomentVibeTag>.from(state.customVibeTags);
    final selected = List<String>.from(state.selectedTagIds);
    final tag = CreateMomentVibeTag(
      id: 'custom-${customTags.length + 1}',
      label: label,
      iconKey: 'sell',
      isDefaultSelected: true,
    );
    customTags.add(tag);
    selected.add(tag.id);

    emit(
      state.copyWith(
        customVibeTags: customTags,
        selectedTagIds: selected,
        submissionStatus: CreateMomentSubmissionStatus.idle,
        errorMessage: null,
      ),
    );
  }

  void _onFriendSearchChanged(
    CreateMomentFriendSearchChanged event,
    Emitter<CreateMomentState> emit,
  ) {
    emit(state.copyWith(friendQuery: event.query));
  }

  void _onFriendToggled(
    CreateMomentFriendToggled event,
    Emitter<CreateMomentState> emit,
  ) {
    final selected = List<String>.from(state.selectedFriendIds);
    if (selected.contains(event.friendId)) {
      selected.remove(event.friendId);
    } else {
      selected.add(event.friendId);
    }

    emit(
      state.copyWith(
        selectedFriendIds: selected,
        submissionStatus: CreateMomentSubmissionStatus.idle,
        errorMessage: null,
      ),
    );
  }

  void _onPrivacySelected(
    CreateMomentPrivacySelected event,
    Emitter<CreateMomentState> emit,
  ) {
    emit(
      state.copyWith(
        selectedPrivacyId: event.privacyId,
        submissionStatus: CreateMomentSubmissionStatus.idle,
        errorMessage: null,
      ),
    );
  }

  Future<void> _onSubmitted(
    CreateMomentSubmitted event,
    Emitter<CreateMomentState> emit,
  ) async {
    if (!state.canSubmit) {
      emit(
        state.copyWith(
          submissionStatus: CreateMomentSubmissionStatus.failure,
          errorMessage: 'Select at least one photo before sharing.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        submissionStatus: CreateMomentSubmissionStatus.submitting,
        errorMessage: null,
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 900));

    emit(
      state.copyWith(
        submissionStatus: CreateMomentSubmissionStatus.success,
        errorMessage: null,
      ),
    );
  }
}
