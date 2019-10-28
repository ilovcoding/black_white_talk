import 'package:black_white_talk/components/Loading/Infomation.dart';
import 'package:black_white_talk/static/Assets.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.bottomRight,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(image: loadingImage169),
      child: Listener(
        child: Container(
          width: MediaQuery.of(context).size.width / 3.0,
          child: Row(
            children: <Widget>[
              handPointUp,
              Text(
                loadingText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.grey),
              )
            ],
          ),
        ),
        onPointerDown: (e) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Information(),
            ),
          );
        },
      ),
    ));
  }
}
