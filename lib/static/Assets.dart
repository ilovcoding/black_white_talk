import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

String loadingText = '点击开启你的\n辩手生涯';
DecorationImage loadingImage169 = DecorationImage(
  image: AssetImage('assets/images/loading169.png'),
  fit: BoxFit.fill,
);
DecorationImage loadingImage170 = DecorationImage(
  image: AssetImage('assets/images/loading170.png'),
  fit: BoxFit.fill,
);
DecorationImage lessonbg = DecorationImage(
  image: AssetImage('assets/images/lessonbg.jpg'),
  fit: BoxFit.fill,
);
DecorationImage login_bg = DecorationImage(
  image: AssetImage("assets/images/login-bg.jpg"),
  fit: BoxFit.cover,
);
SvgPicture handPointUp = new SvgPicture.asset(
  "assets/images/loadingPoint.svg",
  color: Colors.grey,
);
DecorationImage user_avatar = DecorationImage(
  image: AssetImage("assets/images/user_avatar.png"),
  fit: BoxFit.cover,
);
DecorationImage user_avatar2 = DecorationImage(
  image: AssetImage("assets/images/user_avatar2.png"),
  fit: BoxFit.cover,
);

List<String> images = <String>[
  "assets/images/drawer.png",
  "assets/images/user_avatar.png",
  "assets/images/user_avatar2.png",
  "assets/images/loading170.png"
];
