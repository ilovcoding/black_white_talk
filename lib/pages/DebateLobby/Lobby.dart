import 'package:black_white_talk/config/router.dart';
import 'package:black_white_talk/static/Assets.dart';
import 'package:black_white_talk/utils/agora.dart';
import 'package:black_white_talk/utils/enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';

class DebateLobby extends StatefulWidget {
  @override
  _DebateLobbyState createState() => _DebateLobbyState();
}

class _DebateLobbyState extends State<DebateLobby>
    with SingleTickerProviderStateMixin {
  TextEditingController _findContext = TextEditingController();
  TabController _tabController;
  int _currentTabsIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    socket.disconnect();
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => _handleTabsChange());
  }

  _handleTabsChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentTabsIndex = _tabController.index;
      });
    }
  }

  RegExp homeNum = RegExp(r'^[0-9]*$');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.angleLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          controller: _findContext,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixIcon: Icon(
              FontAwesomeIcons.search,
              color: Colors.white,
              size: 15,
            ),
            border: InputBorder.none,
            hintText: '请输入辩题',
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        actions: <Widget>[
          SizedBox(
            height: 30,
            child: FlatButton(
              textColor: Colors.black,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text('查找'),
              ),
              onPressed: () {
                if (_findContext.text != '' &&
                    homeNum.hasMatch(_findContext.text)) {
                  return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: Text(
                          '欢迎来到辩场${_findContext.text}',
                          style: TextStyle(fontFamily: '楷书'),
                        ),
                        children: <Widget>[
                          Text(
                            "  请选择你的身份",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          SimpleDialogOption(
                            child: OutlineButton(
                              child: Text('主席'),
                              onPressed: () {
                                Navigator.pop(context, Identity.ChairMan);
                              },
                            ),
                          ),
                          SimpleDialogOption(
                            child: OutlineButton(
                              child: Text('辩手'),
                              onPressed: () {
                                Navigator.pop(context, Identity.ChairMan);
                              },
                            ),
                          ),
                          SimpleDialogOption(
                            child: OutlineButton(
                              child: Text('评委'),
                              onPressed: () {
                                Navigator.pop(context, Identity.ChairMan);
                              },
                            ),
                          ),
                          SimpleDialogOption(
                            child: OutlineButton(
                              child: Text('观众'),
                              onPressed: () {
                                Navigator.pop(context, Identity.ChairMan);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showToast('请输入纯数字的房间号');
                  return null;
                }
              },
            ),
          )
        ],
      ),
      body: ListView(
        // physics: PageScrollPhysics(),
        children: <Widget>[
          Container(
            // margin: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: 160,
            child: Swiper(
              loop: true,
              autoplay: true,
              duration: 6000, //间隔6秒
              autoplayDelay: 6000,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.fill,
                );
              },
              itemCount: 4,
              pagination: new SwiperPagination(),
            ),
          ),
          TabBar(
            controller: _tabController,
            indicator: BoxDecoration(color: Colors.grey),
            unselectedLabelColor: Colors.black,
            labelPadding: EdgeInsets.all(0),
            tabs: <Widget>[
              Tab(
                child: Text('专业辩手区'),
              ),
              Tab(
                child: Text('辩论爱好者'),
              ),
            ],
          ),
          _currentTabsIndex == 0
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.users,
                                size: 40,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RouteName.homeList);
                              },
                            ),
                            Text('自由预约比赛', style: TextStyle(color: Colors.grey))
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.archway,
                              size: 40,
                            ),
                            Text('最佳联手联赛', style: TextStyle(color: Colors.grey))
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.university,
                              size: 40,
                            ),
                            Text('高校友谊赛', style: TextStyle(color: Colors.grey))
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.school,
                              size: 40,
                            ),
                            Text('高校排位赛', style: TextStyle(color: Colors.grey))
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 10,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.userClock,
                              size: 40,
                            ),
                            Text('单人匹配', style: TextStyle(color: Colors.grey))
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.robot,
                              size: 40,
                            ),
                            Text('人机模拟辩论', style: TextStyle(color: Colors.grey))
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.university,
                              size: 40,
                            ),
                            Text('自定义比赛', style: TextStyle(color: Colors.grey))
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.arrowAltCircleUp,
                              size: 40,
                            ),
                            Text('辩手晋级赛', style: TextStyle(color: Colors.grey))
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 10,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    '近期赛事',
                    style: TextStyle(fontSize: 20),
                  ),
                  alignment: Alignment.topLeft,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text('1天后'),
                    SizedBox(
                      width: 20,
                    ),
                    Text('2020高校辩论排位赛')
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text('3天后'),
                    SizedBox(
                      width: 20,
                    ),
                    Text('电气学院机械学院辩论赛')
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
