import 'package:black_white_talk/config/router.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme:
            TextTheme(title: TextStyle(color: Colors.black, fontSize: 24)),
        title: Text(
          '黑白说',
        ),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(FontAwesomeIcons.clock),
            title: Text('辩论须知'),
            onTap: (){
              Navigator.pushNamed(context,RouteName.needtoknown);
            },
            trailing: Icon(FontAwesomeIcons.angleRight),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.mapMarkerAlt),
            title: Text('个人信誉管理'),
            trailing: Icon(FontAwesomeIcons.angleRight),
            onTap: (){
              Navigator.pushNamed(context, RouteName.credit);
            },
          ),
        ],
      ),
    );
  }
}
