import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:black_white_talk/pages/DebateLobby/home/debate/Debate.dart';
import 'package:black_white_talk/utils/agora.dart';
import 'package:black_white_talk/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class Wait extends StatefulWidget {
  final String homeid;
  final Identity userType;
  Wait({Key key, this.homeid, this.userType}) : super(key: key);
  @override
  _WaitState createState() => _WaitState();
}

class _WaitState extends State<Wait> {
  List<dynamic> _userList = [];
  // Timer _timer;
  bool _canJoin = false;
  @override
  void initState() {
    // socket.open();
    // 通过socket获取成员信息
    handlesocket();
    //初始化声网相关操作
    initializeAgora();
    super.initState();
  }

  // @override
  // void dispose() {
  //   // AgoraRtcEngine.leaveChannel();
  //   // AgoraRtcEngine.destroy();
  //   super.dispose();
  // }

  Future<void> initializeAgora() async {
    if (APP_ID.isEmpty) {
      showToast('获取音频token失败');
      return;
    }

    await _initAgoraRtcEngine();

    _addAgoraEventHandlers();

    await AgoraRtcEngine.enableWebSdkInteroperability(true);

    await AgoraRtcEngine.joinChannel(
      null,
      widget.homeid,
      null,
      widget.userType.index + 1,
    );

    // if (widget.userType != Identity.ChairMan) {
    // 静音本地，初始化不静音
    await AgoraRtcEngine.muteLocalAudioStream(false);
    // }
  }

  Future<void> _initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(APP_ID);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code) {};

    AgoraRtcEngine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ) {};

    AgoraRtcEngine.onLeaveChannel = () {};

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      showToast("${UserTypes[uid - 1]}加入");
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      showToast("${UserTypes[uid - 1]}退出");
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
      int uid,
      int width,
      int height,
      int elapsed,
    ) {};
  }

  void handlesocket() {
    socket.emit('getuser', widget.homeid);
    String ongetuser = "getuser${widget.homeid}";
    String canJoin = "canjoin${widget.homeid}";
    int oldUserListLength = _userList.length;
    socket.on(ongetuser, (var data) {
      print(data);
      if (oldUserListLength != data.length) {
        if (mounted) {
          setState(() {
            _userList = data;
          });
          oldUserListLength = _userList.length;
        }
      }
    });
    socket.on(canJoin, (var data) {
      if (mounted) {
        setState(() {
          _canJoin = true;
        });
      }
    });
  }

  // void gotoDebate() {}
  @override
  Widget build(BuildContext context) {
    if (_canJoin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Debate(homeid: widget.homeid),
        ),
      );
    }
    List<Widget> chairman = [];
    List<Widget> positive = []; //正方人数
    List<Widget> negative = []; // 反方人数
    _userList.forEach((var data) {
      String name =
          UserTypes[int.parse(data['index']) - 1] + " : " + data['name'];
      if (int.parse(data['index']) == 1) {
        chairman = [
          Container(
            width: 40,
            height: 40,
            child: Image.network(data['avatar']),
          ),
          Text(name)
        ];
      }
      if (int.parse(data['index']) >= 2 && int.parse(data['index']) <= 5) {
        positive.add(
          Column(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                child: Image.network(data['avatar']),
              ),
              Text(name)
            ],
          ),
        );
      } else if (int.parse(data['index']) >= 6) {
        negative.add(
          Column(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                child: Image.network(data['avatar']),
              ),
              Text(name)
            ],
          ),
        );
      }
    });
    OutlineButton startButton() {
      if (positive.isNotEmpty && negative.isNotEmpty) {
        return OutlineButton(
          color: Colors.grey,
          textColor: Colors.black,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Text(
              "开始",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          onPressed: () {
            //主席静音掉所有其他的远程连接
            AgoraRtcEngine.muteAllRemoteAudioStreams(true);
            socket.emit("canjoin", widget.homeid);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Debate(
                  homeid: widget.homeid,
                ),
              ),
            );
          },
        );
      } else {
        return OutlineButton(
          color: Colors.grey,
          textColor: Colors.black,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Text(
              "等待成员加入中.....",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          // 开发环境 onPressed 回调函数应该变成 null
          onPressed: () {
            //主席静音掉所有其他的远程连接
            AgoraRtcEngine.muteAllRemoteAudioStreams(true);
            socket.emit("canjoin", widget.homeid);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Debate(
                  homeid: widget.homeid,
                ),
              ),
            );
          },
        );
      }
    }

    // OutlineButton joinButton() {
    //   if (positive.isNotEmpty && negative.isNotEmpty) {
    //     return OutlineButton(
    //       color: Colors.grey,
    //       textColor: Colors.black,
    //       child: Container(
    //         padding: EdgeInsets.all(15),
    //         child: Text(
    //           "开始",
    //           style: TextStyle(
    //             color: Colors.black,
    //             fontWeight: FontWeight.bold,
    //             fontSize: 20,
    //           ),
    //         ),
    //       ),
    //       onPressed: () {
    //         //主席静音掉所有其他的远程连接
    //         AgoraRtcEngine.muteAllRemoteAudioStreams(true);
    //       },
    //     );
    //   } else {
    //     return OutlineButton(
    //       color: Colors.grey,
    //       textColor: Colors.black,
    //       child: Container(
    //         padding: EdgeInsets.all(15),
    //         child: Text(
    //           "等待成员加入中.....",
    //           style: TextStyle(
    //             color: Colors.black,
    //             fontWeight: FontWeight.bold,
    //             fontSize: 20,
    //           ),
    //         ),
    //       ),
    //       onPressed: null,
    //     );
    //   }
    // }

    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: <Widget>[
          Card(
            child: Column(
              children: chairman,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          SizedBox(height: 20),
          //正方信息
          Card(
            child: Wrap(
              children: positive,
              spacing: 10,
            ),
          ),
          SizedBox(height: 20),
          // 反方信息
          Card(
            child: Wrap(
              children: negative,
              spacing: 10,
            ),
          ),
          SizedBox(height: 20),
          widget.userType == Identity.ChairMan ? startButton() : SizedBox(),
          // widget.userType != Identity.ChairMan ? joinButton() : SizedBox()
        ],
      ),
    );
  }
}
