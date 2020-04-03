import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ResultPage.dart';
import './utils/requests.dart';
import 'dart:convert';
import './utils/shared_preferences_storage.dart' show SearchStorageUtils;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class DebateResourcePage extends StatefulWidget {
  @override
  _DebateResourcePageState createState() => _DebateResourcePageState();
}

class _DebateResourcePageState extends State<DebateResourcePage> {
  TextEditingController _find = TextEditingController();

  static _searchPressedHandler(keyword, context) async {
    await SearchStorageUtils.setHistoryData(keyword);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(keyword),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.angleLeft),
          color: Colors.grey,
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _find,
          keyboardType: TextInputType.text,
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '搜你想搜的',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: EdgeInsets.all(10),
              child: Text('搜索', style: TextStyle(color: Colors.white)),
            ),
            onPressed: () => _searchPressedHandler(_find.text, context),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          HistorySearchEntry(),
          Divider(),
          HotwordsEntry(),
          SizedBox(
            height: 20,
          ),
          VideoEntry()
        ],
      ),
    );
  }
}

Container numberCard(int number) {
  return Container(
    child: Text(
      '$number',
      style: TextStyle(color: Colors.white),
    ),
    color: Colors.grey,
    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
    padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
  );
}

class HistorySearchEntry extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HistorySearchEntryState();
}

class _HistorySearchEntryState extends State<HistorySearchEntry> {
  Set<String> _historyListData = {};

  Future<Set> _getHistoryData() async {
    var _historyListData = await SearchStorageUtils.getHistorySet();
    this._historyListData = _historyListData;
    // print(this._historyListData);
    return _historyListData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getHistoryData(),
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return SizedBox(
                child: Center(child: CircularProgressIndicator()),
                height: 211,
              );
            default:
              if (snapshot.hasError) {
                return SizedBox(
                  child: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                  height: 211,
                );
              } else {
                return Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('最近搜索'),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.trash,
                              size: 12,
                            ),
                            onPressed: () async {
                              SearchStorageUtils.removeHistorySet();
                              await this._getHistoryData();
                              setState(() {});
                            },
                          ),
                          Text('清空')
                        ],
                      )
                    ],
                  ),
                  Wrap(
                    spacing: 10,
                    children: _historyListData
                        .map((text) => InkWell(
                              child: Container(
                                child: Text(text),
                                color: Colors.grey[300],
                                padding: EdgeInsets.all(5),
                              ),
                              onTap: () => _DebateResourcePageState
                                  ._searchPressedHandler(text, context),
                            ))
                        .toList(),
                  ),
                ]);
              }
          }
        });
  }
}

class HotwordsEntry extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HotwordsEntryPageState();
}

class _HotwordsEntryPageState extends State<HotwordsEntry> {
  static var _searchPressedHandler =
      _DebateResourcePageState._searchPressedHandler;

  _getHotwords() async {
    Response response =
        await Request.get("http://101.200.137.244:8001/hotwords");
    return json.decode(response.data as String);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getHotwords(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return SizedBox(
                child: Center(child: CircularProgressIndicator()),
                height: 211,
              );
            default:
              if (snapshot.hasError) {
                return SizedBox(
                  child: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                  height: 211,
                );
              } else {
                var _hotwords = snapshot.data;
                return Column(
                  children: <Widget>[
                    Text(
                      '今日热搜',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: '楷书',
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              numberCard(1),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(_hotwords[0]),
                              ),
                            ],
                          ),
                          onTap: () =>
                              _searchPressedHandler(_hotwords[0], context),
                        ),
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              numberCard(6),
                              Text(_hotwords[5])
                            ],
                          ),
                          onTap: () =>
                              _searchPressedHandler(_hotwords[5], context),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              numberCard(2),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(_hotwords[1]),
                              ),
                            ],
                          ),
                          onTap: () =>
                              _searchPressedHandler(_hotwords[1], context),
                        ),
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              numberCard(7),
                              Text(_hotwords[6])
                            ],
                          ),
                          onTap: () =>
                              _searchPressedHandler(_hotwords[6], context),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              numberCard(3),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(_hotwords[2]),
                              ),
                            ],
                          ),
                          onTap: () =>
                              _searchPressedHandler(_hotwords[2], context),
                        ),
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              numberCard(8),
                              Text(_hotwords[7])
                            ],
                          ),
                          onTap: () =>
                              _searchPressedHandler(_hotwords[7], context),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              numberCard(4),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(_hotwords[3]),
                              ),
                            ],
                          ),
                          onTap: () =>
                              _searchPressedHandler(_hotwords[3], context),
                        ),
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              numberCard(9),
                              Text(_hotwords[8])
                            ],
                          ),
                          onTap: () =>
                              _searchPressedHandler(_hotwords[8], context),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              numberCard(5),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(_hotwords[4]),
                              ),
                            ],
                          ),
                          onTap: () =>
                              _searchPressedHandler(_hotwords[4], context),
                        ),
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              numberCard(10),
                              Text(_hotwords[9])
                            ],
                          ),
                          onTap: () =>
                              _searchPressedHandler(_hotwords[9], context),
                        )
                      ],
                    ),
                  ],
                );
              }
          }
        });
  }
}

Widget videoCard(String imgurl, String date, String url, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Scaffold(
                  appBar: AppBar(
                    elevation: 2,
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      icon: Icon(FontAwesomeIcons.angleLeft),
                      color: Colors.grey,
                      onPressed: () => Navigator.pop(context),
                    ),
                    title: Text("视频预览", style: TextStyle(color: Colors.white)),
                  ),
                  body: WebviewScaffold(
                    url: "$url",
                    ignoreSSLErrors: true,
                  ))));
    },
    child: Card(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: 150,
            child: Image(
              image: NetworkImage(imgurl),
              fit: BoxFit.fitWidth,
              height: 100,
              width: 150,
            ),
          ),
          Container(
            height: 30,
            child: Center(
              child: Text(date),
            ),
          )
        ],
      ),
    ),
  );
}

class VideoEntry extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoEntryState();
}

class _VideoEntryState extends State<VideoEntry> {
  List _videos;

  _getVideos() async {
    Response response = await Request.get("http://101.200.137.244:8001/videos");
    return json.decode(response.data as String);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getVideos().then((videos) => _videos = videos),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return SizedBox(
                child: Center(child: CircularProgressIndicator()),
                height: 210,
              );
            default:
              if (snapshot.hasError)
                return Text("发生错误 ${snapshot.error.toString()}");
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: _videos
                        .map((item) => videoCard(
                            item["imgurl"], item["date"], item["url"], context))
                        .toList()),
              );
          }
        });
  }
}
