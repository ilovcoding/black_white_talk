import 'package:black_white_talk/config/router.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NeedToKonwn extends StatefulWidget {
  @override
  _NeedToKonwnState createState() => _NeedToKonwnState();
}

class _NeedToKonwnState extends State<NeedToKonwn> {
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
                  '辩论须知',
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
            ListTile(
              leading: Icon(FontAwesomeIcons.clock),
              title: Text('辩论主席责任'),
              onTap: () {
                Navigator.pushNamed(context, RouteName.duty);
              },
              trailing: Icon(FontAwesomeIcons.angleRight),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.clock),
              title: Text('辩论规则'),
              onTap: () {
                Navigator.pushNamed(context, RouteName.rules);
              },
              trailing: Icon(FontAwesomeIcons.angleRight),
            ),
          ],
        ),
      ),
    );
  }
}
