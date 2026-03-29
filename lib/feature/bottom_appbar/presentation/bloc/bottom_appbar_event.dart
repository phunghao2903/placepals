part of 'bottom_appbar_bloc.dart';

sealed class BottomAppBarEvent {
  const BottomAppBarEvent();
}

class BottomAppBarTabChanged extends BottomAppBarEvent {
  final int index;

  const BottomAppBarTabChanged({required this.index});
}
