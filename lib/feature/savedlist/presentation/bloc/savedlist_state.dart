part of 'savedlist_bloc.dart';

enum SavedListStatus {
  initial,
  loading,
  success,
  failure,
}

class SavedListState {
  final SavedListStatus status;
  final SavedListFeed? feed;
  final SavedTabType activeTab;
  final String searchQuery;
  final String? errorMessage;

  const SavedListState({
    this.status = SavedListStatus.initial,
    this.feed,
    this.activeTab = SavedTabType.wishlist,
    this.searchQuery = '',
    this.errorMessage,
  });

  SavedListState copyWith({
    SavedListStatus? status,
    SavedListFeed? feed,
    SavedTabType? activeTab,
    String? searchQuery,
    Object? errorMessage = _savedListUnset,
  }) {
    return SavedListState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      activeTab: activeTab ?? this.activeTab,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: identical(errorMessage, _savedListUnset)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}

const Object _savedListUnset = Object();
