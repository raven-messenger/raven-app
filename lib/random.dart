import 'dart:math';
import 'random.dart'

const int SEED_LENGTH = 200;

class RandomSeed {
  String generateSeed() {
    var rand = new Random();
    var codeUnits = new List.generate(SEED_LENGTH, (index) {
      return rand.nextInt(10000);
    });
    return new String.fromCharCodes(codeUnits);
  }
}

main() {
  RandomSeed r = new RandomSeed();
  String seed = r.generateSeed();
  print('SEED: ' + seed);
}