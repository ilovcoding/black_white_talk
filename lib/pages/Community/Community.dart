import 'package:black_white_talk/Service/login/LoginService.dart';
import 'package:black_white_talk/utils/agora.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  TextEditingController textController = new TextEditingController();
  ScrollController scrollController =
      new ScrollController(keepScrollOffset: true);
  String name = "";
  List<Card> talkCard = [];
  @override
  void initState() {
    // LoginService
    LoginService.service.userInfo().then((onValue) {
      if (onValue != null) {
        setState(() {
          name = onValue['name'];
        });
      }
    });
    socket.open();
    super.initState();
  }

  @override
  void dispose() {
    talkCard.clear();
    super.dispose();
  }

  Widget _submitText() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Icon(FontAwesomeIcons.keyboard),
          SizedBox(width: 10),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 70,
              ),
              child: TextField(
                controller: textController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
          FlatButton(
            onPressed: () async {
              if (textController.text == "") {
                return null;
              }
              bool first = true;
              socket.emit(
                "community",
                "${name}_;_${textController.text}",
              );
              socket.on("community", (data) {
                List _data = "$data".split("_;_");

                if (mounted && first) {
                  first = false;
                  List<Card> _talkCard = talkCard;
                  _talkCard.add(
                    Card(
                      child: ListTile(
                        title: Text(_data[0]),
                        subtitle: Text(_data[1]),
                        isThreeLine: true,
                      ),
                    ),
                  );
                  setState(() {
                    talkCard = _talkCard;
                  });
                }
              });
              textController.clear();
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Text(
                '发送',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "辩论社区",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: talkCard.length,
              itemBuilder: (context, position) {
                return talkCard[position];
              },
            ),
          ),
          _submitText(),
        ],
      ),
    );
  }
}
