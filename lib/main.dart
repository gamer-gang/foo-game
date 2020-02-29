import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.util.fullScreen();
  Flame.util.setOrientation(DeviceOrientation.landscapeLeft);

  Flame.images.loadAll(<String>[
    'bird-0.png',
    'bird-1.png',
    'bird-0-left.png',
    'bird-1-left.png',
    'cloud-1.png',
    'cloud-2.png',
    'cloud-3.png',
  ]);

  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({Key key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: darkBlue,
        accentColor: Colors.orangeAccent,
        primaryColor: darkBlue,
        fontFamily: "PTSans",
        brightness: Brightness.dark,
        textTheme: Typography.blackMountainView,
        buttonTheme: ButtonThemeData(
          buttonColor: darkBlueAccent,
          textTheme: ButtonTextTheme.normal,
        ),
      ),
      home: Scaffold(body: HomePage()),
    );
  }
}

