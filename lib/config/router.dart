import 'package:black_white_talk/pages/Collection/Collectiuon.dart';
import 'package:black_white_talk/pages/Create/Create.dart';
import 'package:black_white_talk/pages/DebateFriend/DebateFriend.dart';
import 'package:black_white_talk/pages/DebateLife/DebateLife.dart';
import 'package:black_white_talk/pages/DebateLobby/Lobby.dart';
import 'package:black_white_talk/pages/DebateLobby/home/HomeList.dart';
import 'package:black_white_talk/pages/DebateLobby/home/debate/Debate.dart';
import 'package:black_white_talk/pages/DebateResource/DebateResource.dart';
import 'package:black_white_talk/pages/Home/Home.dart';
import 'package:black_white_talk/pages/Login/Login.dart';
import 'package:black_white_talk/pages/Ranking/Ranking.dart';
import 'package:black_white_talk/pages/Register/Register.dart';
import 'package:black_white_talk/pages/Setting/Credit/Credit.dart';
import 'package:black_white_talk/pages/Setting/NeedToKnowm/Duty/Duty.dart';
import 'package:black_white_talk/pages/Setting/NeedToKnowm/NeedToKnow.dart';
import 'package:black_white_talk/pages/Setting/NeedToKnowm/Rules/Rules.dart';
import 'package:black_white_talk/pages/Setting/Setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteName {
  static const String login = '/login';
  static const String home = '/';
  static const String debateFriend = '/debatefriend';
  static const String debateLife = '/debatelife';
  static const String collection = '/collection';
  static const String create = '/create';
  // 辩论大厅
  static const String debateLoddy = '/debateLoddy';
  static const String setting = '/setting';
  static const String needtoknown = '/setting/needtoknown';
  static const String credit = '/setting/credit';
  static const String duty = '/setting/credit/duty';
  static const String rules = '/setting/credit/rules';
  static const String ranking = '/ranking';
  static const String debateResource = '/debateResource';
  static const String debate = '/debate';
  static const String register = '/register';
  static const String homeList = '/debate/homelist';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(builder: (_) => Home());
      case RouteName.login:
        return MaterialPageRoute(builder: (_) => Login());
      case RouteName.debateFriend:
        return MaterialPageRoute(builder: (_) => DebateFriend());
      case RouteName.debateLife:
        return MaterialPageRoute(builder: (_) => DebateLife());
      case RouteName.collection:
        return MaterialPageRoute(builder: (_) => Collection());
      case RouteName.create:
        return MaterialPageRoute(builder: (_) => Create());
      case RouteName.debateLoddy:
        return MaterialPageRoute(builder: (_) => DebateLobby());
      case RouteName.setting:
        return MaterialPageRoute(builder: (_) => Setting());
      case RouteName.needtoknown:
        return MaterialPageRoute(builder: (_) => NeedToKonwn());
      case RouteName.credit:
        return MaterialPageRoute(builder: (_) => Credit());
      case RouteName.duty:
        return MaterialPageRoute(builder: (_) => Duty());
      case RouteName.rules:
        return MaterialPageRoute(builder: (_) => Rules());
      case RouteName.ranking:
        return MaterialPageRoute(builder: (_) => Ranking());
      case RouteName.debateResource:
        return MaterialPageRoute(builder: (_) => DebateResource());
      case RouteName.debate:
        return MaterialPageRoute(builder: (_) => Debate());
      case RouteName.register:
        return MaterialPageRoute(builder: (_) => Register());
      case RouteName.homeList:
        return MaterialPageRoute(builder: (_) => HomeList());
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
