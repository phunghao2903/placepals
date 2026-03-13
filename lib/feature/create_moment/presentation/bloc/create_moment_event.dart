part of 'create_moment_bloc.dart';

sealed class CreateMomentEvent {
  const CreateMomentEvent();
}

class CreateMomentStarted extends CreateMomentEvent {
  const CreateMomentStarted();
}

class CreateMomentRatingChanged extends CreateMomentEvent {
  final double rating;

  const CreateMomentRatingChanged({
    required this.rating,
  });
}

class CreateMomentCaptionChanged extends CreateMomentEvent {
  final String caption;

  const CreateMomentCaptionChanged({
    required this.caption,
  });
}

class CreateMomentLocationChanged extends CreateMomentEvent {
  final String location;

  const CreateMomentLocationChanged({
    required this.location,
  });
}
