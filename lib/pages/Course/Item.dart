import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Item extends StatefulWidget {
  final String title, photourl, intro, courseurl;
  final int number;
  Item(this.title, this.photourl, this.number, this.intro, this.courseurl);
  @override
  createState() => NewsState();
}

class NewsState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            color: Colors.white,
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
                    // 标题
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
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                    ),
                    Container(
                      child: Text(
                        "   " + widget.intro,
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                    ),
                    // 底部人数
                    Container(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.number.toString(),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  decoration: TextDecoration.none),
                            ),
                          ],
                        )),
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
          new MaterialPageRoute(
            builder: (context) => new WebviewScaffold(
              url: widget.courseurl,
              ignoreSSLErrors: true,
            ),
          ),
        );
      },
    );
  }
}
