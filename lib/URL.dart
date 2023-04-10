import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

bool flag = false;

class URL extends StatefulWidget {
  const URL({super.key});

  @override
  State<URL> createState() => _URLState();
}

class _URLState extends State<URL> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerURL = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Varify URL'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 200),
        child: Center(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              child: TextField(
                controller: controllerURL,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Paste/type your URL',
                    label: Text('Put your link here'),
                    labelStyle: TextStyle(
                      color: Colors.black45,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  if (controllerURL.text == 'www.google.com') {
                    flag = false;
                  } else {
                    flag = true;
                  }
                });
              },
              child: const Text('test'),
            ),
            flag == true
                ? Text(
                    'Spam link!',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : Text(
                    'Safe link',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ],
        )),
      ),
    );
  }
}

// Future<void> fetchUrl(String url) async {
//   final response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     print(response.body);
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//   }
// }
