import 'package:flutter/material.dart';

import 'common.dart';
import 'game.dart';

enum File { file1, file2, file3 }

final Color _overlayButtonColor = darkBlue,
    _overlayButtonPressedColor = Color.fromARGB(255, 85, 109, 135);
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

class GameStack extends StatefulWidget {
  const GameStack({
    Key key,
    @required this.game,
  }) : super(key: key);

  final MonumentPlatformerGame game;

  @override
  _GameStackState createState() => _GameStackState();
}

class _GameStackState extends State<GameStack> {
  Color _leftButtonColor = _overlayButtonColor,
      _rightButtonColor = _overlayButtonColor,
      _dashButtonColor = _overlayButtonColor,
      _jumpButtonColor = _overlayButtonColor;
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
          child: widget.game == null
              ? Container(color: Colors.black)
              : widget.game.widget),
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
              onPointerDown: (PointerDownEvent pointerDownEvent) {
                setState(() => _leftButtonColor = _overlayButtonPressedColor);
                widget.game.pressed([GamepadButtons.left], pointerDownEvent);
              },
              onPointerUp: (PointerUpEvent pointerUpEvent) {
                setState(() => _leftButtonColor = _overlayButtonColor);
                widget.game.released([GamepadButtons.left], pointerUpEvent);
              },
              child: AnimatedContainer(
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 75),
                width: _overlayButtonSize,
                height: _overlayButtonSize,
                decoration: BoxDecoration(
                  color: _leftButtonColor,
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
            Spacer(),
            Listener(
              onPointerDown: (PointerDownEvent pointerDownEvent) {
                setState(() => _rightButtonColor = _overlayButtonPressedColor);
                widget.game.pressed([GamepadButtons.right], pointerDownEvent);
              },
              onPointerUp: (PointerUpEvent pointerUpEvent) {
                setState(() => _rightButtonColor = _overlayButtonColor);
                widget.game.released([GamepadButtons.right], pointerUpEvent);
              },
              child: AnimatedContainer(
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 75),
                width: _overlayButtonSize,
                height: _overlayButtonSize,
                decoration: BoxDecoration(
                  color: _rightButtonColor,
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
              onPointerDown: (PointerDownEvent pointerDownEvent) {
                setState(() => _dashButtonColor = _overlayButtonPressedColor);
                widget.game.pressed([GamepadButtons.dash], pointerDownEvent);
              },
              onPointerUp: (PointerUpEvent pointerUpEvent) {
                setState(() => _dashButtonColor = _overlayButtonColor);
                widget.game.released([GamepadButtons.dash], pointerUpEvent);
              },
              child: AnimatedContainer(
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 75),
                width: _overlayButtonSize,
                height: _overlayButtonSize,
                decoration: BoxDecoration(
                  color: _dashButtonColor,
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
            Spacer(),
            Listener(
              onPointerDown: (PointerDownEvent pointerDownEvent) {
                setState(() => _jumpButtonColor = _overlayButtonPressedColor);
                widget.game.pressed([GamepadButtons.jump], pointerDownEvent);
              },
              onPointerUp: (PointerUpEvent pointerUpEvent) {
                setState(() => _jumpButtonColor = _overlayButtonColor);
                widget.game.released([GamepadButtons.jump], pointerUpEvent);
              },
              child: AnimatedContainer(
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 75),
                width: _overlayButtonSize,
                height: _overlayButtonSize,
                decoration: BoxDecoration(
                  color: _jumpButtonColor,
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
          ]),
        ),
      ),
    ]);
  }
}
