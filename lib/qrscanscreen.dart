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
  String QRString = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
            child: new Column(
              children: <Widget>[
                new Container(
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? new CupertinoButton(
                    child: new Text("Scan"),
                    onPressed:  scan,)
                      : new IconButton(
                      icon: new Icon(Icons.send),
                      onPressed:  scan,)),

                new Center(child: new Text(this.QRString)),
              ],
            ),
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
      this.QRString = str;
    });
  }
}