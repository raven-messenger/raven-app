import 'dart:convert';

import 'package:bot/bot.dart';

import 'bit_buffer.dart';
import 'mode.dart' as qr_mode;

class QrByte {
  final int mode = qr_mode.mode8bitByte;
  final List<int> _data;

  factory QrByte(String input) {
    requireArgumentNotNull(input, 'input');

    var charUnits = UTF8.encode(input);

    return new QrByte._internal(charUnits);
  }

  QrByte._internal(this._data);

  int get length => _data.length;

  void write(QrBitBuffer buffer) {
    for (final int v in _data) {
      buffer.put(v, 8);
    }
  }
}