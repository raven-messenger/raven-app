import 'package:flutter/widgets.dart';
import 'dart:math';
import 'serialize.dart';
import 'otp.dart';
import 'random.dart';

const int _separator = 100;

const int _msgLength = 184;
const int _otpLength = 200;

class User implements ISerializable<User> {

  final String uid;
  String seed;
  int seedIndex;

  User(this.uid, this.seed, this.seedIndex);

  factory User.brandNew(String uid) {
    return new User(uid, RandomSeed.generateSeed(), 0);
  }

//  factory User.fromImg(Image i) {
//    String qrContents = "";
//    return new fromMap(JSON.decode(qrContents));
//  }

  getNthOTP(int n) {
    return generateListOTP(seed).elementAt(n);
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
        "seed": this.seed,
        "seedIndex": this.seedIndex,
      };

  @override
  User fromMap(Map<String, dynamic> m) => new User(
        m["uid"],
        m["seed"],
        m["seedIndex"],
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
