import 'package:black_white_talk/utils/Storage.dart';
import 'package:flutter/material.dart';

class LoginPermission extends StatefulWidget {
  LoginPermission({Key key, @required this.noLogin, @required this.login})
      : super(key: key);
  Widget noLogin;
  Widget login;
  @override
  _LoginPermissionState createState() => _LoginPermissionState();
}

class _LoginPermissionState extends State<LoginPermission> {
  bool permission = false;
  @override
  void initState() {
    login();
    super.initState();
  }

  void login() async {
    bool hasLogin = await Storage.getBool(Storage.hasLogin);
    setState(() {
      permission = hasLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return permission == true ? widget.login : widget.noLogin;
  }
}
