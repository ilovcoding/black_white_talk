import 'package:flutter/widgets.dart';

import 'ViewState.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  LoginMethod _loginMethod = LoginMethod.UnKnown;
  AppState _appState = AppState.OnlyMlyMember;
  ViewState get state => _state;
  LoginMethod get loginMethod => _loginMethod;
  AppState get appState => _appState;
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void changeLoginMethod(LoginMethod loginMethod) {
    _loginMethod = loginMethod;
    notifyListeners();
  }
}
