import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedUtils {
  static Future<bool> setString(key, value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString(key, value);
  }

  static Future<String> getString(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  static Future<bool> remove(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }

  static Future<bool> clear(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
}


class SearchStorageUtils {
  static Future<bool> setHistoryData(keyword) async {
    try {
      Set searchSet = Set.from(json.decode(await SharedUtils.getString('searchSet')));
      print("${searchSet.toString()} add $keyword");
      if (searchSet.length == 10) {
        searchSet.remove(searchSet.first);
      }
      searchSet.add(keyword);
      return await SharedUtils.setString('searchSet', json.encode(searchSet.toList()));
    } catch (e) {
      print("Create a new searchSet");
      return await SharedUtils.setString('searchSet', json.encode({keyword}.toList()));
    }
  }

  static Future<Set<String>> getHistorySet() async {
    try {
      return Set.from(json.decode(await SharedUtils.getString('searchSet')));
    } catch (e) {
      return {};
    }
  }

  static Future<bool> removeHistorySet() async {
    return await SharedUtils.remove('searchSet');
  }
}