import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class QRGenScreen extends StatefulWidget {
  @override
  State createState() => new QRGenScreenState();
}

class QRGenScreenState extends State<QRGenScreen> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text("GENERATE QR"),
    );
  }
}