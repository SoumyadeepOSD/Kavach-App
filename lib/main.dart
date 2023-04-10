import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kavach/SMS.dart';
import 'package:kavach/URL.dart';
import 'package:kavach/google_sign_in.dart';
import 'package:kavach/phone.dart';
import 'package:provider/provider.dart';
import 'UPI.dart';
import 'onboard.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/gestures.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          home: OnBoard(),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade900,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Check Spam contents',
              style: TextStyle(
                color: Colors.green,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 30),
              height: 500,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.orange.shade900,
                        Colors.white,
                        Colors.green.shade700
                      ]),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Image.network(
                                width: 50,
                                height: 50,
                                'https://cdn0.iconfinder.com/data/icons/ui-essence/32/_59ui-512.png'),
                            ElevatedButton(
                              child: Text('Protect Calls'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Phone()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Image.network(
                                width: 50,
                                height: 50,
                                'https://th.bing.com/th/id/OIP.m5mivS6XbKizUDvX2a3y2gAAAA?pid=ImgDet&rs=1'),
                            ElevatedButton(
                              child: Text('Filter SMS'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SMS()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Image.network(
                                width: 50,
                                height: 50,
                                'https://logodix.com/logo/1931302.png'),
                            ElevatedButton(
                              child: Text('Scan URLS'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => URL()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Image.network(
                                width: 50,
                                height: 50,
                                'https://pixlok.com/wp-content/uploads/2021/01/UPI_logo_PNG.jpg'),
                            ElevatedButton(
                              child: Text('Protect UPI'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UPI()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'मेरा भारत गौरव है',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
