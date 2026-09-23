import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/calculator_screen.dart';
import 'screens/converter_screen.dart';
import 'screens/calc_result_screen.dart';
import 'screens/conv_result_screen.dart';
import 'screens/not_found_screen.dart';
import 'settings_controller.dart';

GoRouter createRouter(SettingsController settings) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(settings: settings),
      ),
      GoRoute(
        path: '/calculator',
        builder: (context, state) => const CalculatorScreen(),
        routes: [
          GoRoute(
            path: 'result',
            builder: (context, state) {
              final q = state.uri.queryParameters;
              return CalcResultScreen(rawA: q['a'], rawOp: q['op'], rawB: q['b']);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/converter',
        builder: (context, state) => ConverterScreen(settings: settings),
        routes: [
          GoRoute(
            path: 'result',
            builder: (context, state) {
              final q = state.uri.queryParameters;
              return ConvResultScreen(rawAmount: q['amount'], rawFrom: q['from'], rawTo: q['to']);
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => NotFoundScreen(location: state.uri.toString()),
  );
}