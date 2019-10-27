import 'package:black_white_talk/static/Assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DebateLife extends StatefulWidget {
  @override
  _DebateLifeState createState() => _DebateLifeState();
}

class _DebateLifeState extends State<DebateLife> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Stack(
                children: <Widget>[
                  Icon(FontAwesomeIcons.angleLeft),
                  Center(
                    child: Image(
                      image: AssetImage('assets/images/avatar.png'),
                      width: 60,
                      height: 60,
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Text(
                '昵称',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      '15',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '辩论历史',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '7',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '佳辩次数',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '29',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '论点发表',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: <Widget>[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            image: user_avatar,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          width: 50,
                          height: 50,
                        ),
                        title: Text('某人'),
                        subtitle: Text('7小时前'),
                      ),
                      Text(
                          '对面好像在偷换概念，我好想没有听出来!,对面好像在偷换概念，我好想没有听出来!,对面好像在偷换概念，我好想没有听出来!'),
                      Container(
                        margin: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        height: 150,
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
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            image: user_avatar2,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          width: 50,
                          height: 50,
                        ),
                        title: Text('某人'),
                        subtitle: Text('7小时前'),
                      ),
                      Text('辩论太难了'),
                      Container(
                        margin: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        height: 150,
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
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ],
    ));
  }
}
