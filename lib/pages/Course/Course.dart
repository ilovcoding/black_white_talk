import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'Item.dart';

class Course extends StatefulWidget {
  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List list = [];
  _readjson() async {
    const url = "http://101.200.137.244:8001/query";
    var responseBody;
    var client = HttpClient();
    var request = await client.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
    } else {
      return "Failed";
    }
    setState(() {
      responseBody.forEach((item) {
        list.add(json.decode(item));
      });
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: list.map((item) {
        return Item(item["title"], item["photourl"], item["number"],
            item["intro"], item["courseurl"]);
      }).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    _readjson();
  }
}
