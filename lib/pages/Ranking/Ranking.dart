import 'package:flutter/material.dart';

class Ranking extends StatefulWidget {
  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentTabsIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '辩手排名区',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          unselectedLabelColor: Colors.black,
          labelColor: Colors.redAccent,
          controller: _tabController,
          indicator: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.red)),
          ),
          labelPadding: EdgeInsets.all(0),
          tabs: <Widget>[
            Tab(
              child: Text('最强辩手'),
            ),
            Tab(
              child: Text('最佳辩友'),
            ),
            Tab(
              child: Text('辩论新秀'),
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: listwidget),
    );
  }
}

List<Widget> _listwiget = [Text('1'), Text('2'), Text('3')];
List<Widget> listwidget = _listwiget
    .map((e) => ListView(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(6),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 40,
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/images/user_avatar2.png'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text('我'), Text('第1名')],
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Text('获赞次数:  10'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 40,
                    child: Text(
                      '1',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/images/user_avatar2.png'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text('我'), Text('第1名')],
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Text('获赞次数:  10'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 40,
                    child: Text(
                      '2',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/images/user_avatar.png'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text('某某'), Text('第2名')],
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Text('获赞次数:  9'),
                ],
              ),
            )
          ],
        ))
    .toList();
