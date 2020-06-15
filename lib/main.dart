import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common.dart';
import 'home.dart';

void main() => runApp(LoadingPage());
int levelNumber = 0;

Future<void> setupScreen() async {
  // var completer = new Completer<MonumentPlatformerGame>();

  await Flame.util.setOrientation(DeviceOrientation.landscapeLeft);
  await Flame.util.fullScreen();

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
  const LoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setupScreen().then((_) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) => MainApp(),
          transitionsBuilder: pageTransition,
        ),
      );
    });
    return Scaffold(
      body: loadingScreen(),
    );
  }
}

class MainApp extends StatefulWidget {
  MainApp({Key key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  _MainAppState();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: commonTheme(),
      home: Scaffold(body: HomePage()),
    );
  }
}

/// Transition for file selection.
SlideTransition fileSelectTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  var tween = Tween(
    begin: Offset(0, 1),
    end: Offset(0, 0.8),
  ).chain(
    CurveTween(curve: Curves.ease),
  );

  var offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}