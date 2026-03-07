part of 'bottom_appbar_bloc.dart';

class BottomAppBarState {
  final int currentIndex;

  const BottomAppBarState({
    this.currentIndex = 0,
  });

  BottomAppBarState copyWith({
    int? currentIndex,
  }) {
    return BottomAppBarState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
