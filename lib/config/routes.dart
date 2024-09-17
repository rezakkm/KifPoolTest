import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kif_pool_test/features/main/presentation/pages/main/main_page.dart';
import 'package:kif_pool_test/features/main/presentation/provider/route_provider.dart';

class AppRouter {
  final WidgetRef ref;
  late final GoRouter router;

  AppRouter(this.ref) {
    router = GoRouter(
      initialLocation: '/main/home',
      routes: [
        GoRoute(
          path: '/main/:subPath(.*)', // مسیر اصلی برای تب‌ها و تمامی زیرمسیرها
          builder: (context, state) {
            final String path = state.uri.toString();
            Future.delayed(Duration.zero, () {
              ref.read(routeProvider.notifier).state = path;
            });
            // بررسی مسیر و نمایش صفحه مناسب
            if (path.startsWith('/main/home')) {
              return MainPage(
                tab: 'home',
              );
            } else if (path.startsWith('/main/exchange')) {
              return MainPage(
                tab: 'exchange',
              );
            } else if (path.startsWith('/main/wallet')) {
              return MainPage(
                tab: 'wallet',
              );
            } else {
              return MainPage(
                tab: 'home',
              );
            }
          },
        ),
      ],
    );
  }
}
