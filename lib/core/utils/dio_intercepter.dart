import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../data/model/error/error_model.dart';
import 'failures/http/http_failure.dart';

class AppInterceptors extends Interceptor {
  AppInterceptors();

  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.sendTimeout = const Duration(milliseconds: 60000);
    options.connectTimeout = const Duration(milliseconds: 60000);
    options.receiveTimeout = const Duration(milliseconds: 60000);

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    HttpFailure failure;

    try {
      final response = err.response;
      final statusCode = response?.statusCode ?? -1;
      final data = response?.data;

      if (err.type == DioExceptionType.connectionError ||
          err.type == DioExceptionType.sendTimeout ||
          err.type == DioExceptionType.receiveTimeout ||
          err.type == DioExceptionType.cancel) {
        throw const NoInternetFailure();
      }

      if (statusCode == HttpStatus.unauthorized) {
        failure = const UnauthorizedFailure();
        throw failure;
      } else if (statusCode == HttpStatus.forbidden ||
          statusCode == HttpStatus.notFound) {
        failure = CustomFailure(
          message: data?['error']?.toString() ?? "Access forbidden",
        );
        throw failure;
      } else if (statusCode >= 500) {
        failure = const ServerFailure();
        throw failure;
      }

      if (err.type == DioExceptionType.badResponse && data != null) {
        try {
          final errorModel = ErrorModel.fromJson(data);
          String message = errorModel.error;

          if (errorModel.details.isNotEmpty) {
            message = errorModel.details.first.msg;
          }

          failure = CustomFailure(message: message);
          throw failure;
        } catch (_) {
          failure = CustomFailure(message: data.toString());
          throw failure;
        }
      }

      failure = CustomFailure(message: "Unknown error occurred.");
      throw failure;
    } catch (e) {
      failure = e is HttpFailure
          ? e
          : CustomFailure(message: "Unexpected error: ${e.toString()}");
      throw failure;
    }
  }
}
