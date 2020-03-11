import 'package:black_white_talk/utils/request/Request.dart';
import 'package:dio/dio.dart';

class LoginApi {
  Future login(FormData data) {
    Future res = Request.postFormData('/login', data);
    return res;
  }
  Future userInfo() {
    Future res = Request.getMethod('/getUserInfoByToken');
    return res;
  }
}
