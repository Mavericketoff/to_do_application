import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:to_do_application/app/core/common/custom_exceptions.dart';
import 'package:to_do_application/app/core/utils/persistence_util.dart';

class NetworkUtil {
  static const url = 'https://beta.mrdekk.ru/todobackend';
  static const timeoutTime = 5;

  Dio? _dio;

  final PersistenceUtil _persistenceUtil;

  NetworkUtil({required persistenceUtil}) : _persistenceUtil = persistenceUtil;

  Dio get dioInstance {
    _dio ??= Dio(BaseOptions(
        baseUrl: url,
        connectTimeout: const Duration(seconds: timeoutTime),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer uncontrastable'
        }))
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

  Future<Response> get(String path) async {
    return _request(() => dioInstance.get(path));
  }

  Future<Response> post(String path, Map<String, dynamic> data) async {
    return _request(() => dioInstance.post(path, data: data));
  }

  Future<Response> delete(String path) async {
    return _request(() => dioInstance.delete(path));
  }

  Future<Response> put(String path, Map<String, dynamic> data) async {
    return _request<Response>(() => dioInstance.put(path, data: data));
  }

  Future<Response> patch(String path, Map<String, dynamic> data) async {
    return _request<Response>(() => dioInstance.patch(path, data: data));
  }

  Future<T> _request<T>(Future<T> Function() requestFunc) async {
    try {
      return await requestFunc();
    } on DioException catch (dioException) {
      switch (dioException.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.cancel:
        case DioExceptionType.connectionError:
          throw NoInternetCustomException();
        case DioExceptionType.badResponse:
          throw ResponseCustomException('Bad response');
        default:
          if (dioException.error is SocketException) {
            throw NoInternetCustomException();
          } else {
            throw UnknownNetworkCustomException();
          }
      }
    } on SocketException catch (_) {
      throw NoInternetCustomException();
    } on Object catch (_) {
      throw UnknownNetworkCustomException();
    }
  }
}
