part of 'savedlist_bloc.dart';

sealed class SavedListEvent {
  const SavedListEvent();
}

class SavedListStarted extends SavedListEvent {
  final SavedTabType initialTab;

  const SavedListStarted({
    this.initialTab = SavedTabType.wishlist,
  });
}

class SavedListTabChanged extends SavedListEvent {
  final SavedTabType tab;

  const SavedListTabChanged({
    required this.tab,
  });
}

class SavedListSearchChanged extends SavedListEvent {
  final String query;

  const SavedListSearchChanged({
    required this.query,
  });
}

class SavedListWishlistToggled extends SavedListEvent {
  final String placeId;

  const SavedListWishlistToggled({
    required this.placeId,
  });
}

class SavedListPlaceMarkedVisited extends SavedListEvent {
  final String placeId;

  const SavedListPlaceMarkedVisited({
    required this.placeId,
  });
}
