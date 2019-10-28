import 'package:black_white_talk/static/Assets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Container(
              width: 60,
              // height: 25,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),

              child: Text(
                '创建',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onPressed: () {
              showToast('创建成功');
            },
          ),
        ],
        title: Center(
          child: Text(
            '创建队伍',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 70,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      image: user_avatar2,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.camera,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        print('头像');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  '点击更换辩论队头像',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Table(
                  columnWidths: {
                    0: FixedColumnWidth(80),
                    1: FixedColumnWidth(MediaQuery.of(context).size.width - 80)
                  },
                  children: <TableRow>[
                    TableRow(children: [
                      Text(
                        '队名',
                        style: TextStyle(
                            color: Colors.grey, fontSize: 20, fontFamily: "楷书"),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '某某辩论队队名',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "楷书"),
                      )
                    ]),
                    TableRow(children: [
                      SizedBox(height: 10),
                      SizedBox(
                        height: 10,
                      )
                    ]),
                    TableRow(children: [
                      Text(
                        '队伍ID',
                        style: TextStyle(
                            color: Colors.grey, fontSize: 20, fontFamily: "楷书"),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '1234566666',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "楷书",
                        ),
                      )
                    ]),
                    TableRow(children: [
                      SizedBox(height: 10),
                      SizedBox(
                        height: 10,
                      )
                    ]),
                    TableRow(children: [
                      Text(
                        '成员数',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontFamily: "楷书",
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '5',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "楷书",
                        ),
                      )
                    ]),
                    TableRow(children: [
                      SizedBox(height: 10),
                      SizedBox(
                        height: 10,
                      )
                    ]),
                    TableRow(children: [
                      Text(
                        '宣言',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontFamily: "楷书",
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '最帅最强辩论队',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "楷书",
                        ),
                      )
                    ]),
                    TableRow(children: [
                      SizedBox(height: 10),
                      SizedBox(
                        height: 20,
                      )
                    ]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.grey,
                    ),
                    Text(
                      '邀请好友加入',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.grey,
                    ),
                  ],
                ),
                Card(
                  color: Colors.grey,
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
                    // subtitle: Text('无名 请求添加你为好友'),
                    trailing: FlatButton(
                      child: Text(
                        '邀请',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.red,
                      onPressed: () {},
                    ),
                    // isThreeLine: true,
                  ),
                ),
                Card(
                  color: Colors.grey,
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        image: user_avatar,000
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      width: 50,
                      height: 50,
                    ),
                    title: Text('某某'),
                    // subtitle: Text('无名 请求添加你为好友'),
                    trailing: FlatButton(
                      child: Text(
                        '邀请',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.red,
                      onPressed: () {},
                    ),
                    // isThreeLine: true,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
