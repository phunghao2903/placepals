import 'package:get_it/get_it.dart';

import 'presentation/bloc/bottom_appbar_bloc.dart';

void registerBottomAppBarDependencies(GetIt getIt) {
  getIt.registerFactory<BottomAppBarBloc>(BottomAppBarBloc.new);
}
