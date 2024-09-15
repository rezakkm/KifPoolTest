part of '../main/main_page.dart';

final walletPageProvider = StateProvider((ref) => '');

class WalletPage extends HookConsumerWidget {
  const WalletPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final walletSwitchKey = ref.watch(walletPageProvider);
    return walletSwitchKey == ''
        ? const FirstWalletWidget()
        : const SecondWalletWidget();
  }
}
