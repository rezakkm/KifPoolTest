import 'package:go_router/go_router.dart';
import 'package:kif_pool_test/features/main/presentation/pages/main/main_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/main/home',
    routes: [
      GoRoute(
        path: '/main/:tab',
        builder: (context, state) {
          final tab = state.pathParameters['tab']!;

          if (!['home', 'exchange', 'wallet'].contains(tab)) {
            return MainPage(tab: 'home');
          }

          return MainPage(tab: tab);
        },
        routes: [
          GoRoute(
            path: 'list',
            builder: (context, state) {
              return MainPage(tab: 'home');
            },
          ),
          GoRoute(
            path: 'deposit',
            builder: (context, state) {
              return MainPage(tab: 'wallet');
            },
          ),
        ],
      ),
    ],
  );
}
