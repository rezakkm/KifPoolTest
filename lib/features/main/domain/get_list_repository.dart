import 'package:dartz/dartz.dart';
import 'package:kif_pool_test/core/error/exeption_handler.dart';
import 'package:kif_pool_test/features/main/data/get_list_response_model.dart';

abstract class GetListRepository {
  Future<Either<ExceptionHandler, GetListResponseModel>> getList();
}
