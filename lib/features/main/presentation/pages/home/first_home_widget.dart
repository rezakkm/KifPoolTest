import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kif_pool_test/core/constants/enums.dart';
import 'package:kif_pool_test/features/main/data/data_state.dart';
import 'package:kif_pool_test/features/main/data/get_list_response_model.dart';
import 'package:kif_pool_test/features/main/presentation/pages/main/main_page.dart';
import 'package:shimmer/shimmer.dart';

import '../shared/primary_textfield.dart';

class FirstHomeWidget extends HookConsumerWidget {
  const FirstHomeWidget({
    super.key,
    required this.listDataController,
  });

  final DataState<GetListResponseModel> listDataController;

  @override
  Widget build(BuildContext context, ref) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'خانه',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
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
          const PrimaryTextField(),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // تنظیم رادیوس به 16
                              ),
                            ),
                            backgroundColor:
                                const WidgetStatePropertyAll(Colors.orange)),
                        onPressed: () {
                          ref.read(homePageProvider.notifier).state = '/list';
                          context.go('/main/home/list');
                        },
                        child: const Text(
                          'صفحه لیست آیتم ها',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          if (listDataController.stateChecker == StateCheckerEnum.done)
            Text(
              "لیست با ${listDataController.data?.data?.length ?? 0} آیتم",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listDataController.stateChecker == StateCheckerEnum.done
                ? listDataController.data?.data?.length ?? 0
                : 5,
            itemBuilder: (context, index) {
              String data = listDataController.data?.data?[index].text ?? '';
              return listDataController.stateChecker != StateCheckerEnum.done
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.3),
                      highlightColor: Colors.grey.withOpacity(0.8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Colors.red,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                              child: Text(
                            data,
                            style: const TextStyle(color: Colors.white),
                          ))
                        ],
                      ),
                    );
            },
          ),
          const SizedBox(
            height: 90,
          )
        ],
      ),
    );
  }
}
