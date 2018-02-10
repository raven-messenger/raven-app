import 'dart:math';
import 'random.dart';

const int OTP_LENGTH = 200;

class OTP {

  //generates a single OTP
  String generateOTP(String seed) {
    List<int> seedValues = seed.codeUnits;
    String seednum = seedValues.join();
    var rand = new Random(int.parse(seednum));
    var codeUnits = new List.generate(OTP_LENGTH, (index) {
      return rand.nextInt(100);
    });
    return new String.fromCharCodes(codeUnits);
  }

  //generates a list of 100 OTPs
  List<String> generateListOTP(String seed) {
    List<String> otplist = new List(100);
    List<int> seedValues = seed.codeUnits;
    String seednum = seedValues.join();
    var rand = new Random(int.parse(seednum));
    for (int i = 0; i < 100; i++) {
      var codeUnits = new List.generate(OTP_LENGTH, (index) {
        return rand.nextInt(100);
      });
      otplist[i] = new String.fromCharCodes(codeUnits);
    }
    return otplist;
  }
}

main() {
  RandomSeed r = new RandomSeed();
  OTP o = new OTP();
  String seed = r.generateSeed();

  List<String> testotplist = new List(100);
  testotplist = o.generateListOTP(seed);
  print(testotplist);

}