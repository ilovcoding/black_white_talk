import 'package:black_white_talk/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorsUtil.hexColor(0x2a82e4),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          title: Center(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            child: RaisedButton(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                  width: 100,
                  height: 40,
                  child: Center(
                    child: Text(
                      '黑白说',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
              color: ColorsUtil.hexColor(0x17abb1),
              onPressed: () {},
            ),
          )),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset('assets/images/drawer.png'),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          child: Image.asset(
                            'assets/images/avatar.png',
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "输入昵称",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 24),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('      展示你的观点'),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: Text('以辩会友'),
                      leading: Icon(FontAwesomeIcons.userPlus),
                    ),
                    ListTile(
                      title: Text('辩手生涯'),
                      leading: Icon(FontAwesomeIcons.idCard),
                    ),
                    ListTile(
                      title: Text('辩题征集'),
                      leading: Icon(FontAwesomeIcons.bookmark),
                    ),
                    // Expanded()
                    ListTile(
                      title: Text('自建队伍'),
                      leading: Icon(FontAwesomeIcons.allergies),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          children: <Widget>[Icon(Icons.android), Text('管理')],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.key),
                            Text('登录')
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: ColorsUtil.hexColor(0x2a82e4)),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('辩论大厅'),
                  Text('辩论资源'),
                  Text('辩手排名'),
                ],
              ),
            ],
          ),
        ));
  }
}
