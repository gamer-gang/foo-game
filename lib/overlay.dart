import 'package:flutter/material.dart';

import 'common.dart';
import 'game.dart';

enum File { file1, file2, file3 }

final Color _overlayButtonColor = darkBlue;
final double _overlayButtonSize = 64,
    _overlayIconSize = 40,
    _overlayButtonMargin = 20,
    _overlayButtonSpacing = 32;

class GamePage extends StatefulWidget {
  final MonumentPlatformerGame game;
  final File file;
  GamePage({MonumentPlatformerGame game, File file})
      : this.game = game,
        this.file = file;

  @override
  _GamePageState createState() => _GamePageState(game);
}

class _GamePageState extends State<GamePage> {
  _GamePageState(this.game);
  final MonumentPlatformerGame game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameStack(game: game),
    );
  }
}

class GameStack extends StatelessWidget {
  const GameStack({
    Key key,
    @required this.game,
  }) : super(key: key);

  final MonumentPlatformerGame game;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
          child: game == null ? Container(color: Colors.black) : game.widget),
      Positioned(
        top: 0,
        right: 0,
        child: Row(children: <Widget>[
          IconButton(
            onPressed: () {
              // Navigator.of(context).push(
              //   PageRouteBuilder(
              //     pageBuilder: (context, animation1, animation2) =>
              //         SettingsPage(),
              //     transitionsBuilder: pageTransition,
              //   ),
              // );
            },
            icon: Icon(
              Icons.pause,
              color: Colors.white,
            ),
          ),
        ]),
      ),
      Positioned(
        bottom: _overlayButtonMargin,
        left: _overlayButtonMargin,
        child: Container(
          width: _overlayButtonSize * 2 + _overlayButtonSpacing,
          child: Row(children: <Widget>[
            Listener(
              onPointerDown: (PointerDownEvent pointerDownEvent) =>
                  game.pressed([GamepadButtons.left], pointerDownEvent),
              onPointerUp: (PointerUpEvent pointerUpEvent) =>
                  game.released([GamepadButtons.left], pointerUpEvent),
              child: Container(
                width: _overlayButtonSize,
                height: _overlayButtonSize,
                child: Container(
                  decoration: BoxDecoration(
                    color: _overlayButtonColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_left,
                      color: Colors.white,
                      size: _overlayIconSize,
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Listener(
              onPointerDown: (PointerDownEvent pointerDownEvent) =>
                  game.pressed([GamepadButtons.right], pointerDownEvent),
              onPointerUp: (PointerUpEvent pointerUpEvent) =>
                  game.released([GamepadButtons.right], pointerUpEvent),
              child: Container(
                width: _overlayButtonSize,
                height: _overlayButtonSize,
                child: Container(
                  decoration: BoxDecoration(
                    color: _overlayButtonColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_right,
                      color: Colors.white,
                      size: _overlayIconSize,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
      Positioned(
        bottom: _overlayButtonMargin,
        right: _overlayButtonMargin,
        child: Container(
          width: _overlayButtonSize * 2 + _overlayButtonSpacing,
          child: Row(children: <Widget>[
            Listener(
              onPointerDown: (PointerDownEvent pointerDownEvent) =>
                  game.pressed([GamepadButtons.dash], pointerDownEvent),
              onPointerUp: (PointerUpEvent pointerUpEvent) =>
                  game.released([GamepadButtons.dash], pointerUpEvent),
              child: Container(
                width: _overlayButtonSize,
                height: _overlayButtonSize,
                child: Container(
                  decoration: BoxDecoration(
                    color: _overlayButtonColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.fast_forward,
                      color: Colors.white,
                      size: _overlayIconSize - 16,
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Listener(
              onPointerDown: (PointerDownEvent pointerDownEvent) =>
                  game.pressed([GamepadButtons.jump], pointerDownEvent),
              onPointerUp: (PointerUpEvent pointerUpEvent) =>
                  game.released([GamepadButtons.jump], pointerUpEvent),
              child: Container(
                width: _overlayButtonSize,
                height: _overlayButtonSize,
                child: Container(
                  decoration: BoxDecoration(
                    color: _overlayButtonColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_drop_up,
                      color: Colors.white,
                      size: _overlayIconSize,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    ]);
  }
}
