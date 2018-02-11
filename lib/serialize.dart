import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISerializable<T> {
  T fromMap(Map<String, dynamic> m);

  Map<String, dynamic> toMap();
}

class ConfigAccessor {
  Future<Null> saveToSharedPreferences(String key, ISerializable item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, JSON.encode(item.toMap()));
  }

  Future<Map<String, dynamic>> getFromSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return JSON.decode(prefs.getString(key));
  }
}
