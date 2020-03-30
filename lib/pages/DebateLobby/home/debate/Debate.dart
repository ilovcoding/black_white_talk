import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:black_white_talk/utils/Event.dart';
import 'package:black_white_talk/utils/request/Request.dart';
import 'package:black_white_talk/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';

class Debate extends StatefulWidget {
  final String homeid;
  Debate({Key key, this.homeid}) : super(key: key);
  @override
  _DebateState createState() => _DebateState();
}

class _DebateState extends State<Debate> {
  String homeName = "";
  List<dynamic> _userList = [];
  @override
  void dispose() {
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    // 获取辩题
    getHomeName();
    //  获取成员信息
    getRoleInfo();
    super.initState();
  }

  void getHomeName() async {
    String _title = await Request.postFormData(
      '/homeName',
      FormData.fromMap({
        "homeid": widget.homeid,
      }),
    );
    setState(() {
      homeName = _title;
    });
  }

  void getRoleInfo() async {
    int oldUserListLength = _userList.length;
    socket.emit('getuser', widget.homeid);
    String ongetuser = "getuser${widget.homeid}";
    socket.on(ongetuser, (var data) {
      if (oldUserListLength != data.length) {
        if (mounted) {
          oldUserListLength = data.length;
          setState(() {
            _userList = data;
          });
        }
      }
    });
  }

  Container titleContainer() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 50, 0),
      child: RaisedButton(
          color: Colors.grey,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            // width: 100,
            height: 40,
            child: Center(
              child: Text(
                homeName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onPressed: null),
    );
  }

  Widget _submitText() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Icon(FontAwesomeIcons.keyboard),
          SizedBox(width: 10),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 70,
              ),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.tag_faces),
            onPressed: () {
              print('2222222');
            },
          ),
          FlatButton(
            onPressed: () {},
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Text(
                '发送',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _msgInfo() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              width: 60,
              child: Text(
                '文\n本\n消\n息',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              decoration: BoxDecoration(color: Colors.grey[200]),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: ListView(
                children: <Widget>[
                  Text(
                    '某：正方一辩逻辑感好强',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '某某：感觉正方要输了，完全不是对手啊',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: Icon(Icons.backspace),
        title: Center(child: titleContainer()),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('正方一辩论'),
                    Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/images/user_avatar2.png'),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('正方二辩论'),
                    Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/images/user_avatar2.png'),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('正方三辩论'),
                    Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/images/user_avatar2.png'),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('正方四辩论'),
                    Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/images/user_avatar2.png'),
                    )
                  ],
                )
              ],
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.microphoneAlt,
                        size: 60,
                        color: Colors.lightBlue,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '   点击开始',
                    style: TextStyle(
                        color: Colors.lightBlue, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('反方一辩论'),
                    Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/images/user_avatar.png'),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('反方二辩论'),
                    Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/images/user_avatar.png'),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('反方三辩论'),
                    Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/images/user_avatar.png'),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('反方四辩论'),
                    Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/images/user_avatar.png'),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      // msgInfo(),
      // submitText()
    );
  }
}
