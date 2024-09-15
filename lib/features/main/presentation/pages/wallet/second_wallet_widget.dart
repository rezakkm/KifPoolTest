import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kif_pool_test/features/main/presentation/pages/shared/primary_textfield.dart';

class SecondWalletWidget extends StatefulHookConsumerWidget {
  const SecondWalletWidget({super.key});

  @override
  ConsumerState<SecondWalletWidget> createState() => _SecondWalletWidgetWtate();
}

class _SecondWalletWidgetWtate extends ConsumerState<SecondWalletWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'کیف پول / واریز',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          'متن خود را وارد کنید',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 16,
        ),
        PrimaryTextField()
      ],
    );
  }
}
