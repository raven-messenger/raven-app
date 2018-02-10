import 'dart:math';

const int SEED_LENGTH = 200;

class RandomSeed {
  String generateSeed() {
    var rand = new Random();
    var codeUnits = new List.generate(SEED_LENGTH, (index) {
      return rand.nextInt(100);
    });
    return new String.fromCharCodes(codeUnits);
  }
}

main() {
  RandomSeed r = new RandomSeed();
  String seed = r.generateSeed();
  print('SEED: ' + seed);
}