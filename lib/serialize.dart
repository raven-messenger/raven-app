import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'key.dart';

class Serialize{

  // Decodes a Serialized string to a Key Object
  Key decodeJSON(String serialized) {
    Map keyMap = JSON.decode(serialized);
    return new Key.fromJson(keyMap);
  }

  // Encodes a Key object to a Serialized JSON String
  String encodeJSON(Key key) {
    Map<String, dynamic> keyMap = key.toJson();
    return JSON.encode(keyMap);
  }


  // Saves a Serialized string to SharedPreferences
  setToSharedPreferences(String user, String serialized) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(user, serialized);
  }

  // Gets a Key Object from SharedPreferences with a given ConvoID
  getFromSharedPreferences(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return this.decodeJSON(prefs.getString(user));
  }

}




