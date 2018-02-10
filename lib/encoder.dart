import 'encryption.dart';

class Encoder {
  Encryption encryption;

  Encoder(){
    this.encryption = new Encryption();
  }
  String encodeMessage(int index, String msg, String otp) {
    return index.toString().padLeft(2, "0") + this.encryption.xor(msg, otp) +
        new DateTime.now().microsecondsSinceEpoch.toString();
  }

  String decodeMessage(String msg, String otp) {
    return this.encryption.xor(msg, otp).substring(0, msg.length - 16);
  }

  String getTime(String msg, String otp) {
  }



}