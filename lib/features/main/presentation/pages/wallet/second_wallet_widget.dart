import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kif_pool_test/features/main/presentation/pages/shared/primary_textfield.dart';

//  this provider keep our textfield data when page disposed
final secondWalletTextProvider = StateProvider<String>((ref) => '');

class SecondWalletWidget extends HookConsumerWidget {
  const SecondWalletWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    // data from providers
    final textFieldValue = ref.watch(secondWalletTextProvider);
    // initial useController variable with providers
    final textController = useTextEditingController(text: textFieldValue);
    useEffect(() {
      textController.addListener(() {
        ref.read(secondWalletTextProvider.notifier).state = textController.text;
      });
      return null;
    }, []);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text(
            'کیف پول / واریز',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          'متن خود را وارد کنید',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 16,
        ),
        PrimaryTextField(
          controller: textController,
        )
      ],
    );
  }
}
