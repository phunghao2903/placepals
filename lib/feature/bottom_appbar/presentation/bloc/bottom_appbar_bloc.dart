import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_appbar_event.dart';
part 'bottom_appbar_state.dart';

class BottomAppBarBloc extends Bloc<BottomAppBarEvent, BottomAppBarState> {
  BottomAppBarBloc() : super(const BottomAppBarState()) {
    on<BottomAppBarTabChanged>(_onTabChanged);
  }

  void _onTabChanged(
    BottomAppBarTabChanged event,
    Emitter<BottomAppBarState> emit,
  ) {
    emit(state.copyWith(currentIndex: event.index));
  }
}
