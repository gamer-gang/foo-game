import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue.shade900,
        backgroundColor: Colors.red.shade900,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('A P P  B A R')),
        body: Container(
          color: Colors.red.shade900,
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Hello Wolrd',
                  style: TextStyle(color: Colors.green, fontSize: 40.0),
                ),
              ),
              Center(
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Hello Wolrd',
                    style: TextStyle(color: Colors.green, fontSize: 40.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
