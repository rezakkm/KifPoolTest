// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExceptionHandler {
  final DioException? dioException;
  final String? messageException;
  final AutoDisposeNotifierProviderRef? ref;
  ExceptionHandler({
    this.dioException,
    this.messageException,
    this.ref,
  });

  DioException? get exception => dioException;
  Map<String, dynamic> get responseData => exception?.response?.data;
  int? get statusCode => exception?.response?.statusCode;
  String? get message => (messageException ??
      (exception?.message?.contains("The request connection took longer") ==
              true
          ? 'Connection Failed, Try Again later'
          : exception?.message));

  @override
  String toString() {
    if (dioException != null) {
      return "ExceptionHandler: \n---[Dio Failed]\n---URL: ${dioException!.requestOptions.uri}"
          " \n---headers: ${dioException?.requestOptions.headers} \n---Message: $message\n---StatusCode: $statusCode";
    }
    if (messageException != null) {
      return "ExceptionHandler: \n---[Exception Message]\n---Message: $messageException";
    }
    return "ExceptionHandler: unknown Error!";
  }

  ExceptionHandler copyWith({
    DioException? dioException,
    String? messageException,
    dynamic ref,
  }) {
    return ExceptionHandler(
      dioException: dioException ?? this.dioException,
      messageException: messageException ?? this.messageException,
      ref: ref ?? this.ref,
    );
  }
}
