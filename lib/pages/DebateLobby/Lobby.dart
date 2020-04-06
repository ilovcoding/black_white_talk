import 'package:black_white_talk/api/Debate.dart';
import 'package:black_white_talk/config/router.dart';
import 'package:black_white_talk/static/Assets.dart';
import 'package:black_white_talk/utils/agora.dart';
import 'package:dio/dio.dart';
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
  List<Widget> widgets = [];
  @override
  void initState() {
    // TODO: implement initState
    socket.disconnect();
    recentlyHomeList();
    super.initState();
  }

  void recentlyHomeList() {
    DebateApi.api.recentlyHomeList().then((var onValue) {
      // TimeOfDay.fromDateTime(time)
      List _list = List.from(onValue);
      List<Widget> _widgets = [
        SizedBox(
          height: 20,
        ),
        Container(
          child: Text(
            '近期赛事',
            style: TextStyle(fontSize: 20),
          ),
          alignment: Alignment.topLeft,
        )
      ];
      _list.forEach((var data) {
        String date =  DateTime.fromMillisecondsSinceEpoch(data['timestamp']).toString();
        List<String> dataArr = date.split(" ");
        _widgets.add(SizedBox(height: 20));
        _widgets.add(Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Text("${dataArr[0]}"),
            SizedBox(
              width: 10,
            ),
            Text("${data['title']}"),
          ],
        ));
      });
      setState(() {
        widgets = _widgets;
      });
    });
  }

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
              onPressed: () async {
                if (_findContext.text == "") {
                  showToast("查找辩题不能为空");
                } else {
                  var res = await DebateApi.api.findDebateHome(
                      FormData.fromMap({'homeName': _findContext.text}));
                  if (res == true) {
                    Navigator.pushNamed(context, RouteName.homeList);
                  } else {
                    showToast("该辩题不存在");
                  }
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
          Column(
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
                            context,
                            RouteName.homeList,
                          );
                        },
                      ),
                      Text('自由比赛', style: TextStyle(color: Colors.grey))
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.archway,
                        size: 40,
                      ),
                      Text('专业比赛', style: TextStyle(color: Colors.grey))
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
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.robot,
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RouteName.debateRobot,
                          );
                        },
                      ),
                      Text('人机模拟', style: TextStyle(color: Colors.grey))
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.school,
                        size: 40,
                      ),
                      Text('高校赛', style: TextStyle(color: Colors.grey))
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
              children: widgets,
            ),
          )
        ],
      ),
    );
  }
}
