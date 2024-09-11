import 'package:dio/dio.dart';
import 'package:kif_pool_test/core/constants/strings.dart';
import 'package:kif_pool_test/features/main/data/get_list_response_model.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'get_list_api_service.g.dart';

//dart run build_runner build --delete-conflicting-outputs --build-filter="lib/features/account/data/sources/*.dart"
@RestApi(baseUrl: baseUrl)
abstract class GetListApiService {
  factory GetListApiService(
    Dio dio,
  ) = _GetListApiService;

  @GET('/list1')
  Future<HttpResponse<GetListResponseModel>> getList();
}
