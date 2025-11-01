import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../utils/failures/base_failure.dart';
import '../../utils/failures/http/http_failure.dart';
import '../model/base_response_model.dart';

abstract class BaseRemoteDataSource {
  @protected
  Future<T> post<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    required T Function(dynamic) decoder,
    bool requiredToken = true,
  });

  @protected
  Future<T> get<T>({
    required String url,
    Map<String, dynamic>? params,
    required T Function(dynamic) decoder,
    bool requiredToken = true,
  });
}

@lazySingleton
class BaseRemoteDataSourceImpl implements BaseRemoteDataSource {
  Dio dio;

  BaseRemoteDataSourceImpl({required this.dio});

  @override
  Future<T> get<T>({
    required String url,
    Map<String, dynamic>? params,
    required T Function(dynamic p1) decoder,
    bool requiredToken = true,
  }) async {
    try {
      if (requiredToken) {
        dio.options.headers.addAll({"withToken": true});
      }
      final response = await dio.get(url, queryParameters: params);

      try {
        return decoder(response.data);
      } catch (e) {
        rethrow;
      }
    } on DioException catch (de) {
      if (de.error is Failure) {
        throw de.error!;
      } else {
        throw const UnknownFailure();
      }
    }
  }

  @override
  Future<T> post<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    required T Function(dynamic p1) decoder,
    bool requiredToken = true,
  }) async {
    try {
      if (requiredToken) {
        dio.options.headers.addAll({"withToken": true});
      }
      if (headers != null) {
        dio.options.headers = headers;
      }

      final response = await dio.post(url, queryParameters: params, data: body);

      try {
        return decoder(response.data);
      } catch (e) {
        throw const UnexpectedResponseFailure();
      }
    } on DioException catch (de) {
      if (de.error is Failure) {
        throw de.error!;
      } else {
        throw const UnknownFailure();
      }
    }
  }
}
