import 'dart:convert';

import 'package:black_white_talk/utils/CodeUtils.dart';
import 'package:dio/dio.dart';

/// 腾讯AI 平台相关接口
/// 获取签名接口
Map params(Map paramsMap) {
  String appKey = "urqkpdZ30LplLERY";
  String _str = "";
  paramsMap.forEach((var key, var value) {
    String _value = "${value}";
    _str += "${key}=${Uri.encodeQueryComponent(_value)}&";
  });

  _str += "app_key=${appKey}";

  String sign = toMD5(_str).toUpperCase();
  Map<String, dynamic> signMap = {"sign": sign};
  paramsMap.addAll(signMap);
  return paramsMap;
}

/// 获取智能机器人返回内容的接口
Future talk(String content, String session) async {
  Map<String, dynamic> paramsMap = {
    "app_id": 2131914767,
    "nonce_str": DateTime.now().millisecondsSinceEpoch.toString(),
    "question": content,
    "session": session,
    "time_stamp": DateTime.now().millisecondsSinceEpoch ~/ 1000,
  };
  Map<String, dynamic> _params = params(paramsMap);

  Dio dio = new Dio(
    BaseOptions(
      baseUrl: "https://api.ai.qq.com/fcgi-bin",
      sendTimeout: 10000,
      receiveTimeout: 10000,
      method: "POST",
      contentType: 'application/x-www-form-urlencoded',
    ),
  );

  var res = await dio.post('/nlp/nlp_textchat', queryParameters: _params);
  return res.data;
}

// main() {
//   talk('', "session1");
// }
