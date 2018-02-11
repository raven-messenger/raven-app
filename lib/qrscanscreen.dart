import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class QRScanScreen extends StatefulWidget {
  @override
  State createState() => new QRScanScreenState();
}

class QRScanScreenState extends State<QRScanScreen> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text("SCAN QR"),
    );
  }
}
