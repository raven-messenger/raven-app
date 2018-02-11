import 'dart:math';

const int SEED_LENGTH = 100;

class RandomSeed {
  static String generateSeed() {
    var rand = new Random();
    var codeUnits =
        new List<int>.generate(SEED_LENGTH, (_) => new Random().nextInt(100));
    return new String.fromCharCodes(codeUnits);
  }
}

main() {
  String seed = RandomSeed.generateSeed();
  print('SEED: ' + seed);
}
