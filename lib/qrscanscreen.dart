import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QRScanScreen extends StatefulWidget {
  @override
  State createState() => new QRScanScreenState();
}

class QRScanScreenState extends State<QRScanScreen> {
  String barcode = "";

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text(this.barcode),
    );
  }
}
