import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DebateResource extends StatefulWidget {
  @override
  _DebateResourceState createState() => _DebateResourceState();
}

class _DebateResourceState extends State<DebateResource> {
  TextEditingController _find = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.angleLeft),
          color: Colors.grey,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          controller: _find,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '搜你想搜的',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: EdgeInsets.all(10),
              child: Text('搜索', style: TextStyle(color: Colors.white)),
            ),
            onPressed: () {
              print(_find.text);
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('最近搜索'),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.trash,
                      size: 12,
                    ),
                    onPressed: () {},
                  ),
                  Text('清空')
                ],
              )
            ],
          ),
          Wrap(
            spacing: 10,
            children: <Widget>[
              Container(
                child: Text('联赛'),
                color: Colors.grey[300],
                padding: EdgeInsets.all(5),
              ),
              Container(
                child: Text('结辩'),
                color: Colors.grey[300],
                padding: EdgeInsets.all(5),
              ),
              Container(
                child: Text('质询'),
                color: Colors.grey[300],
                padding: EdgeInsets.all(5),
              ),
            ],
          ),
          Divider(),
          Text(
            '今日热搜',
            style: TextStyle(
                fontSize: 16, fontFamily: '楷书', fontWeight: FontWeight.bold),
          ),
          Divider(),
          Row(
            children: <Widget>[
              numberCard(1),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Text('陈铭  打脸'),
              ),
              numberCard(6),
              Text('二辩稿')
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              numberCard(2),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Text('结题技巧'),
              ),
              numberCard(7),
              Text('辩论群聊')
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              numberCard(3),
              SizedBox(
                child: Text('詹青云  紫荆花'),
                width: MediaQuery.of(context).size.width / 3,
              ),
              numberCard(8),
              Text('詹青云&庞颖')
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              numberCard(4),
              SizedBox(
                child: Text('最会说话的年轻人'),
                width: MediaQuery.of(context).size.width / 3,
              ),
              numberCard(9),
              Text('人生不需要辩论')
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              numberCard(5),
              SizedBox(
                child: Text('人生应递增还是递减'),
                width: MediaQuery.of(context).size.width / 3,
              ),
              numberCard(10),
              Text('女人都是最佳辩手')
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 150,
                        color: Colors.grey[200],
                        child: IconButton(icon: Icon(FontAwesomeIcons.play),onPressed: (){
                          print('20分钟前');
                        },),
                      ),
                      Container(
                        height: 30,
                        child: Center(
                          child: Text('20分钟前'),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 150,
                        color: Colors.grey[200],
                        child: Icon(FontAwesomeIcons.play),
                      ),
                      Container(
                        height: 30,
                        child: Center(
                          child: Text('50分钟前'),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 150,
                        color: Colors.grey[200],
                        child: Icon(FontAwesomeIcons.play),
                      ),
                      Container(
                        height: 30,
                        child: Center(
                          child: Text('60分钟前'),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 150,
                        color: Colors.grey[200],
                        child: Icon(FontAwesomeIcons.play),
                      ),
                      Container(
                        height: 30,
                        child: Center(
                          child: Text('2小时前'),
                        ),
                      )
                    ],
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

Container numberCard(int number) {
  return Container(
    child: Text(
      '$number',
      style: TextStyle(color: Colors.white),
    ),
    color: Colors.grey,
    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
    padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
  );
}
