import 'dart:math';
import 'dart:convert';
import 'serialize.dart';

class OneTimePad implements ISerializable<OneTimePad> {
  String secret;

  OneTimePad(this.secret);

  String encodeMessage(String message) {
    if (message.length > secret.length)
      throw new ArgumentError(
          "Message length cannot be longer than secret length.");

    return _xor(message.padRight(this.secret.length, "\t"));
  }

  String decodeMessage(String message) {
    if (message.length > secret.length)
      throw new ArgumentError(
          "Message length cannot be longer than secret length.");
    return _xor(message).replaceAll("\t", "");
  }

  String _xor(String message) {
    Random r = new Random();

    List<int> otpValues = secret.codeUnits;
    List<int> msgValues = message.codeUnits;

    List<int> cipherText = new List<int>.generate(otpValues.length, (i) {
      return msgValues.elementAt(i) ^ otpValues[i];
    });

    return UTF8.decode(cipherText);
  }

  @override
  Map<String, dynamic> toMap() => {
        "secret": secret,
      };

  @override
  OneTimePad fromMap(Map<String, dynamic> m) => new OneTimePad(m["secret"]);
}
