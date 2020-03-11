import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';
import '../Storage.dart';

void sslCertificate(Dio _dio) {
  (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) {
      return true;
    };
  };
}

class Request {
  static Future request(String method, String path, var data) async {
    String usernameToken = await Storage.getString(Storage.token);
    Dio dio = new Dio(
      BaseOptions(
        baseUrl: "http://192.168.1.12:3000",
        sendTimeout: 10000,
        receiveTimeout: 10000,
        method: method,
        headers: {
          'token': usernameToken,
        },
      ),
    );
    sslCertificate(dio);
    Response res;
    try {
      res = await dio.request(
        path,
        data: data,
      );
    } catch (e) {
      if (e != null) {
        showToast('网络请求错误');
      }
    }
    return res.data;
  }

  static getMethod(String router, {params}) async {
    dynamic res = await request('GET', router, params);
    return checkRes(res);
  }

  static postFormData(router, FormData params) async {
    dynamic res = await request('POST', router, params);
    return checkRes(res);
  }

  static Future checkRes(dynamic res) async {
    /// 状态码 详细信息 看语雀文档 [https://www.yuque.com/hfutonline666/kl1wzz/wrem48]
    // 2000 请求成功标志
    if (res['errMsg'] != null) {
      showToast(res['errMsg']);
    }
    if (res['code'] == 2000) {
      return res['data'];
    }
  }
}
