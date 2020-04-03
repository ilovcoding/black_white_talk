import 'package:dio/dio.dart';

export 'package:dio/dio.dart' show Response;

class Request {
  // 全局Dio对象
  static Dio _dio;
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;
  static Dio getInstance() {
    if (_dio == null) {
      _dio = new Dio(BaseOptions(
          connectTimeout: CONNECT_TIMEOUT, receiveTimeout: RECEIVE_TIMEOUT));
    }
    return _dio;
  }

  static void clear() {
    _dio = null;
  }

  static Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) {
    if (_dio == null) _dio = getInstance();
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  static Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) {
    if (_dio == null) _dio = getInstance();
    return _dio.post(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }
}
