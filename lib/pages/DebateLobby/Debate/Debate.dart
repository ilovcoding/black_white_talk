import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Debate extends StatefulWidget {
  @override
  _DebateState createState() => _DebateState();
}

class _DebateState extends State<Debate> {
  bool _inputType = true;
  void changeInputType(bool type) {
    setState(() {
      _inputType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(Icons.backspace),
        title: FlatButton(
          child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width / 7, 0, 0, 0),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Text(
              "XXX辩场",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          onPressed: () {
            return showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  contentPadding: EdgeInsets.all(20),
                  title: Text(
                    'XXX辩场场外人员列表',
                    style: TextStyle(fontFamily: '楷书'),
                  ),
                  children: <Widget>[
                    Text(
                      '主席',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 20,
                      children: <Widget>[
                        Container(
                          width: 40,
                          height: 40,
                          child: Image.asset('assets/images/user_avatar.png'),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          child: Image.asset('assets/images/user_avatar2.png'),
                        ),
                      ],
                    ),
                    Text(
                      '  评委',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 20,
                      children: <Widget>[
                        Container(
                          width: 40,
                          height: 40,
                          child: Image.asset('assets/images/user_avatar.png'),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          child: Image.asset('assets/images/user_avatar2.png'),
                        ),
                      ],
                    ),
                    Text(
                      '观众',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 20,
                      children: <Widget>[
                        Container(
                          width: 40,
                          height: 40,
                          child: Image.asset('assets/images/user_avatar.png'),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          child: Image.asset('assets/images/user_avatar2.png'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
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
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.microphoneAlt,
                    size: 60,
                  ),
                  onPressed: () {},
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Card(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '系统\n消息',
                      style: TextStyle(fontSize: 20),
                    ),
                    decoration: BoxDecoration(color: Colors.grey[200]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '1. 正方一遍陈词结束，用时03：00;',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '2. 反方四辩盘问正方一辩结束，用时01：00.',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 60,
                    child: Text(
                      '观\n战\n消\n息',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    decoration: BoxDecoration(color: Colors.grey[200]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            scrollPadding: EdgeInsets.all(0.0),
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.grey[200],
              filled: true,
              prefix: IconButton(
                icon: _inputType
                    ? Icon(FontAwesomeIcons.keyboard)
                    : Icon(FontAwesomeIcons.microphone),
                onPressed: () {
                  changeInputType(!_inputType);
                },
              ),
              suffix: FlatButton(
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text(
                    '发送',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
