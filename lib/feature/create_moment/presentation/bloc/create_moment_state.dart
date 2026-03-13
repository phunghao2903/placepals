part of 'create_moment_bloc.dart';

enum CreateMomentStatus {
  initial,
  loading,
  success,
  failure,
}

class CreateMomentState {
  final CreateMomentStatus status;
  final CreateMomentFeed? feed;
  final double rating;
  final String caption;
  final String location;
  final String? errorMessage;

  const CreateMomentState({
    this.status = CreateMomentStatus.initial,
    this.feed,
    this.rating = 1.0,
    this.caption = '',
    this.location = '',
    this.errorMessage,
  });

  CreateMomentState copyWith({
    CreateMomentStatus? status,
    CreateMomentFeed? feed,
    double? rating,
    String? caption,
    String? location,
    String? errorMessage,
  }) {
    return CreateMomentState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      rating: rating ?? this.rating,
      caption: caption ?? this.caption,
      location: location ?? this.location,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
