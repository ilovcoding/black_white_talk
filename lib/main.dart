import 'package:black_white_talk/models/HomeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'components/provider/BaseView.dart';
import 'components/provider/provider_manage.dart';
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
    BuildContext _pagecontext = context;
    return MultiProvider(
        providers: providers,
        child: ProviderWidget<HomeModel>(
          model: HomeModel(),
          // onModelReady: (model) => model.checkLogin(),
          builder: (context, model1, child) {
            //5秒没到或者用户正在登陆中 展示进入系统的动画
            // return model1.loginAnimation || model1.state == ViewState.Loading
            //     ? Container(child: start_bg)
          // : OKToast(
          // child:  MaterialApp(
          //     title: '工大学子',
          //     theme: ThemeData(
          //       primarySwatch: Colors.blue,
          //       fontFamily: "MaShanZheng",
          //     ),)
            // initialRoute:
            //     model1.loginSuccess ? RouteName.home : RouteName.login,
            // @test
            return OKToast(
                child: MaterialApp(
              title: '工大学子',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: "MaShanZheng",
              ),
              initialRoute: RouteName.login,
              onGenerateRoute: Router.generateRoute,
            ));
          },
        ));
  }
}
