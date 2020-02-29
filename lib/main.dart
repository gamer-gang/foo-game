import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common.dart';
import 'home.dart';

void main() async {
  runApp(LoadingPage());

  await Flame.util.fullScreen();
  await Flame.util.setOrientation(DeviceOrientation.landscapeLeft);

  await Flame.images.loadAll(<String>[
    'bird-0.png',
    'bird-1.png',
    'bird-0-left.png',
    'bird-1-left.png',
    'cloud-1.png',
    'cloud-2.png',
    'cloud-3.png',
  ]);

  
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: commonTheme(),
      home: LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () => Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, anim1, anim2) => MainApp(),
      transitionsBuilder: pageTransition,
    )));
    return Scaffold(
      body: Container(
        color: darkBlue,
        child: Center(
          child: Column(children: <Widget>[
            Spacer(flex: 16),
            Text(
              "MONUMENT PLATFORMER",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            Spacer(),
            Text(
              "Loading...",
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            CircularProgressIndicator(
              strokeWidth: 2,
              value: null,
            ),
            Spacer(flex: 16)
          ]),
        ),
      ),
    );
  }
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
      theme: commonTheme(),
      home: Scaffold(body: HomePage()),
    );
  }
}
