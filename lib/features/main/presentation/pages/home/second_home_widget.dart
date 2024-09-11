import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kif_pool_test/core/constants/enums.dart';
import 'package:kif_pool_test/features/main/presentation/provider/get_list_provider.dart';
import 'package:shimmer/shimmer.dart';

class SecondHomeWidget extends HookConsumerWidget {
  const SecondHomeWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final listDataController = ref.watch(getListProvider);

    return Column(
      children: [
        if (listDataController.stateChecker == StateCheckerEnum.done)
          Text(
            "لیست با ${listDataController.data?.data?.length ?? 0} آیتم",
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
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
    );
  }
}
