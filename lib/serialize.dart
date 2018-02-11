import 'dart:convert';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user.dart';

abstract class ISerializable<T> {
  T fromMap(Map<String, dynamic> m);

  Map<String, dynamic> toMap();
}

class ConfigAccessor {
  static Future<Null> saveToSharedPreferences(String key, ISerializable item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, JSON.encode(item.toMap()));
  }

  static Future<Map<String, dynamic>> getFromSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return JSON.decode(prefs.getString(key));
  }
}

class CurrentConfig {
  User user;
  final googleSignIn;
  List<User> recipients;

  CurrentConfig(this.googleSignIn);

  Future<User> getUser() async {
    Map<String, dynamic> userMap = await ConfigAccessor.getFromSharedPreferences("user");
    if (userMap != null) return user.fromMap(userMap);
    return new User.brandNew(googleSignIn.currentUser.displayName);
  }

  Future<List<User>> getRecipients() async {
    Map<String, Map<String, dynamic>> recipMap = await ConfigAccessor.getFromSharedPreferences("recipients");
    if (recipMap != null) {
      List<User> userList = new List<User>();
      recipMap.forEach((String uid, Map<String, dynamic> vals) {
        User u = new User(vals["uid"], vals["seed"], vals["seedIndex"]);
        userList.add(u);
      });
    }
    return new List<User>();

  }

}
