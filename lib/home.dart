import 'dart:async';

import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'common.dart';
import 'game.dart';
import 'overlay.dart';

Future<MonumentPlatformerGame> initGame() {
  var completer = new Completer<MonumentPlatformerGame>();

  Flame.util.initialDimensions().then((Size dimensions) {
    MonumentPlatformerGame game = MonumentPlatformerGame(dimensions);
    TapGestureRecognizer tapRecognizer = TapGestureRecognizer();
    tapRecognizer.onTapDown = game.onTapDown;
    tapRecognizer.onTapUp = game.onTapUp;
    Flame.util.addGestureRecognizer(tapRecognizer);

    completer.complete(game);
  });

  return completer.future;
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static bool bottomSheetVisible = false;

  @override
  Widget build(BuildContext context) {
    MonumentPlatformerGame game;
    initGame().then((val) => game = val);

    return Scaffold(
      body: Container(
        color: darkBlue,
        child: Center(
          child: Column(children: <Widget>[
            Spacer(flex: 3),
            Text(
              "MONUMENT PLATFORMER",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                letterSpacing: 6,
              ),
            ),
            Spacer(),
            Text(
              "A minimalist platformer game",
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            RaisedButton(
              child: Text("Start"),
              onPressed: () {
                if (!bottomSheetVisible) {
                  bottomSheetVisible = true;
                  showBottomSheet(
                    elevation: 4,
                    context: context,
                    builder: (context) => FileSelector(game: game),
                  );
                }
              },
            ),
            Spacer(flex: 3),
          ]),
        ),
      ),
    );
  }
}

class FileSelector extends StatelessWidget {
  final MonumentPlatformerGame game;
  const FileSelector({MonumentPlatformerGame game}) : this.game = game;

  final double buttonPadding = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: darkBlueAccent,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(children: <Widget>[
          Spacer(flex: 1),
          IconButton(
            onPressed: () {
              _HomePageState.bottomSheetVisible = false;
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_downward),
            color: Colors.white,
          ),
          Text(
            "Select file",
            style: TextStyle(fontSize: 20),
          ),
          Spacer(flex: 256),
          RaisedButton(
            color: darkBlue,
            padding: EdgeInsets.all(buttonPadding),
            child: Text(
              "File 1",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, anim1, anim2) => GamePage(
                  game: game,
                  file: File.file1,
                ),
                transitionsBuilder: pageTransition,
              ));
            },
          ),
          Spacer(flex: 4),
          RaisedButton(
            color: darkBlue,
            padding: EdgeInsets.all(buttonPadding),
            child: Text(
              "File 2",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, anim1, anim2) => GamePage(
                  game: game,
                  file: File.file2,
                ),
                transitionsBuilder: pageTransition,
              ));
            },
          ),
          Spacer(flex: 4),
          RaisedButton(
            color: darkBlue,
            padding: EdgeInsets.all(buttonPadding),
            child: Text(
              "File 3",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, anim1, anim2) => GamePage(
                  game: game,
                  file: File.file1,
                ),
                transitionsBuilder: pageTransition,
              ));
            },
          ),
          Spacer(flex: 32),
        ]),
      ),
    );
  }
}
