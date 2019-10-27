import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Collection extends StatefulWidget {
  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  TextEditingController _collectionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        textTheme: TextTheme(title: TextStyle(color: Colors.black)),
        title: Text('辩题征集'),
        actions: <Widget>[
          FlatButton(
            child: Text('提交'),
            onPressed: () {
              showDialog(
                //通过showDialog方法展示alert弹框
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('提交辩题'), //弹框标题
                    content: Text(_collectionController.text), //弹框内容
                    actions: <Widget>[
                      //操作控件
                      CupertinoDialogAction(
                        onPressed: () {
                          //控件点击监听
                          Navigator.pop(context);
                        },
                        textStyle: TextStyle(
                            fontSize: 18, color: Colors.grey), //按钮上的文本风格
                        child: Text('取消'), //控件显示内容
                      ),
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        textStyle: TextStyle(fontSize: 18, color: Colors.blueAccent),
                        child: Text('提交'),
                      ),
                    ],
                  );
                },
              );

              // return CupertinoDialog(

              //   child: Text(_collectionController.text),
              // );
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Stack(
            children: <Widget>[
              // Text(
              //   '输入你感兴趣的辩题...',
              //   style: TextStyle(color: Colors.grey, fontSize: 14),
              // ),

              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: '输入你感兴趣的辩题...',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                controller: _collectionController,
              ),
            ],
          )),
    );
  }
}
