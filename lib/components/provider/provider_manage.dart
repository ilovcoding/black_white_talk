
import 'package:black_white_talk/view_model/HomeModel.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ChangeNotifierProvider<HomeModel>.value(value: HomeModel(),)  
];

// List<SingleChildCloneableWidget> independentServices = [
//   ChangeNotifierProvider<ThemeModel>.value(value: ThemeModel()),
//   ChangeNotifierProvider<LocaleModel>.value(value: LocaleModel()),
//   ChangeNotifierProvider<GlobalFavouriteStateModel>.value(
//       value: GlobalFavouriteStateModel())
// ];
