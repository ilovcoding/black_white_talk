// import 'package:coursetable/pages/Course/Course.dart';
// import 'package:coursetable/pages/Course/CourseInfo/ClassMent/ClassMent.dart';
// import 'package:coursetable/pages/Course/CourseInfo/CourseInfo.dart';
// import 'package:coursetable/pages/Index.dart';
// import 'package:coursetable/pages/login/Login.dart';
// import 'package:coursetable/pages/login/OALogin.dart';
import 'package:black_white_talk/components/Loading/Loading.dart';
import 'package:black_white_talk/pages/Home/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteName {
  static const String login = 'login';
  static const String oaLogin = 'oalogin';
  static const String home = '/';
  static const String course = 'course';
  static const String courseInfo = 'course/info';
  static const String courseInfoClassment = 'course/info/classment';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(builder: (_) => Home());
      case RouteName.login:
        return MaterialPageRoute(builder: (_) => Loading());
      // case RouteName.oaLogin:
      //   return MaterialPageRoute(builder: (_) => OALogin());
      // case RouteName.course:
      //   return MaterialPageRoute(builder: (_) => Course());
      // case RouteName.courseInfo:
      //   return MaterialPageRoute(
      //       builder: (context) => CourseInfo(arguments: settings.arguments));
      // case RouteName.courseInfoClassment:
      //   return MaterialPageRoute(builder: (_) => ClassMent());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('The page ${settings.name} is  not found'),
                  ),
                ));
    }
  }
}
