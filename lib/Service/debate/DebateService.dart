import 'package:black_white_talk/api/Login.dart';
import 'package:black_white_talk/utils/CodeUtils.dart';
import 'package:black_white_talk/utils/Storage.dart';
import 'package:dio/dio.dart';

class DebateService {
  static DebateService service = new DebateService();
  LoginApi api = new LoginApi();

  Future login(String username, String password) async {
    password = tosha256(password);
    FormData userInfo = FormData.fromMap({
      'username': username,
      'password': password,
    });
    bool res = await api.login(userInfo);
    if (res != null) {
      Storage.storageString(Storage.token, tosha256(username));
      Storage.storageBoolen(Storage.hasLogin, res);
      return res;
    } else {
      Storage.delByKey(Storage.hasLogin);
      return false;
    }
  }

  Future userInfo() async {
    return api.userInfo();
  }
}
