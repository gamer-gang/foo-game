import 'package:flutter/material.dart';
import 'common.dart';
import 'game.dart';
import 'settings.dart';

MainGame game = MainGame();

final Color _overlayButtonColor = darkBlue;
final double _overlayButtonSize = 64;

class GamePage extends StatefulWidget {
  const GamePage({Key key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(child: game.widget),
        Positioned(
          top: 0,
          right: 0,
          child: Row(children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => SettingsPage(),
                    transitionsBuilder: pageTransition,
                  ),
                );
              },
              icon: Icon(
                Icons.pause,
                color: Colors.white,
              ),
            ),
          ]),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Container(
            width: 156,
            child: Row(children: <Widget>[
              Container(
                width: _overlayButtonSize,
                height: _overlayButtonSize,
                child: RawMaterialButton(
                  shape: CircleBorder(),
                  onPressed: () {},
                  fillColor: _overlayButtonColor,
                  child: Icon(
                    Icons.arrow_left,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              Container(
                width: _overlayButtonSize,
                height: _overlayButtonSize,
                child: RawMaterialButton(
                  shape: CircleBorder(),
                  onPressed: () {},
                  fillColor: _overlayButtonColor,
                  child: Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                  ),
                ),
              ),
            ]),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            width: 156,
            child: Row(children: <Widget>[
              Container(
                width: _overlayButtonSize,
                height: _overlayButtonSize,
                child: RawMaterialButton(
                  shape: CircleBorder(),
                  onPressed: () {},
                  fillColor: _overlayButtonColor,
                  child: Icon(
                    Icons.fast_forward,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              Container(
                width: _overlayButtonSize,
                height: _overlayButtonSize,
                child: RawMaterialButton(
                  shape: CircleBorder(),
                  onPressed: () {},
                  fillColor: _overlayButtonColor,
                  child: Icon(
                    Icons.arrow_drop_up,
                    color: Colors.white,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}

