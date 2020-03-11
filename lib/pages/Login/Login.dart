import 'package:black_white_talk/Service/login/LoginService.dart';
import 'package:black_white_talk/config/router.dart';
import 'package:black_white_talk/utils/router/listenRouter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        textTheme: TextTheme(
          title: TextStyle(
              color: Colors.black,
              // fontWeight: FontWeight.bold,
              fontSize: 26),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('登录'),
        actions: <Widget>[
          Text(
            '登录遇到问题',
            style: TextStyle(
              color: Colors.grey,
              height: 3,
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
            width: MediaQuery.of(context).size.width,
            child: login(),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  TextEditingController userame = TextEditingController();
  TextEditingController password = TextEditingController();
  Column login() {
    Function router = buildRouter(context);
    return Column(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "您好,",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 40,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            Text(
              '欢迎使用黑白说, 立即',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            router(
              Text(
                '注册',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              RouteName.register,
            ),
          ],
        ),
        TextField(
          autofocus: true,
          controller: userame,
          decoration: InputDecoration(
            // labelText: "用户名",
            hintText: "注册时填的用户名",
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            prefixStyle: TextStyle(
              color: Colors.black,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
        ),
        TextField(
          controller: password,
          decoration: InputDecoration(
            labelText: "密码",
            hintText: "您的登录密码",
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.black,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          obscureText: true,
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              color: Colors.black,
              highlightColor: Colors.grey,
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text("登录"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () async {
                dynamic res = await LoginService.service
                    .login(userame.text, password.text);
                if (res) {
                  showToast('登录成功', duration: Duration(seconds: 3));
                  Navigator.pushReplacementNamed(context, RouteName.home);
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
