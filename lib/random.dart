import 'dart:math';
import 'encryption.dart';

class RandomSeed {
  String generateSeed() {
    var rand = new Random();
    var codeUnits = new List.generate(200, (index) {
      return rand.nextInt(100);
    });
    return new String.fromCharCodes(codeUnits);
  }
}

main() {
  RandomSeed r = new RandomSeed();
  Encryption e = new Encryption();
  String seed = r.generateSeed();
  print('SEED: ' + seed);
  String encrypted = e.xor("Hello Trevor", seed);
  print('ENCRYPTED: ' + encrypted);
  String decrypted = e.xor(encrypted, seed);
  print('DECRYPTED: ' + decrypted);
}