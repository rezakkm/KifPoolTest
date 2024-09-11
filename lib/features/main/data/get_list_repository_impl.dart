import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kif_pool_test/core/error/exeption_handler.dart';
import 'package:kif_pool_test/features/main/data/api_service/get_list_api_service.dart';
import 'package:kif_pool_test/features/main/data/get_list_response_model.dart';
import 'package:kif_pool_test/features/main/domain/get_list_repository.dart';

class GetListRepositoryImpl extends GetListRepository {
  final GetListApiService _apiService;
  GetListRepositoryImpl(this._apiService);
  @override
  Future<Either<ExceptionHandler, GetListResponseModel>> getList() async {
    try {
      final httpResponse = await _apiService.getList();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return Right(httpResponse.data);
      } else {
        return Left(ExceptionHandler(
          dioException: DioException(
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
          ),
        ));
      }
    } on DioException catch (e) {
      return Left(ExceptionHandler(dioException: e));
    }
  }
}
