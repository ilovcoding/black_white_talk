import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:black_white_talk/api/Debate.dart';
import 'package:black_white_talk/utils/Event.dart';
import 'package:black_white_talk/utils/request/Request.dart';
import 'package:black_white_talk/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';

class Debate extends StatefulWidget {
  final String homeid;
  final Identity userType;
  Debate({Key key, this.homeid, this.userType}) : super(key: key);
  @override
  _DebateState createState() => _DebateState();
}

class _DebateState extends State<Debate> {
  String homeName = "";
  List<dynamic> positive = [];
  List<dynamic> negative = [];
  int speaking = 1;
  bool muted = true;

  @override
  void dispose() {
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    //  用户加入聊天
    AgoraRtcEngine.joinChannel(
      null,
      widget.homeid,
      null,
      widget.userType.index + 1,
    );
    // AgoraRtcEngine.enableAudio();
    // 获取辩题
    getHomeName();
    //  获取成员信息
    getRoleInfo();
    // 获取当前正在辩论的人
    getSpeak();
    // socket 获取当前正在辩论的人
    socketSpeak();
    super.initState();
  }

  void socketSpeak() async {
    String _event = "speak${widget.homeid}";
    socket.on(_event, (data) {
      if (data == false) {
        showToast("改变状态失败请重新尝试");
        return;
      }

      // if (int.parse(data) == widget.userType.index + 1) {
      //   print(data);
      //   print(widget.userType.index + 1);
      //   AgoraRtcEngine.muteRemoteAudioStream(int.parse(data), false);

      //   AgoraRtcEngine.muteLocalAudioStream(false);
      //   print("hhh");
      // } else {
      //   AgoraRtcEngine.muteRemoteAudioStream(int.parse(data), false);
      // }
      if (mounted) {
        int _speacking = int.parse(data);
        setState(() {
          speaking = _speacking;
          muted = (widget.userType.index != (_speacking - 1));
        });
      }
    });
  }

  Future<void> getSpeak() async {
    String res = await DebateApi.api.getSpeak(
      FormData.fromMap({'homeid': widget.homeid}),
    );
    int _speacking = int.parse(res);
    setState(() {
      speaking = _speacking;
      muted = (widget.userType.index != (_speacking - 1));
    });
  }

  void getHomeName() async {
    String _title = await Request.postFormData(
      '/homeName',
      FormData.fromMap({
        "homeid": widget.homeid,
      }),
    );
    setState(() {
      homeName = _title;
    });
  }

  void getRoleInfo() async {
    var res = await DebateApi.api
        .getRolesInfo(FormData.fromMap({'homeid': widget.homeid}));
    setState(() {
      positive = res['positive'];
      negative = res['negative'];
    });
    // print(res);
  }

  Container titleContainer() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: RaisedButton(
        color: Colors.grey,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          // width: 100,
          height: 40,
          child: Center(
            child: Text(
              homeName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        onPressed: null,
      ),
    );
  }

  void _openAudio(index) async {
    await DebateApi.api.audioControl(
      FormData.fromMap(
        {'homeid': widget.homeid, 'audio': index, 'state': 'open'},
      ),
    );
    socket.emit("speak", widget.homeid);
  }

  void _closeAudio(index) async {
    // if (index == speaking) {
    //   AgoraRtcEngine.muteLocalAudioStream(true);
    // } else {
    //   AgoraRtcEngine.muteRemoteAudioStream(index, true);
    // }
    var res = await DebateApi.api.audioControl(
      FormData.fromMap(
        {'homeid': widget.homeid, 'audio': index, 'state': 'close'},
      ),
    );
    socket.emit("speak", widget.homeid);
  }

  Function _onToggleMute(int index) {
    // print(index);
    return () async {
      if (index == widget.userType.index + 1) {}
      if (speaking != index) {
        // 当前静音要打开语音
        await getSpeak();
        if (speaking == 0) {
          //  0表示当前无人说话 任何人都可以说话
          _openAudio(index);
        } else {
          // 目前有人说话
          if (widget.userType != Identity.ChairMan) {
            // 不是主席直接报错
            showToast("${UserTypes[speaking - 1]}正在说话中");
          } else {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("${UserTypes[speaking - 1]}正在说话"),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text("是否强行切换至我方?"),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("取消"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text('确认'),
                      onPressed: () {
                        _openAudio(index);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      } else {
        // 当前不是静音 要结束说话
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('提示'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('是否结束当前语言'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('取消'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('确认'),
                  onPressed: () {
                    _closeAudio(index);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    };
  }

  Widget myPanel() {
    return Column(
      children: <Widget>[
        RawMaterialButton(
          onPressed: _onToggleMute(widget.userType.index + 1),
          child: Icon(
            muted ? Icons.mic_off : Icons.mic,
            color: muted ? Colors.white : Colors.blueAccent,
            size: 20.0,
          ),
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: muted ? Colors.blueAccent : Colors.white,
          padding: const EdgeInsets.all(12.0),
        ),
        muted ? Text("静音中") : Text("说话中")
      ],
    );
  }

  Widget usersPanel() {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("正方辩手"),
            Row(
              children: positive.map<Column>((data) {
                int _index = data['index'] - 1;
                // print(_index);
                bool _muted = (speaking != data['index']);
                // print(speaking);
                // print(_muted);
                return Column(
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: _onToggleMute(data['index']),
                      child: Icon(
                        _muted ? Icons.mic_off : Icons.mic,
                        color: _muted ? Colors.white : Colors.blueAccent,
                        size: 20.0,
                      ),
                      shape: CircleBorder(),
                      elevation: 2.0,
                      fillColor: _muted ? Colors.blueAccent : Colors.white,
                      padding: const EdgeInsets.all(12.0),
                    ),
                    Text("${UserTypes[_index]}")
                  ],
                );
              }).toList(),
            ),
            Text("反方辩手"),
            Row(
              children: negative.map<Column>((data) {
                int _index = data['index'] - 1;
                bool _muted = (speaking != data['index']);
                // print(speaking);
                // print(_muted);
                return Column(
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: _onToggleMute(data['index']),
                      child: Icon(
                        _muted ? Icons.mic_off : Icons.mic,
                        color: _muted ? Colors.white : Colors.blueAccent,
                        size: 20.0,
                      ),
                      shape: CircleBorder(),
                      elevation: 2.0,
                      fillColor: _muted ? Colors.blueAccent : Colors.white,
                      padding: const EdgeInsets.all(12.0),
                    ),
                    Text("${UserTypes[_index]}")
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: Icon(Icons.backspace),
        title: Center(child: titleContainer()),
        actions: <Widget>[
          widget.userType == Identity.ChairMan
              ? IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("结束本次辩论"),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text("是否结束本次辩论?"),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("取消"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('结束'),
                              onPressed: () {
                                DebateApi.api.controlDebate(
                                  FormData.fromMap(
                                    {'state': false, 'homeid': widget.homeid},
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              : SizedBox()
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: positive.map<Column>((var data) {
                      return Column(
                        children: <Widget>[
                          Text(
                              "${UserTypes[data['index'] - 1]}:${data['name']}"),
                          Container(
                            height: 50,
                            width: 50,
                            child: Image.network("${data['avatar']}"),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.microphoneAlt,
                              size: 50,
                              color: Colors.lightBlue,
                            ),
                            onPressed: null,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        speaking == 0
                            ? Text("空闲中")
                            : Text(
                                "${UserTypes[speaking - 1]}:说话中",
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: negative.map<Column>((var data) {
                      return Column(
                        children: <Widget>[
                          Text(
                              "${UserTypes[data['index'] - 1]}:${data['name']}"),
                          Container(
                            height: 50,
                            width: 50,
                            child: Image.network("${data['avatar']}"),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          myPanel(),
          widget.userType == Identity.ChairMan ? usersPanel() : SizedBox(),
        ],
      ),
      // msgInfo(),
      // submitText()
    );
  }
}
