import 'encryption.dart';
import 'onetimepads.dart';
import 'random.dart';

const int REQUIRED_LENGTH = 184;

class Encoder {
  
  Encryption encryption;

  Encoder() {
    this.encryption = new Encryption();
  }
  
  String encodeMessage(int index, String msg, String otp) {
    if(msg.length < REQUIRED_LENGTH){
      for(int i = msg.length; i < REQUIRED_LENGTH; i++){
        msg += " ";
      }
    }
    return index.toString().padLeft(2, "0")
        + this.encryption.xor(msg + new DateTime.now().microsecondsSinceEpoch.toString(), otp);
  }

  String decodeMessage(String msg, String otp) {
    return this.encryption.xor(msg.substring(2, msg.length), otp).substring(0, msg.length - 16);
  }

  DateTime getTime(String msg, String otp) {
    String newmsg = msg.substring(2, msg.length);
    int timecount = int.parse(this.encryption.xor(newmsg, otp).substring
      (newmsg.length - 16, newmsg.length));
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
  String encoded = e.encodeMessage(01, 'hello kyle!', otp);
  print('ENCODED: ' + encoded);
  DateTime time = e.getTime(encoded, otp);
  print('TIME: ' + time.toString());
  String decoded = e.decodeMessage(encoded, otp);
  print('DECODED: ' + decoded);
}