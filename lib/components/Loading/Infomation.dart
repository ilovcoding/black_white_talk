import 'package:black_white_talk/config/router.dart';
import 'package:black_white_talk/static/Assets.dart';
import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(image: loadingImage170),
        child: Container(),
      ),
      onPointerDown: (e) {
        Navigator.pushReplacementNamed(context, RouteName.home);
      },
    ));
  }
}
