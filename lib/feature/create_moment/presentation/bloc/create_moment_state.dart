part of 'create_moment_bloc.dart';

enum CreateMomentStatus { initial, loading, success, failure }

enum CreateMomentSubmissionStatus { idle, submitting, success, failure }

const Object _unset = Object();

class CreateMomentState {
  final CreateMomentStatus status;
  final CreateMomentFeed? feed;
  final double rating;
  final String caption;
  final List<String> selectedMediaIds;
  final List<CreateMomentPhoto> capturedPhotos;
  final List<String> selectedTagIds;
  final List<String> selectedFriendIds;
  final List<CreateMomentVibeTag> customVibeTags;
  final String selectedPrivacyId;
  final String? selectedLocationId;
  final String locationQuery;
  final String friendQuery;
  final CreateMomentSubmissionStatus submissionStatus;
  final String? errorMessage;

  const CreateMomentState({
    this.status = CreateMomentStatus.initial,
    this.feed,
    this.rating = 1.0,
    this.caption = '',
    this.selectedMediaIds = const <String>[],
    this.capturedPhotos = const <CreateMomentPhoto>[],
    this.selectedTagIds = const <String>[],
    this.selectedFriendIds = const <String>[],
    this.customVibeTags = const <CreateMomentVibeTag>[],
    this.selectedPrivacyId = '',
    this.selectedLocationId,
    this.locationQuery = '',
    this.friendQuery = '',
    this.submissionStatus = CreateMomentSubmissionStatus.idle,
    this.errorMessage,
  });

  CreateMomentState copyWith({
    CreateMomentStatus? status,
    CreateMomentFeed? feed,
    double? rating,
    String? caption,
    List<String>? selectedMediaIds,
    List<CreateMomentPhoto>? capturedPhotos,
    List<String>? selectedTagIds,
    List<String>? selectedFriendIds,
    List<CreateMomentVibeTag>? customVibeTags,
    String? selectedPrivacyId,
    Object? selectedLocationId = _unset,
    String? locationQuery,
    String? friendQuery,
    CreateMomentSubmissionStatus? submissionStatus,
    Object? errorMessage = _unset,
  }) {
    return CreateMomentState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      rating: rating ?? this.rating,
      caption: caption ?? this.caption,
      selectedMediaIds: selectedMediaIds ?? this.selectedMediaIds,
      capturedPhotos: capturedPhotos ?? this.capturedPhotos,
      selectedTagIds: selectedTagIds ?? this.selectedTagIds,
      selectedFriendIds: selectedFriendIds ?? this.selectedFriendIds,
      customVibeTags: customVibeTags ?? this.customVibeTags,
      selectedPrivacyId: selectedPrivacyId ?? this.selectedPrivacyId,
      selectedLocationId: selectedLocationId == _unset
          ? this.selectedLocationId
          : selectedLocationId as String?,
      locationQuery: locationQuery ?? this.locationQuery,
      friendQuery: friendQuery ?? this.friendQuery,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      errorMessage: errorMessage == _unset
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  List<CreateMomentVibeTag> get allVibeTags {
    final feedTags = feed?.vibeTags ?? const <CreateMomentVibeTag>[];
    final builtInTags = feedTags.where((tag) => tag.id != 'add-tag');
    final addTag = feedTags.where((tag) => tag.id == 'add-tag');
    return <CreateMomentVibeTag>[...builtInTags, ...customVibeTags, ...addTag];
  }

  List<CreateMomentPhoto> get selectedPhotos {
    final photos = availablePhotos;
    final selected = <CreateMomentPhoto>[];
    for (final id in selectedMediaIds) {
      for (final photo in photos) {
        if (photo.id == id) {
          selected.add(photo);
          break;
        }
      }
    }
    return selected;
  }

  List<CreateMomentPhoto> get availablePhotos {
    final feedPhotos = feed?.photos ?? const <CreateMomentPhoto>[];
    return <CreateMomentPhoto>[...capturedPhotos, ...feedPhotos];
  }

  List<CreateMomentVibeTag> get selectedVibeTags {
    final tags = allVibeTags;
    final selected = <CreateMomentVibeTag>[];
    for (final id in selectedTagIds) {
      for (final tag in tags) {
        if (tag.id == id) {
          selected.add(tag);
          break;
        }
      }
    }
    return selected;
  }

  bool get canSubmit =>
      selectedMediaIds.isNotEmpty &&
      submissionStatus != CreateMomentSubmissionStatus.submitting;
}
