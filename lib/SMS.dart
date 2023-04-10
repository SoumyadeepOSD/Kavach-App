import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

bool isSpam = false;

class SMS extends StatefulWidget {
  @override
  _SMSState createState() => _SMSState();
}

class _SMSState extends State<SMS> {
  SmsQuery query = new SmsQuery();
  late List<SmsMessage> allmessages = [];

  @override
  void initState() {
    getAllMessages();
    super.initState();
  }

  void getAllMessages() {
    Future.delayed(Duration.zero, () async {
      List<SmsMessage> messages = await query.querySms(
        //querySms is from sms package
        kinds: [SmsQueryKind.Inbox, SmsQueryKind.Sent, SmsQueryKind.Draft],
        //filter Inbox, sent or draft messages
        count: 10, //number of sms to read
      );

      setState(() {
        //update UI
        allmessages = messages;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Check SMS"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Spam',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Safe',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  )
                ],
              )
            ],
          ),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: allmessages == null
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: allmessages.map((messageone) {
                    //populating children to column using map
                    String type =
                        "NONE"; //get the type of message i.e. inbox, sent, draft
                    if (messageone.kind == SmsMessageKind.Received) {
                      type = "Inbox";
                    } else if (messageone.kind == SmsMessageKind.Sent) {
                      type = "Outbox";
                    } else if (messageone.kind == SmsMessageKind.Draft) {
                      type = "Draft";
                    }
                    bool flag = false;
                    return Container(
                      child: Card(
                          color: (messageone.kind == SmsMessageKind.Received) &&
                                  (messageone.body.contains(RegExp(
                                      r"\b(viagra|cialis|Location|T&CA|Hurry!|online\s*pharmacy|earn\s*money|cheap\s*insurance)\b")))
                              ? Colors.red
                              : Colors.lightGreen,
                          child: ListTile(
                            leading: Icon(Icons.message),
                            title: Padding(
                                child: Text(
                                    messageone.address + " (" + type + ")"),
                                padding: EdgeInsets.only(
                                    bottom: 10, top: 10)), // printing address
                            subtitle: Padding(
                                child: Text(messageone.date.toString() +
                                    "\n" +
                                    messageone.body),
                                padding: EdgeInsets.only(
                                    bottom: 10,
                                    top: 10)), //pringint date time, and body
                          )),
                    );
                  }).toList()),
          ),
        ));
  }
}
