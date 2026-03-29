part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState {
  final ProfileStatus status;
  final ProfileFeed? feed;
  final String? errorMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.feed,
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileFeed? feed,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
