import 'package:black_white_talk/view_model/HomeModel.dart';
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
        builder: (context, model1, child) {
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
        },
      ),
    );
  }
}
