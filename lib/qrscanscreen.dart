import 'dart:async';

//import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QRScanScreen extends StatefulWidget {
  @override
  State createState() => new QRScanScreenState();
}

class QRScanScreenState extends State<QRScanScreen> {
  String barcode = "";

  @override
  Widget build(BuildContext context) {
//    scan();
    return new Container(
      child: new Text(this.barcode),
    );
  }

//  Future scan() async {
//    try {
//      String barcode = await BarcodeScanner.scan();
//      setState(() => this.barcode = barcode);
//    } on PlatformException catch (e) {
//      if (e.code == BarcodeScanner.CameraAccessDenied) {
//        setState(() {
//          this.barcode = 'The user did not grant the camera permission!';
//        });
//      } else {
//        setState(() => this.barcode = 'Unknown error: $e');
//      }
//    } on FormatException {
//      setState(() => this.barcode =
//          'null (User returned using the "back"-button before scanning anything. Result)');
//    } catch (e) {
//      setState(() => this.barcode = 'Unknown error: $e');
//    }
//  }
}
