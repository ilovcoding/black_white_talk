import './utils/requests.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:convert';

class ResultPage extends StatefulWidget {
  final String searchText;
  ResultPage(this.searchText);
  @override
  State<StatefulWidget> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  EasyRefreshController _controller;
  int _page = 1;
  int _total;
  List _resultList = [];
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  Future _getData() async {
    var url =
        'http://101.200.137.244:8001/search?keyword=${widget.searchText}&pageindex=$_page';
    String result;
    Response response;
    response = await Request.get(url);
    result = (response.data as String);
    return json.decode(result);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          title: Text("搜索结果", style: TextStyle(color: Colors.white)),
        ),
        body: FutureBuilder(
            future: _getData().then((result) {
              _resultList.addAll(result[0] as List);
              _total ??= result[1] as int;
              ++_page;
            }),
            builder: (context, snapshot) {
              if (_page > 1) {
                return EasyRefresh(
                    enableControlFinishLoad: true,
                    controller: _controller,
                    onLoad: () async {
                      var result = await _getData();
                      setState(() {
                        _resultList.addAll(result[0] as List);
                        _total ??= result[1] as int;
                        ++_page;
                      });
                      _controller.finishLoad(noMore: _page > _total);
                    },
                    child: ListView(children: () {
                      if (_total == 0) {
                        return [Text('未找到相关结果。')];
                      } else {
                        return _resultList
                            .map((item) => ResultItem(
                                item["title"],
                                item["imgurl"],
                                item["views"],
                                item["content"],
                                item["url"],
                                item["posttime"]))
                            .toList();
                      }
                    }()));
              } else
                return Center(child: CircularProgressIndicator());
            }));
  }
}

class ResultItem extends StatefulWidget {
  final String title, photourl, intro, url, modifiedtime;
  final int views;
  ResultItem(this.title, this.photourl, this.views, this.intro, this.url,
      this.modifiedtime);
  @override
  createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
        child: Container(
          height: 150.0,
          padding: EdgeInsets.only(
            left: 5.0,
            right: 10.0,
          ),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.0, color: const Color(0xff999999))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // 课程图片
              Expanded(
                flex: 1,
                child: Image.network(
                  widget.photourl,
                  scale: 1.0,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                          Container(
                            child: Text(
                              "   " + widget.intro,
                              style: TextStyle(
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  decoration: TextDecoration.none),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 底部人数
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.visibility, size: 16),
                                  Padding(
                                    padding: EdgeInsets.all(3),
                                  ),
                                  Text(
                                    widget.views.toString(),
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        decoration: TextDecoration.none),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.update, size: 16),
                                  Padding(
                                    padding: EdgeInsets.all(2),
                                  ),
                                  Text(
                                    widget.modifiedtime,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        decoration: TextDecoration.none),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
                      title: Text(widget.title,
                          style: TextStyle(color: Colors.white)),
                    ),
                    body: WebviewScaffold(
                      url: "${widget.url}?page=all",
                      ignoreSSLErrors: true,
                    ))));
      },
    );
  }
}
