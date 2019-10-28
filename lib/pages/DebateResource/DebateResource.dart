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
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '搜你想搜的',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            color: Colors.grey[200],
            onPressed: () {},
            child: Text(
              '搜索',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
