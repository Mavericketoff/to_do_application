import 'dart:io';

import 'package:dio/dio.dart';
import 'package:to_do_application/app/core/common/custom_exceptions.dart';
import 'package:to_do_application/app/core/utils/persistence_util.dart';

class NetworkUtil {
  static const url = 'https://beta.mrdekk.ru/todobackend';
  static const timeoutTime = 5;

  Dio? _dio;

  final PersistenceUtil _persistenceUtil;

  NetworkUtil({required PersistenceUtil persistenceUtil})
      : _persistenceUtil = persistenceUtil;

  Dio get dioInstance {
    _dio ??= Dio(BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: timeoutTime),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer uncontrastable'
      },
    ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            options.headers['X-Last-Known-Revision'] =
                await _persistenceUtil.getTasksRevision();
            handler.next(options);
          },
        ),
      );
    return _dio!;
  }

  Future<Response<dynamic>> get(String path) async {
    return await _request(() => dioInstance.get(path));
  }

  Future<Response<dynamic>> post(String path, Map<String, dynamic> data) async {
    return await _request(() => dioInstance.post(path, data: data));
  }

  Future<Response<dynamic>> delete(String path) async {
    return await _request(() => dioInstance.delete(path));
  }

  Future<Response<dynamic>> put(String path, Map<String, dynamic> data) async {
    return await _request(() => dioInstance.put(path, data: data));
  }

  Future<Response<dynamic>> patch(
      String path, Map<String, dynamic> data) async {
    return await _request(() => dioInstance.patch(path, data: data));
  }

  Future<T> _request<T>(Future<T> Function() requestFunc) async {
    try {
      return await requestFunc();
    } on DioException catch (dioError) {
      if (dioError.error is SocketException) {
        throw NoInternetCustomException();
      } else {
        throw UnknownNetworkCustomException();
      }
    } on Object catch (_) {
      throw UnknownNetworkCustomException();
    }
  }
}
