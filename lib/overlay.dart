import 'package:flutter/material.dart';
// import 'package:flame/flame.dart';

import 'common.dart';
// import 'data/savedata.dart';
import 'data/store.dart';
import 'game.dart';

final Color _btnColor = darkBlue;
// _btnColorPressed = Color.fromARGB(255, 85, 109, 135);
final double _btnSize = 64, _iconSize = 40, _btnMargin = 20, _btnSpacing = 32;

class GamePage extends StatefulWidget {
  final SaveFile file;

  GamePage({this.file});

  @override
  _GamePageState createState() => _GamePageState(file);
}

class _GamePageState extends State<GamePage> {
  final SaveFile file;

  _GamePageState(this.file);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: setupGame(file),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GameOverlay(game: snapshot.data);
            } else {
              return loadingScreen();
            }
          }),
    );
  }
}

class GameOverlay extends StatefulWidget {
  final MonumentPlatformer game;

  const GameOverlay({Key key, @required this.game}) : super(key: key);

  @override
  _GameOverlayState createState() => _GameOverlayState(game);
}

class ColorManager {
  Color left;
  Color right;
  Color dash;
  Color jump;
  ColorManager({this.left, this.right, this.dash, this.jump});
}

class _GameOverlayState extends State<GameOverlay> {
  ColorManager colors = ColorManager(
    left: _btnColor,
    right: _btnColor,
    jump: _btnColor,
    dash: _btnColor,
  );

  MonumentPlatformer game;

  _GameOverlayState(this.game);

  void initState() {
    super.initState();
    game.gamepad.on('release-pause', (data) {
      game.gamepad.emit('pause');
      showDialog(
        context: context,
        builder: (context) => PauseMenu(game: game),
        barrierDismissible: false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(child: game.widget),
      Positioned(
        top: 0,
        left: 0,
        child: Row(children: [
          overlayButton(
            game: game,
            color: Colors.transparent,
            iconColor: Colors.black,
            key: GamepadButton.restart,
            icon: Icons.refresh,
          ),
        ]),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Row(children: [
          overlayButton(
            game: game,
            color: Color(0x00000000),
            key: GamepadButton.pause,
            iconColor: Colors.black,
            icon: Icons.pause,
            update: (newColor) {},
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
              game: game,
              color: colors.left,
              key: GamepadButton.left,
              icon: Icons.arrow_left,
              update: (newColor) => setState(() => colors.left = newColor),
            ),
            Spacer(),
            overlayButton(
              game: game,
              color: colors.right,
              key: GamepadButton.right,
              icon: Icons.arrow_right,
              update: (newColor) => setState(() => colors.right = newColor),
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
              game: game,
              color: colors.dash,
              key: GamepadButton.dash,
              icon: Icons.fast_forward,
              update: (newColor) => setState(() => colors.dash = newColor),
            ),
            Spacer(),
            overlayButton(
              game: game,
              color: colors.jump,
              key: GamepadButton.jump,
              icon: Icons.arrow_drop_up,
              update: (newColor) => setState(() => colors.jump = newColor),
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
  Color iconColor = Colors.white,
  Function(Color) update,
  GamepadButton key,
  IconData icon,
}) {
  // var releaseColor = Color(color != null ? color.value : _btnColor.value);
  // var pressColor =
  // Color(pressedColor != null ? pressedColor.value : _btnColorPressed.value);
  return Listener(
    onPointerDown: (pointerDownEvent) {
      // update(pressColor);
      game.press(key, pointerDownEvent);
    },
    onPointerUp: (pointerUpEvent) {
      // update(releaseColor);
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
          color: iconColor,
          size: _iconSize,
        ),
      ),
    ),
  );
}

class PauseMenu extends StatefulWidget {
  final MonumentPlatformer game;
  PauseMenu({Key key, @required this.game}) : super(key: key);

  @override
  _PauseMenuState createState() => _PauseMenuState(game);
}

class _PauseMenuState extends State<PauseMenu> {
  MonumentPlatformer game;

  _PauseMenuState(this.game);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        width: 300,
        height: 300,
        child: Column(children: [
          Text('pause menu'),
          RaisedButton(
            child: Text('goodbey'),
            onPressed: () {
              Navigator.pop(context);
              game.gamepad.emit('unpause');
            },
          ),
        ]),
      ),
    );
  }
}
