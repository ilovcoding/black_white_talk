import 'package:black_white_talk/static/Assets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Credit extends StatefulWidget {
  @override
  _CreditState createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        title: Text('信用管理'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            color: Colors.grey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      image: user_avatar2,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                  Text(
                    '无名',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  SizedBox()
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 5,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '我的信用积分',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      '30',
                      style: TextStyle(fontSize: 26),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.thumbsUp),
                    Text(
                      '64',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(FontAwesomeIcons.heart),
                    Text(
                      '5',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                )
              ],
            ),
          ),
          Text(
            '   详情',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  title: Text('2019/11/20  对局语言不文明 -5'),
                  subtitle: Text('2个 举报'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('2019/11/28  未完成对局 -5'),
                  subtitle: Text('5个 举报'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('2019/11/28  对局语言 -5'),
                  subtitle: Text('5个 举报'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
