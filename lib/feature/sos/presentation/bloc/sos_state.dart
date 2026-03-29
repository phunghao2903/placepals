part of 'sos_bloc.dart';

enum SosStatus { initial, loading, success, failure }

class SosState {
  final SosStatus status;
  final SosFeed? feed;
  final String description;
  final String? errorMessage;

  const SosState({
    this.status = SosStatus.initial,
    this.feed,
    this.description = '',
    this.errorMessage,
  });

  SosState copyWith({
    SosStatus? status,
    SosFeed? feed,
    String? description,
    String? errorMessage,
  }) {
    return SosState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      description: description ?? this.description,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
