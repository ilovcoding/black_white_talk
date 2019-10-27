import 'package:black_white_talk/static/Assets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Container(
              width: 60,
              // height: 25,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),

              child: Text(
                '创建',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onPressed: () {
              showToast('创建成功');
            },
          ),
        ],
        title: Center(
          child: Text(
            '创建队伍',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 40,),
          Stack(
            children: <Widget>[
              Center(
                  child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  image: user_avatar2,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              )),
              // Container(
              //   height: 1000,
              //   width: MediaQuery.of(context).size.width,
              //   color: Colors.black,
              //   child: Column(
              //     children: <Widget>[
              //       // Text("222")
              //     ],
              //   ),
              // )
            ],
          ),
          // SizedBox(
          //   height: 40,
          // ),
        ],
      ),
    );
  }
}
