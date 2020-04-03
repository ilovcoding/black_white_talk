import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:black_white_talk/api/Debate.dart';
import 'package:black_white_talk/pages/DebateLobby/home/debate/Debate.dart';
import 'package:black_white_talk/utils/agora.dart';
import 'package:black_white_talk/utils/enum.dart';
import 'package:dio/dio.dart';
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
  @override
  void initState() {
    // 通过socket获取成员信息
    handlesocket();
    //初始化声网相关操作
    initializeAgora();
    super.initState();
  }

  @override
  void dispose() {
    // AgoraRtcEngine.muteLocalAudioStream(true);
    // AgoraRtcEngine.destroy();
    AgoraRtcEngine.leaveChannel();
    super.dispose();
  }

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
    await AgoraRtcEngine.muteLocalAudioStream(false);
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
      print(uid);
      showToast("${UserTypes[uid - 1]}加入");
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      // showToast("${UserTypes[uid - 1]}退出");
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
      int uid,
      int width,
      int height,
      int elapsed,
    ) {};
  }

  void handlesocket() {
    int oldUserListLength = _userList.length;
    socket.emit('getuser', widget.homeid);
    String ongetuser = "getuser${widget.homeid}";
    socket.on(ongetuser, (var data) {
      if (oldUserListLength != data.length) {
        if (mounted) {
          oldUserListLength = data.length;
          setState(() {
            _userList = data;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> chairman = [];
    List<Widget> positive = []; //正方人数
    List<Widget> negative = []; // 反方人数
    _userList.forEach((var data) {
      String name = UserTypes[data['index'] - 1] + " : " + data['name'];
      if (data['index'] == 1) {
        chairman = [
          Container(
            width: 40,
            height: 40,
            child: Image.network(data['avatar']),
          ),
          Text(name)
        ];
      }
      if (data['index'] >= 2 && data['index'] <= 5) {
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
      } else if (data['index'] >= 6) {
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
            if (widget.userType == Identity.ChairMan) {
              //  主席拥有禁言远端的权力
              AgoraRtcEngine.muteAllRemoteAudioStreams(true);
              DebateApi.api.controlDebate(FormData.fromMap({
                'state': true,
                'homeid': widget.homeid,
              }));
            }
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Debate(
                  homeid: widget.homeid,
                  userType: widget.userType,
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
          onPressed: null,
        );
      }
    }

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
          startButton(),
        ],
      ),
    );
  }
}
