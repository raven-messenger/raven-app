import 'encryption.dart';
import 'onetimepads.dart';
import 'random.dart';

class Encoder {
  Encryption encryption;

  Encoder() {
    this.encryption = new Encryption();
  }
  
  String encodeMessage(int index, String msg, String otp) {
    String enc = this.encryption.xor(msg + new DateTime.now().microsecondsSinceEpoch.toString(), otp);
    return index.toString().padLeft(2, "0") + enc;
  }

  String decodeMessage(String msg, String otp) {
    return this.encryption.xor(msg.substring(2, msg.length), otp).substring(0, msg.length - 16);
  }

  DateTime getTime(String msg, String otp) {
    String newmsg = msg.substring(2, msg.length);

    int timecount = int.parse(this.encryption.xor(newmsg, otp).substring(newmsg.length - 16, newmsg.length));
    DateTime time = new DateTime.fromMicrosecondsSinceEpoch(timecount);
    return time;
  }
}

main() {
  Encoder e = new Encoder();
  OTP o = new OTP();
  RandomSeed r = new RandomSeed();
  String seed = r.generateSeed();
  String otp = o.generateOTP(seed);

  String encoded = e.encodeMessage(1, 'hello bryce', otp);
  print('ENCODED: ' + encoded);
  print('len: ' + encoded.length.toString());
  print('len: ' + encoded.toString().substring(2, encoded.length).length.toString());
  DateTime time = e.getTime(encoded, otp);
  print('TIME: ' + time.toString());
  String decoded = e.decodeMessage(encoded, otp);
  print('DECODED: ' + decoded);

}