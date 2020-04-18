import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'config/router.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: '黑白说',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "楷书",
        ),
        initialRoute: RouteName.home,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
