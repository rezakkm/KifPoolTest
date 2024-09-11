import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:glassy/glassy_card.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kif_pool_test/core/constants/enums.dart';
import 'package:kif_pool_test/features/main/presentation/pages/home/first_home_widget.dart';
import 'package:kif_pool_test/features/main/presentation/pages/home/second_home_widget.dart';
import 'package:kif_pool_test/features/main/presentation/pages/main/main_tabbar_widget.dart';
import 'package:kif_pool_test/features/main/presentation/pages/shared/primary_textfield.dart';
import 'package:kif_pool_test/features/main/presentation/pages/wallet/first_wallet_widget.dart';
import 'package:kif_pool_test/features/main/presentation/pages/wallet/second_wallet_widget.dart';
import 'package:kif_pool_test/features/main/presentation/provider/get_list_provider.dart';
part '../home/home_page.dart';
part '../exchange/exchange_page.dart';
part '../wallet/wallet_page.dart';

class MainPage extends HookConsumerWidget {
  final String tab;
  final String path;

  MainPage({super.key, required this.tab, required this.path});
  final Map<String, int> _tabMap = {
    'home': 0,
    'exchange': 1,
    'wallet': 2,
  };

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(getListProvider);
    final homeState = ref.watch(homePageProvider);
    final walletState = ref.watch(walletPageProvider);
    final tabBarController =
        useTabController(initialLength: 3, initialIndex: _tabMap[tab] ?? 0);
    tabBarController.addListener(() {
      if (tabBarController.indexIsChanging) {
        switch (tabBarController.index) {
          case 0:
            context.go('/main/home');
            break;
          case 1:
            context.go('/main/exchange');
            break;
          case 2:
            context.go('/main/wallet');
            break;
        }
      }
    });

    // init state
    useEffect(() {
      Future.delayed(Duration.zero, () {
        if (path.endsWith('list')) {
          ref.read(homePageProvider.notifier).state = '/list';
        } else if (path.endsWith('deposit')) {
          ref.read(walletPageProvider.notifier).state = '/deposit';
        }
      });
    }, []);
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
              const GlassyCard(
                child: SizedBox.expand(),
              ),
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
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  key: const Key('done'),
                  child: Container(
                    height: 76,
                    width: 445,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)),
                    ),
                    child: TabBar(
                        controller: tabBarController,
                        indicatorPadding:
                            const EdgeInsets.symmetric(vertical: 8),
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                        tabs: const [
                          MainTabBarWidget(
                            icon: Icon(Icons.home),
                          ),
                          MainTabBarWidget(
                            icon: Icon(Icons.currency_exchange_rounded),
                          ),
                          MainTabBarWidget(
                            icon: Icon(Icons.wallet),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          )),

      //  GlassBottomBar(
      //   items: [
      //     GlassBottomBarItem(
      //       icon: const Icon(Icons.home),
      //       title: const GlassText("Home"),
      //     ),
      //     GlassBottomBarItem(
      //       icon: const Icon(Icons.search),
      //       title: const GlassText("Search"),
      //     ),
      //     GlassBottomBarItem(
      //       icon: const Icon(Icons.settings),
      //       title: const GlassText("Settings"),
      //     ),
      //   ],
      //   onTap: (i) {},
      //   currentIndex: 1,
      // ),
    ));
  }
}
