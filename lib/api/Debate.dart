import 'package:black_white_talk/utils/request/Request.dart';
import 'package:dio/dio.dart';

class DebateApi {
  static DebateApi api = new DebateApi();
  Future homeList() {
    Future res = Request.getMethod('/getHomeList');
    return res;
  }

  Future userInfo() {
    Future res = Request.getMethod('/getUserInfoByToken');
    return res;
  }

  Future selectRole(FormData homeid){
    return Request.postFormData('/selectRole', homeid);
  }
}
