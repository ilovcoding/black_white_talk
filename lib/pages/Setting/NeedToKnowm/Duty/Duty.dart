import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Duty extends StatefulWidget {
  @override
  _DutyState createState() => _DutyState();
}

class _DutyState extends State<Duty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  width: 50,
                  height: 50,
                ),
                title: Text(
                  '辩论会主席责任',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height/1.6,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('1.辩论赛开始'),
                  Text('2.宣布辩题'),
                  Text('3.介绍代表队及所持立场'),
                  Text('4.介绍参赛队员'),
                  Text('5.介绍规则，评委及工作人员'),
                  Text('6.辩论比赛'),
                  Text('7.评委点评'),
                  Text('8.观众自由提问，评委评分（同时进行）'),
                  Text('9.宣布比赛结果'),
                  Text('10.辩论赛结束')
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.reply),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text('我知道了')
              ],
            )
          ],
        ),
      ),
    );
  }
}
