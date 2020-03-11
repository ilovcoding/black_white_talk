import 'package:black_white_talk/Service/login/LoginService.dart';
import 'package:black_white_talk/utils/Storage.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

String username = "昵称";
Image avatar = Image.asset('assets/images/avatar.png');

class _UserInfoState extends State<UserInfo> {
  void getUserInfo() async {
    var res = await LoginService.service.userInfo();
    if (res['name'] != null) {
      setState(() {
        username = res['name'];
        avatar = Image.network(res['avatar']);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Storage.getBool(Storage.hasLogin).then((onValue) {
      if (onValue == true) {
        getUserInfo();
      } else {
        username = "昵称";
        avatar = Image.asset('assets/images/avatar.png');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Container(width: 40, height: 40, child: avatar),
        SizedBox(
          width: 10,
        ),
        Text(
          username,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 24),
        )
      ],
    );
  }
}
