import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'common.dart';
import 'home.dart';

void main() => runApp(MainApp());

/*
Main hierarchy:

void main => StatefulWidget MainApp => [
  StatefulWidget HomePage || 
  StatelessWidget GamePage || 
  StatefulWidget SettingsPage
]
*/

class MainApp extends StatefulWidget {
  const MainApp({Key key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    Flame.util.fullScreen();
    Flame.util.setOrientation(DeviceOrientation.landscapeLeft);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: darkBlue,
          accentColor: Colors.orangeAccent,
          primaryColor: darkBlue,
          fontFamily: "PTSans",
          brightness: Brightness.dark,
          textTheme: TextTheme(

          ),
          buttonTheme: ButtonThemeData(
            buttonColor: darkBlueAccent,
            textTheme: ButtonTextTheme.normal,
          )),
      home: Scaffold(body: HomePage()),
    );
  }
}
