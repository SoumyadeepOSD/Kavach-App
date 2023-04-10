import 'package:flutter/material.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class UPI extends StatefulWidget {
  const UPI({Key? key}) : super(key: key);

  @override
  State<UPI> createState() => _UPIState();
}

class _UPIState extends State<UPI> {
  final upiDetails = UPIDetails(
    upiID: "Sender UPI ID",
    payeeName: "Sender Name",
    transactionID: "Your Unique ID",
    transactionNote: "Payment for GYM",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'UPI ID: ${upiDetails.upiID}\n Payee Name: ${upiDetails.payeeName}\n Amount ${upiDetails.amount}',
            ),
            const SizedBox(
              height: 10,
            ),
            UPIPaymentQRCode(
              upiDetails: upiDetails,
              size: 200,
            ),
          ],
        ),
      ),
    );
  }
}
