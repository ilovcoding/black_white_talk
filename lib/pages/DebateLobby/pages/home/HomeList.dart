import 'package:black_white_talk/api/Debate.dart';

import 'package:flutter/material.dart';

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
    super.initState();
  }

  void getViewList() async {
    var res = await DebateApi.api.homeList();
    _homelist.addAll(res);
    print(_homelist);
  }

  Card listItem(var item) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print(item['homeid']);
          
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
