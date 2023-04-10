import 'dart:io';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';

Iterable<CallLogEntry> callList = [];

bool isValidIndianPhoneNumber(String phoneNumber) {
  final pattern = r'^(\+91|0)?[6789]\d{9}$';
  final regex = RegExp(pattern);
  return regex.hasMatch(phoneNumber);
}

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  PhoneStateStatus status = PhoneStateStatus.NOTHING;
  final PhoneState phoneState = PhoneState();

  bool granted = false;
  Future<bool> requestPermission() async {
    var status = await Permission.phone.request();

    switch (status) {
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        return false;
      case PermissionStatus.granted:
        return true;
    }
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) setStream();
  }

  void setStream() {
    PhoneState.phoneStateStream.listen((event) {
      setState(() {
        if (event != null) {
          status = event;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Log Status"),
            ElevatedButton(
              child: Text('Get logs'),
              onPressed: () {
                _callLogs();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 5),
                child: callList == null
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: callList.map((Callone) {
                        //populating children to column using map

                        return Container(
                          child: Card(
                              color: isValidIndianPhoneNumber(
                                      Callone.number.toString())
                                  ? Colors.green
                                  : Colors.red,
                              child: ListTile(
                                leading: Icon(Icons.call),
                                title: Padding(
                                    child: Text(Callone.name.toString()),
                                    padding: EdgeInsets.only(
                                        bottom: 10,
                                        top: 10)), // printing address
                                subtitle: Padding(
                                    child: Text(Callone.number.toString()),
                                    padding: EdgeInsets.only(
                                        bottom: 10,
                                        top:
                                            10)), //pringint date time, and body
                              )),
                        );
                      }).toList()),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _callLogs() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    bool isValidIndianPhoneNumber(String phoneNumber) {
      final pattern = r'^(\+91|0)?[6789]\d{9}$';
      final regex = RegExp(pattern);
      return regex.hasMatch(phoneNumber);
    }

    setState(() {
      callList = entries;
    });

    bool flag;
    for (var item in entries) {
      final isValid = isValidIndianPhoneNumber(item.number.toString());
      if (isValid && item.name != null) {
        flag = false;
      } else {
        flag = true;
      }

      print('Name: ${item.name} , Number: ${item.number} => ${flag}');
    }
  }
}
