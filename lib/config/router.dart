import 'package:black_white_talk/components/Loading/Loading.dart';
import 'package:black_white_talk/pages/Collection/Collectiuon.dart';
import 'package:black_white_talk/pages/Create/Create.dart';
import 'package:black_white_talk/pages/DebateFriend/DebateFriend.dart';
import 'package:black_white_talk/pages/DebateLife/DebateLife.dart';
import 'package:black_white_talk/pages/Home/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteName {
  static const String login = 'login';
  static const String home = '/';
  static const String debateFriend = '/debatefriend';
  static const String debateLife = '/debatelife';
  static const String collection = '/collection';
  static const String create = '/create';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(builder: (_) => Home());
      case RouteName.login:
        return MaterialPageRoute(builder: (_) => Loading());
      case RouteName.debateFriend:
        return MaterialPageRoute(builder: (_) => DebateFriend());
      case RouteName.debateLife:
        return MaterialPageRoute(builder: (_) => DebateLife());
      case RouteName.collection:
        return MaterialPageRoute(builder: (_) => Collection());
      case RouteName.create:
        return MaterialPageRoute(builder: (_) => Create());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('The page ${settings.name} is  not found'),
            ),
          ),
        );
    }
  }
}
