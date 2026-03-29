part of 'place_details_bloc.dart';

sealed class PlaceDetailsEvent {
  const PlaceDetailsEvent();
}

class PlaceDetailsStarted extends PlaceDetailsEvent {
  final String placeId;

  const PlaceDetailsStarted({
    required this.placeId,
  });
}

class PlaceDetailsTransparencyToggled extends PlaceDetailsEvent {
  const PlaceDetailsTransparencyToggled();
}

class PlaceDetailsHiddenReviewRevealToggled extends PlaceDetailsEvent {
  const PlaceDetailsHiddenReviewRevealToggled();
}

class PlaceDetailsMapPickSelected extends PlaceDetailsEvent {
  final String pickId;

  const PlaceDetailsMapPickSelected({
    required this.pickId,
  });
}
