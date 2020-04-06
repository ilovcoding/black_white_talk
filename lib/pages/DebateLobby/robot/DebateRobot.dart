import 'dart:convert';

import 'package:black_white_talk/utils/Storage.dart';
import 'package:black_white_talk/utils/tencentAI.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';

class DebateRobot extends StatefulWidget {
  @override
  _DebateRobotState createState() => _DebateRobotState();
}

class _DebateRobotState extends State<DebateRobot> {
  TextEditingController textController = new TextEditingController();
  String token = "";
  List<Card> talkCard = [];

  @override
  void initState() {
    Storage.getString(Storage.token)
        .then((onValue) => {token = onValue.substring(0, 10)});
    super.initState();
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
                controller: textController,
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
          FlatButton(
            onPressed: () async {
              print(token);
              var res = await talk(textController.text, token);

              if (res['ret'] != 0) {
                showToast("请重新尝试发送");
              } else {
                List<Card> _talkCard = talkCard;
                _talkCard
                  ..add(
                    Card(
                      child: ListTile(
                        title: Text(
                          textController.text,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        dense: true,
                      ),
                    ),
                  )
                  ..add(
                    Card(
                      child: ListTile(
                        title: Text(res['data']['answer']),
                        dense: true,
                      ),
                    ),
                  );
                setState(() {
                  talkCard = _talkCard;
                });
                textController.clear();
              }
            },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "模拟辩论区",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(children: talkCard),
          ),
          _submitText(),
        ],
      ),
    );
  }
}
