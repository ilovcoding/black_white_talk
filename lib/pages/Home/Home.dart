import 'package:black_white_talk/components/permission/LoginPermission.dart';
import 'package:black_white_talk/config/router.dart';
import 'package:black_white_talk/pages/Home/UserInfo.dart';
import 'package:black_white_talk/static/Assets.dart';
import 'package:black_white_talk/utils/Storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';

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
      appBar: appBar(),
      // 左侧抽屉版块
      drawer: Drawer(child: leftDrawer()),
      body: Container(
        padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(color: Colors.white),
        child: ListView(
          children: <Widget>[
            //辩论大厅模块
            router(debateLobby(), RouteName.debateLoddy),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // 辩论资源模块
                router(resource(), RouteName.debateResource),
                SizedBox(
                  width: 10.0,
                ),
                // 排名模块
                router(ranking(), RouteName.ranking)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // 推荐辩论课程的组件
            Text(
              "辩论课程推荐",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // @test 先跳转到登录
            router(debateCourse(), RouteName.debateCourse)
          ],
        ),
      ),
    );
  }

  Listener router(Widget container, String route) {
    return Listener(
      child: container,
      onPointerDown: (e) async {
        if (route == RouteName.debateLoddy) {
          // 校验辩论大厅的token
          var $token = await Storage.getBool(Storage.hasLogin);
          if ($token != true) {
            showToast('请您先登录');
            return null;
          }
        }
        Navigator.pushNamed(context, route);
      },
    );
  }

  Container ranking() {
    return Container(
      height: MediaQuery.of(context).size.height / 6.0,
      width: MediaQuery.of(context).size.height / 6.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 5.0,
            offset: Offset(5.0, 5.0),
            spreadRadius: 2.0,
          )
        ],
      ),
      child: Center(
        child: Text(
          '辩手\n排名',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
      ),
    );
  }

  Container resource() {
    return Container(
      height: MediaQuery.of(context).size.height / 6.0,
      width: MediaQuery.of(context).size.height / 6.0,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 5.0,
            offset: Offset(5.0, 5.0),
            spreadRadius: 2.0,
          )
        ],
      ),
      child: Center(
        child: Text(
          '辩论\n资源',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }

  // 辩论大厅
  Container debateLobby() {
    return Container(
      height: MediaQuery.of(context).size.height / 4.0,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 5.0,
            offset: Offset(5.0, 5.0),
            spreadRadius: 2.0,
          )
        ],
      ),
      child: Center(
        child: Text(
          '辩论大厅',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      titleSpacing: MediaQuery.of(context).size.width / 6.0,
      elevation: 1,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: RaisedButton(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            width: 100,
            height: 40,
            child: Center(
              child: Text(
                '黑白说',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          color: Colors.grey,
          onPressed: () {},
        ),
      ),
    );
  }

  void singOut() {
    Storage.delByKey(Storage.hasLogin);
    Navigator.of(context).pop();
  }

  // 左侧抽屉用户信息板块
  Row drawUserInfo() {
    return Row(
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
          "昵称",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 24),
        )
      ],
    );
  }

  LoginPermission singInSingOut() {
    return LoginPermission(
      noLogin: router(
        Row(
          children: <Widget>[Icon(FontAwesomeIcons.key), Text('登录/注册')],
        ),
        RouteName.login,
      ),
      login: FlatButton(
        child: Row(
          children: <Widget>[Icon(FontAwesomeIcons.signOutAlt), Text('注销')],
        ),
        onPressed: () {
          singOut();
        },
      ),
    );
  }

  // 左侧 抽屉版块
  Widget leftDrawer() {
    return ListView(
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
              UserInfo(),
              SizedBox(
                height: 20,
              ),
              Text('      展示你的观点'),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text('辩论社区'),
                leading: Icon(FontAwesomeIcons.userPlus),
                onTap: () {
                  Navigator.pushNamed(context, RouteName.debateFriend);
                },
              ),
              ListTile(
                title: Text('辩手生涯'),
                leading: Icon(FontAwesomeIcons.idCard),
                onTap: () {
                  Navigator.pushNamed(context, RouteName.debateLife);
                },
              ),
              ListTile(
                title: Text('辩题征集'),
                leading: Icon(FontAwesomeIcons.bookmark),
                onTap: () {
                  Navigator.pushNamed(context, RouteName.collection);
                },
              ),
              // Expanded()
              ListTile(
                title: Text('自建队伍'),
                leading: Icon(FontAwesomeIcons.allergies),
                onTap: () {
                  Navigator.pushNamed(context, RouteName.create);
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.android),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteName.setting);
                        },
                      ),
                      Text('管理')
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  // 登录注销 模块
                  singInSingOut(),
                  SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Container debateCourse() {
    return Container(
      alignment: Alignment.centerLeft,
      height: MediaQuery.of(context).size.height / 5.0,
      decoration: BoxDecoration(
        image: lessonbg,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Text(
        '  优秀辩论课程推荐',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
