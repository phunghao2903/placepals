import 'package:flutter_test/flutter_test.dart';
import 'package:placepals/core/core.dart';
import 'package:placepals/feature/home/presentation/bloc/home_bloc.dart';
import 'package:placepals/feature/map/presentation/bloc/map_bloc.dart';
import 'package:placepals/feature/sos/presentation/bloc/sos_bloc.dart';
import 'package:placepals/main.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await getIt.reset();
    await configureDependencies();
  });

  tearDownAll(() async {
    await getIt.reset();
  });

  test('configureDependencies registers required feature blocs', () {
    expect(getIt.isRegistered<HomeBloc>(), isTrue);
    expect(getIt.isRegistered<MapBloc>(), isTrue);
    expect(getIt.isRegistered<SosBloc>(), isTrue);
  });

  testWidgets('MyApp renders the primary navigation shell', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Saved'), findsOneWidget);
    expect(find.text('SOS'), findsOneWidget);
  });
}
