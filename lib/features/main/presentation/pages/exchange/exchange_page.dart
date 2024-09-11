part of '../main/main_page.dart';

//  this provider keep our textfield data when page disposed
final exchangeTextProvider = StateProvider<String>((ref) => '');

class ExchangePage extends HookConsumerWidget {
  const ExchangePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    // data from providers
    final textFieldValue = ref.watch(exchangeTextProvider);
    // initial useController variable with providers
    final textController = useTextEditingController(text: textFieldValue);
    useEffect(() {
      textController.addListener(() {
        ref.read(exchangeTextProvider.notifier).state = textController.text;
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
            'معامله',
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
