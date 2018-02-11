import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io';

class QRGenScreen extends StatefulWidget {
  @override
  State createState() => new QRGenScreenState();
}

class QRGenScreenState extends State<QRGenScreen> {
  static const platform = const MethodChannel('tk.ravenmessenger/genQR');

  String _fileName = "";
  Image _img = new Image.network("https://static.pexels.com/photos/20787/pexels-photo.jpg");

  Future<Null> _genQR() async {
    String fileName;
    try {
      Map<String, dynamic> args = {
        "fileName": fileName,
        "value": "testqr",
      };
      final String result = await platform.invokeMethod('genQR', args);
      fileName = result;
    } on PlatformException catch (e) {
      fileName = "";
    }

    setState(() {
      _fileName = fileName;
      _img = new Image.file(new File(_fileName));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new RaisedButton(onPressed: _genQR),
          new Text(_fileName),
          _img,
        ],
      ),
    );
  }
}
