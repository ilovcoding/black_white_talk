import 'dart:convert';

import 'package:black_white_talk/api/Debate.dart';
import 'package:black_white_talk/pages/DebateLobby/home/debate/Debate.dart';
import 'package:black_white_talk/pages/DebateLobby/home/debate/Wait.dart';
import 'package:black_white_talk/utils/Storage.dart';
import 'package:black_white_talk/utils/enum.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:black_white_talk/utils/utils.dart';

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

List _homelist = [];

class _HomeListState extends State<HomeList> {
  @override
  void initState() {
    // TODO: implement initState
    getViewList();
    if (socket.connected == false) {
      socket.open();
    }
    super.initState();
  }

  @override
  void dispose() {
    _homelist.clear();
    super.dispose();
  }

  void getViewList() async {
    var res = await DebateApi.api.homeList();

    setState(() {
      _homelist.addAll(res);
    });
    // print(_homelist);
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }

  List<String> _userTypes = [
    '主席',
    '正方一辩',
    '正方二辩',
    '正方三辩',
    '正方四辩',
    '反方一辩',
    '反方二辩',
    '反方三辩',
    '反方四辩',
  ];
  SimpleDialogOption _buildSimpleDialogOption(
    String homeid,
    Identity userType,
  ) {
    // 上传Homeid ,uid,和用户的选择
    return SimpleDialogOption(
      child: OutlineButton(
        child: Text(_userTypes[userType.index]),
        onPressed: () async {
          var res = await DebateApi.api.selectRole(FormData.fromMap({
            'homeid': homeid,
            'userType': userType.index + 1,
          }));
          // print(res);
          if (res == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Wait(
                  homeid: homeid,
                  userType: userType,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  /// homeid 相关的信息
  SimpleDialog _selectUserType(var data) {
    return SimpleDialog(
        title: Text(
          "  请选择你的身份",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        children: Identity.values.map<SimpleDialogOption>((Identity userType) {
          return _buildSimpleDialogOption(data['homeid'], userType);
        }).toList());
  }

  Card listItem(var item) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () async {
          await _handleCameraAndMic();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _selectUserType(item);
            },
          );
        },
        child: Container(
          padding: EdgeInsets.all(10),
          width: 300,
          height: 200,
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    item['title'],
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '空闲中',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.lightBlue,
                    ),
                  )
                ],
              ),
              Text(
                '正方观点',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(item['positive']),
              Divider(),
              Text(
                '反方观点',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(item['negative']),
              Divider(),
              Text(
                '辩题简介',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(item['brief'])
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      color: Colors.white,
      child: ListView(children: _homelist.map<Card>(listItem).toList()),
    );
  }
}
