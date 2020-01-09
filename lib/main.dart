import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int foo = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue.shade900,
        backgroundColor: Colors.grey.shade200,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('A P P  B A R')),
        body: Container(
          color: Colors.grey.shade200,
          child: Row(
            children: <Widget>[
              Spacer(),
              Center(
                child: Text(
                  'Hello Wolrd',
                  style: TextStyle(color: Colors.green, fontSize: 40.0),
                ),
              ),
              Spacer(),
              Center(
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      foo++;
                    });
                  },
                  child: Text(
                    '$foo',
                    style: TextStyle(color: Colors.green, fontSize: 40.0),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
