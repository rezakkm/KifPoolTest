// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:kif_pool_test/core/constants/enums.dart';
import 'package:kif_pool_test/core/error/exeption_handler.dart';

abstract class DataState<T> {
  final T? data;
  final ExceptionHandler? error;
  final StateCheckerEnum? stateChecker;
  const DataState({this.data, this.error, this.stateChecker});
}

class DataInitial<T> extends DataState<T> {
  const DataInitial() : super(stateChecker: StateCheckerEnum.initial);
}

class DataLoading<T> extends DataState<T> {
  const DataLoading() : super(stateChecker: StateCheckerEnum.loading);
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data)
      : super(data: data, stateChecker: StateCheckerEnum.done);
}

class DataFailed<T> extends DataState<T> {
  DataFailed(ExceptionHandler error)
      : super(error: error, stateChecker: StateCheckerEnum.failed);
}
