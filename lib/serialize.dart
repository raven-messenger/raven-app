import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'key.dart';

class Serialize{

  Key decodeJSON(String serialized) {
    Map keyMap = JSON.decode(serialized);
    return new Key.fromJson(keyMap);
  }

  String encodeJSON(Key key) {
    Map<String, dynamic> keyMap = key.toJson();
    return JSON.encode(keyMap);
  }

  setToSharedPreferences(int convoId, String serialized) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(convoId.toString(), serialized);
  }

  getFromSharedPreferences(int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return this.decodeJSON(prefs.getString(i.toString()));
  }
}



