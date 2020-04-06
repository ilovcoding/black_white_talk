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

  Future selectRole(FormData homeid) {
    return Request.postFormData('/selectRole', homeid);
  }

  Future getRolesInfo(FormData homeid) {
    return Request.postFormData('/getRolesInfo', homeid);
  }

  Future getSpeak(FormData homeid) {
    return Request.postFormData('/getSpeak', homeid);
  }

  Future controlDebate(FormData data) {
    return Request.postFormData('/controlDebate', data);
  }

  Future audioControl(FormData data) {
    return Request.postFormData('/audioControl', data);
  }
  Future findDebateHome(FormData data){
    return Request.postFormData('/findDebateHome', data);
  }
 Future recentlyHomeList(){
   return Request.getMethod('/recentlyHomeList');
 }
}
