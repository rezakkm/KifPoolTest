part of '../main/main_page.dart';

final homePageProvider = StateProvider((ref) => '');

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage>
    with AutomaticKeepAliveClientMixin {
  // this config from autoKeepAliveMixin keep our state
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final listDataController = ref.watch(getListProvider);
    final homeSwitchKey = ref.watch(homePageProvider);
    useEffect(() {
      Future.delayed(Duration.zero, () {
        if (listDataController.stateChecker != StateCheckerEnum.done) {
          ref.read(getListProvider.notifier).getMenu();
        }
      });

      return null;
    }, []);

    return IndexedStack(
      index: homeSwitchKey == '' ? 0 : 1,
      children: [
        FirstHomeWidget(listDataController: listDataController),
        const SecondHomeWidget(),
      ],
    );
  }
}
