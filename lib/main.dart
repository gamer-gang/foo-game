import 'dart:async';

import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common.dart';
import 'game.dart';
import 'home.dart';

void main() => runApp(LoadingPage());

Future<MonumentPlatformerGame> initGame() async {
  var completer = new Completer<MonumentPlatformerGame>();

  await Flame.util.setOrientation(DeviceOrientation.landscapeLeft);
  await Flame.util.fullScreen();

  final Size dimensions = await Flame.util.initialDimensions();
  MonumentPlatformerGame game = MonumentPlatformerGame(dimensions);
  // TapGestureRecognizer tapRecognizer = TapGestureRecognizer();
  // tapRecognizer.onTapDown = game.onTapDown;
  // tapRecognizer.onTapUp = game.onTapUp;
  // Flame.util.addGestureRecognizer(tapRecognizer);

  completer.complete(game);
  return completer.future;
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
    initGame().then((MonumentPlatformerGame game) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) => MainApp(game: game),
          transitionsBuilder: pageTransition,
        ),
      );
    });
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
  MainApp({Key key, this.game}) : super(key: key);

  final MonumentPlatformerGame game;

  @override
  _MainAppState createState() => _MainAppState(game: game);
}

class _MainAppState extends State<MainApp> {
  _MainAppState({this.game});

  MonumentPlatformerGame game;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: commonTheme(),
      home: Scaffold(body: HomePage(game: game)),
    );
  }
}
