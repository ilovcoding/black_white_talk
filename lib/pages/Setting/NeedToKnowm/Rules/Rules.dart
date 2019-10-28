import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Rules extends StatefulWidget {
  @override
  _RulesState createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  TextStyle _headtextStyle = TextStyle(
    fontSize: 16,
    fontFamily: "楷书",
    fontWeight: FontWeight.bold,
  );
  TextStyle _bodytextStyle = TextStyle(
    fontSize: 14,
    fontFamily: "楷书",
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
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
                  '辩论规则',
                  style: TextStyle(color: Colors.black),
                ),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(FontAwesomeIcons.reply),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text("返回")
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '【辩方陈词立论阶段】',
                    style: _headtextStyle,
                  ),
                  Text('1. 内容：由正、反双方一辩先后陈述己方主要观点。'),
                  Text('2.时间：各3分钟，剩余30秒会有声音提示，不得超时。'),
                  Text('3.要求：双方必须从理论和实际两个方面进行立论，表达明确，论证恰当，逻辑清晰。'),
                  Text('【四盘一阶段】',style: _headtextStyle,),
                  Text('1.内容：先由反方四辩盘问正方一辩，再由正方四辩盘问反方一辩。'),
                  Text('2.时间：各两分钟，盘问方每次提问不得超过15秒，被盘问方每次回答不得超过45秒。'),
                  Text('3.要求：提问和回答都要简明准确，被盘问方不得反问。1， 立论盘问环节： '),
                  Text('【小结】：',style: _headtextStyle,),
                  Text('正方三辩进行盘问小结  三分四十秒'),
                  Text('反方三辩进行盘问小结  三分四十秒 '),
                  Text('要求：双方不可打断。'),
                  Text('1.内容：1.内容：正方二辩指定质询反方任意一名辩手；  反方任意一名辩手制定质询正方任意一名辩手。'),
                  Text('2.时间：各3分钟，提问方80秒，回答方100秒。'),
                  Text('【攻辩】',style: _headtextStyle,),
                  Text('1.内容：依次由正，反方三辩盘问对方三，四辩。'),
                  Text('2.时间：四分钟。'),
                  Text('3.要求：双方不可打断。100秒。'),
                  Text('【自由辩】',style: _headtextStyle,),
                  Text('共八分钟，各四分钟，分别计时。'),
                  Text('【总结陈词】：',style: _headtextStyle,),
                  Text('反方四辩总结陈词          四分钟 '),
                  Text('正方四辩总结陈词          四分钟')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
