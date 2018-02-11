import 'package:flutter/widgets.dart';
import 'dart:math';
import 'serialize.dart';
import 'otp.dart';

const int _separator = 100;

const int _msgLength = 184;
const int _otpLength = 200;

class User implements ISerializable<User> {
  final String uid;
  final String sendingSeed;
  final int theirSeedIndex;

  User(this.uid, this.sendingSeed, this.theirSeedIndex);

//  factory User.fromImg(Image i) {
//    String qrContents = "";
//    return new fromMap(JSON.decode(qrContents));
//  }

  Image render() {}

  getNthOTP(int n) {
    return generateListOTP(sendingSeed).elementAt(n);
  }

  List<OneTimePad> generateListOTP(String seed) {
    List<OneTimePad> otplist = new List(100);
    List<int> seedValues = seed.codeUnits;
    String seednum = seedValues.join();
    var rand = new Random(int.parse(seednum));
    for (int i = 0; i < 100; i++) {
      var codeUnits = new List.generate(_otpLength, (index) {
        return rand.nextInt(100);
      });
      otplist[i] = new OneTimePad(new String.fromCharCodes(codeUnits));
    }
    return otplist;
  }

  @override
  Map<String, dynamic> toMap() => {
        "uid": this.uid,
        "sendingSeed": this.sendingSeed,
        "theirSeedIndex": this.theirSeedIndex,
      };

  @override
  User fromMap(Map<String, dynamic> m) => new User(
        m["uid"],
        m["sendingSeed"],
        m["theirSeedIndex"],
      );
}

main() {
  String secret = "osjefoiesfmsoiefnsfej";
  String msg = "hello there";

  OneTimePad otp = new OneTimePad(secret);

  String enc = otp.encodeMessage(msg);
  String dec = otp.decodeMessage(enc);

  print(enc);
  print(dec);
}
