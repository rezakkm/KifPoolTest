import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kif_pool_test/features/main/presentation/pages/main/main_page.dart';

class FirstWalletWidget extends HookConsumerWidget {
  const FirstWalletWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text(
            'کیف پول',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            backgroundColor:
                                const WidgetStatePropertyAll(Colors.orange)),
                        onPressed: () {
                          ref.read(walletPageProvider.notifier).state =
                              'deposit';
                          context.go('/main/wallet/deposit');
                        },
                        child: const Text(
                          'واریز تومانی',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                  )),
              const Expanded(flex: 1, child: SizedBox())
            ],
          ),
        )
      ],
    );
  }
}
