import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class QRScanScreen extends StatefulWidget {
  @override
  State createState() => new QRScanScreenState();
}

class QRScanScreenState extends State<QRScanScreen> {
  String barcode = "";

  @override
  Widget build(BuildContext context) {
//    scan();
    FlutterBlue flutterBlue = FlutterBlue.instance;
    /// Start scanning
    var scanSubscription = flutterBlue.scan().listen((scanResult) {
      print("LOCALNAME: " + scanResult.advertisementData.localName);
      print(scanResult);
      ScanResult sr = scanResult;
      print("NAME: " + sr.device.name);
      // do something with scan result
    });

    /// Stop scanning
    scanSubscription.cancel();

//    /// Create a connection to the device
//    var deviceConnection = flutterBlue.connect(device).listen((s) {
//      if(s == BluetoothDeviceState.connected) {
//        // device is connected, do something
//      }
//    });
//
//    /// Disconnect from device
//    deviceConnection.cancel();

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
