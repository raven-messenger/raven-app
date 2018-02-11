import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrcode_reader/QRCodeReader.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'main.dart';

class QRScanScreen extends StatefulWidget {
  @override
  State createState() => new QRScanScreenState();
}

class QRScanScreenState extends State<QRScanScreen> {
  String futureString = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Barcode Scanner Example'),
          ),
          body: new Center(
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new MaterialButton(
                      onPressed: scan, child: new Text("Scan")),
                  padding: const EdgeInsets.all(8.0),
                ),
                new Center(child: new Text(this.futureString)),
              ],
            ),
          )),
    );
  }

  Future<Null> scan() async {
    String str = await new QRCodeReader()
        .setAutoFocusIntervalInMs(200) // default 5000
        .setForceAutoFocus(true) // default false
        .setTorchEnabled(true) // default false
        .setHandlePermissions(true) // default true
        .setExecuteAfterPermissionGranted(true) // default true
        .scan();
    setState(() {
      this.futureString = str;
    });
  }
}

/*
  Future scan() async {
        try {
          String barcode = await BarcodeScanner.scan();
          setState(() => this.barcode = barcode);
        } on PlatformException catch (e) {
          if (e.code == BarcodeScanner.CameraAccessDenied) {
            setState(() {
              this.barcode = 'The user did not grant the camera permission!';
            });
          } else {
            setState(() => this.barcode = 'Unknown error: $e');
          }
        } on FormatException{
          setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
        } catch (e) {setState(() => this.barcode = 'Unknown error: $e');
        }
      }
  } */
