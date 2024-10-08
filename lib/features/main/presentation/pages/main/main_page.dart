import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kif_pool_test/core/constants/enums.dart';
import 'package:kif_pool_test/features/main/presentation/pages/home/first_home_widget.dart';
import 'package:kif_pool_test/features/main/presentation/pages/home/second_home_widget.dart';
import 'package:kif_pool_test/features/main/presentation/pages/main/main_nav_bar_widget.dart';
import 'package:kif_pool_test/features/main/presentation/pages/shared/primary_textfield.dart';
import 'package:kif_pool_test/features/main/presentation/pages/wallet/first_wallet_widget.dart';
import 'package:kif_pool_test/features/main/presentation/pages/wallet/second_wallet_widget.dart';
import 'package:kif_pool_test/features/main/presentation/provider/get_list_provider.dart';
import 'package:kif_pool_test/features/main/presentation/provider/route_provider.dart';
part '../home/home_page.dart';
part '../exchange/exchange_page.dart';
part '../wallet/wallet_page.dart';

class MainPage extends HookConsumerWidget {
  final String tab;

  MainPage({
    super.key,
    required this.tab,
  });
  final Map<String, int> _tabMap = {
    'home': 0,
    'exchange': 1,
    'wallet': 2,
  };

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(getListProvider);
    final path = ref.watch(routeProvider);
    final homeState = ref.watch(homePageProvider);
    final walletState = ref.watch(walletPageProvider);
    final tabBarController =
        useTabController(initialLength: 3, initialIndex: _tabMap[tab] ?? 0);
    var items = <Widget>[
      Icon(
        Icons.home,
        size: 30,
        color: iconColor(tabBarController.index == 0),
      ),
      Icon(
        Icons.swap_vertical_circle_sharp,
        size: 30,
        color: iconColor(tabBarController.index == 1),
      ),
      Icon(
        Icons.wallet,
        size: 30,
        color: iconColor(tabBarController.index == 2),
      ),
    ];
    void goRoute(String path) {
      if (ref.read(routeProvider) != path) {
        context.go(path);
      }
    }

    // init state
    useEffect(() {
      Future.delayed((Duration.zero), () {
        mergePathwithNavBar(tabBarController, ref, path);
      });
      tabBarController.addListener(() {
        switch (tabBarController.index) {
          case 0:
            ref.read(homePageProvider).isNotEmpty
                ? goRoute('/main/home/list')
                : goRoute('/main/home');

            break;
          case 1:
            goRoute('/main/exchange');
            break;
          case 2:
            ref.read(walletPageProvider).isNotEmpty
                ? goRoute('/main/wallet/deposit')
                : goRoute('/main/wallet');

            break;
        }
      });
      return null;
    }, []);
    ref.listen(routeProvider, (prev, next) {
      mergePathwithNavBar(tabBarController, ref, next);
    });

    // Ui
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 18, 32),
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/image/bg.png',
                  ),
                  fit: BoxFit.cover)),
          child: Stack(
            children: [
              // background
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: const SizedBox.expand()),
              // appbar (top)
              Positioned(
                right: 0,
                left: 0,
                top: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notification_add_outlined,
                            size: 28,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {
                            if (homeState != '') {
                              ref.read(homePageProvider.notifier).state = '';
                              context.go('/main/home');
                            }
                            if (walletState != '') {
                              ref.read(walletPageProvider.notifier).state = '';
                              context.go('/main/wallet');
                            }
                          },
                          icon: homeState != '' || walletState != ''
                              ? const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 28,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.settings,
                                  size: 28,
                                  color: Colors.white,
                                )),
                    ],
                  ),
                ),
              ),
              // main content
              Positioned.fill(
                top: 48,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child:
                      TabBarView(controller: tabBarController, children: const [
                    HomePage(),
                    ExchangePage(),
                    WalletPage(),
                  ]),
                ),
              ),
              // navbar
              Align(
                  alignment: Alignment.bottomCenter,
                  child: CurvedNavigationBar(
                    index: tabBarController.index,
                    height: 68,
                    backgroundColor: Colors.transparent,
                    color: Colors.transparent,
                    buttonBackgroundColor: Colors.blue,
                    items: items,
                    onTap: (index) {
                      tabBarController.animateTo(index);
                    },
                  )),
            ],
          )),
    ));
  }

  void mergePathwithNavBar(
      TabController tabBarController, WidgetRef ref, String path) {
    if (path.contains("home")) {
      if (!path.endsWith('list')) {
        ref.read(homePageProvider.notifier).state = '';
      } else {
        ref.read(homePageProvider.notifier).state = 'list';
      }
      tabBarController.animateTo(0);
    } else if (path.contains("exchange")) {
      tabBarController.animateTo(1);
    } else if (path.contains("wallet")) {
      if (!path.endsWith('deposit')) {
        ref.read(walletPageProvider.notifier).state = '';
      } else {
        ref.read(walletPageProvider.notifier).state = 'deposit';
      }
      tabBarController.animateTo(2);
    }
  }

  Color iconColor(bool selected) {
    return selected ? Colors.white : const Color.fromARGB(255, 113, 183, 241);
  }
}
