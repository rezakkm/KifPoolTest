import 'package:kif_pool_test/features/main/data/api_service/get_list_api_service.dart';
import 'package:kif_pool_test/features/main/data/data_state.dart';
import 'package:kif_pool_test/features/main/data/get_list_repository_impl.dart';
import 'package:kif_pool_test/features/main/data/get_list_response_model.dart';
import 'package:kif_pool_test/features/main/domain/network_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_list_provider.g.dart';

@riverpod
class GetList extends _$GetList {
  @override
  DataState<GetListResponseModel> build() {
    return const DataInitial();
  }

  Future<void> getMenu() async {
    final dio = ref.read(dioProvider);
    state = const DataLoading();
    final repo = GetListRepositoryImpl(GetListApiService(dio));
    final response = await repo.getList();
    response.fold((failed) {
      state = DataFailed(failed);
    }, (data) {
      state = DataSuccess(data);
    });
  }
}
