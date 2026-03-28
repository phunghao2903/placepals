part of 'create_moment_bloc.dart';

sealed class CreateMomentEvent {
  const CreateMomentEvent();
}

class CreateMomentStarted extends CreateMomentEvent {
  const CreateMomentStarted();
}

class CreateMomentRatingChanged extends CreateMomentEvent {
  final double rating;

  const CreateMomentRatingChanged({required this.rating});
}

class CreateMomentCaptionChanged extends CreateMomentEvent {
  final String caption;

  const CreateMomentCaptionChanged({required this.caption});
}

class CreateMomentMediaToggled extends CreateMomentEvent {
  final String photoId;

  const CreateMomentMediaToggled({required this.photoId});
}

class CreateMomentCameraCaptured extends CreateMomentEvent {
  final String imagePath;

  const CreateMomentCameraCaptured({required this.imagePath});
}

class CreateMomentLocationQueryChanged extends CreateMomentEvent {
  final String query;

  const CreateMomentLocationQueryChanged({required this.query});
}

class CreateMomentLocationSelected extends CreateMomentEvent {
  final String placeId;

  const CreateMomentLocationSelected({required this.placeId});
}

class CreateMomentVibeTagToggled extends CreateMomentEvent {
  final String tagId;

  const CreateMomentVibeTagToggled({required this.tagId});
}

class CreateMomentCustomTagAdded extends CreateMomentEvent {
  final String label;

  const CreateMomentCustomTagAdded({required this.label});
}

class CreateMomentFriendSearchChanged extends CreateMomentEvent {
  final String query;

  const CreateMomentFriendSearchChanged({required this.query});
}

class CreateMomentFriendToggled extends CreateMomentEvent {
  final String friendId;

  const CreateMomentFriendToggled({required this.friendId});
}

class CreateMomentPrivacySelected extends CreateMomentEvent {
  final String privacyId;

  const CreateMomentPrivacySelected({required this.privacyId});
}

class CreateMomentSubmitted extends CreateMomentEvent {
  const CreateMomentSubmitted();
}
