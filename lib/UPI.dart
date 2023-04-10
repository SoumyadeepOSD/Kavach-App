import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

List<String> parts = [];
var info = '';
var part1 = '';
var info1 = '';

class UPI extends StatefulWidget {
  @override
  _UPIState createState() => _UPIState();
}

class _UPIState extends State<UPI> {
  String _scanBarcode = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Barcode scan'),
          backgroundColor: Colors.black,
        ),
        body: Builder(
          builder: (BuildContext context) {
            info = _scanBarcode.toString();
            String upi = UPIID(info);
            String marchantname = NAME(info);
            String phone = PHONE(info);
            return Container(
              alignment: Alignment.center,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    height: 100,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          primary: Colors.blue.shade600,
                        ),
                        onPressed: () => scanBarcodeNormal(),
                        child: Text(
                          'UPI Scan',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                  ),
                  // ElevatedButton(
                  //     onPressed: () => scanQR(),
                  //     child: Text('Start QR scan')),
                  // ElevatedButton(
                  //     onPressed: () => startBarcodeScanStream(),
                  //     child: Text('Start barcode scan stream')),
                  SizedBox(
                    height: 5,
                  ),
                  Text('User Info:\n',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _scanBarcode != null
                          ? Colors.lightGreen.shade100
                          : Colors.white,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 30, right: 10),
                        child: Column(
                          children: [
                            marchantname != null
                                ? Text(
                                    'Name: ${marchantname}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                : Text(''),
                            phone != null
                                ? Text(
                                    'Phone:${phone}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                : Text(''),
                            Text(
                              'UPI:${upi}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

String UPIID(String text) {
  RegExp regex = RegExp(r'pay\?pa=([^&]*)');
  String? match = regex.firstMatch(text)?.group(1);
  return match.toString();
}

String NAME(String text) {
  RegExp regex = RegExp(r'&pn=([^&]*)');
  String result = Uri.decodeComponent(regex.firstMatch(text)?.group(1) ?? '');
  return result.toString();
}

String PHONE(String text) {
  RegExp regex = RegExp(r'pa=(\d+)@');
  String result = regex.firstMatch(text)?.group(1) ?? '';

  RegExp regex1 = RegExp(r'tr=(EZY\d{10})');
  String result1 = regex.firstMatch(text)?.group(1) ?? '';
  if (result != null) {
    return result.toString();
  } else {
    return result1.toString();
  }
}
