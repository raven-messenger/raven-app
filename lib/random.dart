import 'dart:math';

const int SEED_LENGTH = 100;

class RandomSeed {
  static String generateSeed() {
    var rand = new Random(42);
    var codeUnits =
        new List<int>.generate(SEED_LENGTH, (_) => new Random().nextInt(100));
    return new String.fromCharCodes(codeUnits);
  }
}