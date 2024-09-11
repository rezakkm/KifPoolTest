import 'package:go_router/go_router.dart';
import 'package:kif_pool_test/features/main/presentation/pages/main/main_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/main/home',
    routes: [
      GoRoute(
        path: '/main/:subPath(.*)', // مسیر اصلی برای تب‌ها و تمامی زیرمسیرها
        builder: (context, state) {
          final String path = state.uri.toString();

          if (path.startsWith('/main/home')) {
            return MainPage(
              tab: 'home',
              path: path,
              // ارسال زیرمسیر به MainPage
            );
          } else if (path.startsWith('/main/exchange')) {
            return MainPage(
              tab: 'exchange',
              path: path,
              // ارسال زیرمسیر به MainPage
            );
          } else if (path.startsWith('/main/wallet')) {
            return MainPage(
              tab: 'wallet',
              path: path,
              // ارسال زیرمسیر به MainPage
            );
          } else {
            return MainPage(
              tab: 'home',
              path: path,
              // ارسال زیرمسیر به MainPage
            );
          }
        },
      ),
    ],
  );
}
