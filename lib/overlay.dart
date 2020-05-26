import 'package:flutter/material.dart';

import 'common.dart';
import 'game.dart';

enum File { file1, file2, file3 }

final Color _btnColor = darkBlue,
    _btnColorPressed = Color.fromARGB(255, 85, 109, 135);
final double _btnSize = 64, _iconSize = 40, _btnMargin = 20, _btnSpacing = 32;

class GamePage extends StatefulWidget {
  final File file;
  final MonumentPlatformer game;

  GamePage({this.game, this.file});

  @override
  _GamePageState createState() => _GamePageState(game);
}

class _GamePageState extends State<GamePage> {
  final MonumentPlatformer game;

  _GamePageState(this.game);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameStack(game: game),
    );
  }
}

class GameStack extends StatefulWidget {
  final MonumentPlatformer game;

  const GameStack({
    Key key,
    @required this.game,
  }) : super(key: key);

  @override
  _GameStackState createState() => _GameStackState();
}

class _GameStackState extends State<GameStack> {
  Color _leftBtnColor, _rightBtnColor, _dashBtnColor, _jumpBtnColor;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(child: widget.game.widget),
      Positioned(
        top: 0,
        left: 0,
        child: Row(children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
          ),
        ]),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Row(children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.pause,
              color: Colors.black,
            ),
          ),
        ]),
      ),
      Positioned(
        bottom: _btnMargin,
        left: _btnMargin,
        child: Container(
          width: _btnSize * 2 + _btnSpacing,
          child: Row(children: [
            overlayButton(
              game: widget.game,
              color: _leftBtnColor,
              key: GamepadButton.left,
              icon: Icons.arrow_left,
              update: (newColor) => setState(() => _leftBtnColor = newColor),
            ),
            Spacer(),
            overlayButton(
              game: widget.game,
              color: _rightBtnColor,
              key: GamepadButton.right,
              icon: Icons.arrow_right,
              update: (newColor) => setState(() => _rightBtnColor = newColor),
            ),
          ]),
        ),
      ),
      Positioned(
        bottom: _btnMargin,
        right: _btnMargin,
        child: Container(
          width: _btnSize * 2 + _btnSpacing,
          child: Row(children: [
            overlayButton(
              game: widget.game,
              color: _dashBtnColor,
              key: GamepadButton.dash,
              icon: Icons.fast_forward,
              update: (newColor) => setState(() => _dashBtnColor = newColor),
            ),
            Spacer(),
            overlayButton(
              game: widget.game,
              color: _jumpBtnColor,
              key: GamepadButton.jump,
              icon: Icons.arrow_drop_up,
              update: (newColor) => setState(() => _jumpBtnColor = newColor),
            ),
          ]),
        ),
      ),
    ]);
  }
}

Widget overlayButton({
  MonumentPlatformer game,
  Color color,
  Function(Color) update,
  GamepadButton key,
  IconData icon,
}) {
  if (color == null) color = _btnColor;
  return Listener(
    onPointerDown: (pointerDownEvent) {
      update(_btnColorPressed);
      game.press(key, pointerDownEvent);
    },
    onPointerUp: (pointerUpEvent) {
      update(_btnColor);
      game.release(key, pointerUpEvent);
    },
    child: AnimatedContainer(
      curve: Curves.easeOut,
      duration: Duration(milliseconds: 75),
      width: _btnSize,
      height: _btnSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
          size: _iconSize,
        ),
      ),
    ),
  );
}

// class OverlayButton extends StatelessWidget {
//   const OverlayButton({
//     Key key,
//     @required Color buttonColor,
//   })  : _buttonColor = buttonColor,
//         super(key: key);

//   final Color _buttonColor;

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
