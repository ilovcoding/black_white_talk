import 'package:black_white_talk/static/Assets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DebateFriend extends StatefulWidget {
  @override
  _DebateFriendState createState() => _DebateFriendState();
}

class _DebateFriendState extends State<DebateFriend> {
  int _index = 1;
  void changeIndex(index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.grey),
        actions: <Widget>[
          Icon(FontAwesomeIcons.plus),
          SizedBox(
            width: 20,
          )
        ],
        title: Center(
          child: Text(
            '黑白说',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            color: Colors.grey[200],
            textColor: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.search,
                  size: 15,
                ),
                Text("搜索"),
              ],
            ),
            onPressed: () {},
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  OutlineButton(
                    borderSide: _index == 1
                        ? BorderSide(color: Colors.pinkAccent)
                        : BorderSide(color: Colors.grey),
                    textColor: _index == 1 ? Colors.pinkAccent : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Text('辩友'),
                    onPressed: () {
                      changeIndex(1);
                    },
                  ),
                  OutlineButton(
                    child: Text('辩论队'),
                    borderSide: _index == 2
                        ? BorderSide(color: Colors.pinkAccent)
                        : BorderSide(color: Colors.grey),
                    textColor: _index == 2 ? Colors.pinkAccent : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      changeIndex(2);
                    },
                  )
                ],
              ),
            ],
          ),
          _index == 1
              ? Column(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            image: user_avatar,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          width: 50,
                          height: 50,
                        ),
                        title: Text('某人'),
                        subtitle: Text('开心辩论每一天'),
                        trailing: Icon(Icons.more_vert),
                        isThreeLine: true,
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            image: user_avatar2,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          width: 50,
                          height: 50,
                        ),
                        title: Text('无名'),
                        subtitle: Text('无名 请求添加你为好友'),
                        trailing: Icon(Icons.more_vert),
                        isThreeLine: true,
                      ),
                    )
                  ],
                )
              : Column(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        leading: Container(
                          child: FlutterLogo(size: 72.0),
                        ),
                        title: Text('电气学院辩论队'),
                        subtitle: Text('某人 上午10点10分加入'),
                        trailing: Icon(Icons.more_vert),
                        isThreeLine: true,
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Container(
                          child: FlutterLogo(size: 72.0),
                        ),
                        title: Text('电气学院辩论队'),
                        subtitle: Text('通知 1月1号有新的辩论比赛'),
                        trailing: Icon(Icons.more_vert),
                        isThreeLine: true,
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
