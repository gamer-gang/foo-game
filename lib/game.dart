// import 'dart:ui';
// import 'package:box2d_flame/box2d.dart' as b2;
import 'package:flame/box2d/box2d_game.dart';
import 'package:flame/box2d/box2d_component.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/painting.dart';

enum GamepadButton { left, right, dash, jump }
enum GameState { playing, paused, gameOver }

class MonumentPlatformer extends Box2DGame {
  MonumentPlatformer(Box2DComponent box) : super(box);
  /*
    class MyGame extends Box2DGame with TapDetector {
      MyGame(Box2DComponent box) : super(box) {
        final boundaries = createBoundaries(box);
        boundaries.forEach(add);
        addContactCallback(BallContactCallback());
        addContactCallback(BallWallContactCallback());
        addContactCallback(WhiteBallContactCallback());
      }
    }

    class MyBox2D extends Box2DComponent {
      MyBox2D() : super(scale: 4.0, gravity: -10.0);

      @override
      void initializeWorld() {}
    }
  */
}

class MonumentPlatformerBox2D extends Box2DComponent {
  MonumentPlatformerBox2D() : super(scale: 4.0, gravity: -10.0);

  @override
  void initializeWorld() {

  }
}

class Gamepad {
  bool left, right, dash, jump;

  Gamepad() {
    left = false;
    right = false;
    dash = false;
    jump = false;
  }

  void press(GamepadButton button) {
    switch (button) {
      case GamepadButton.left:
        left = true;
        break;
      case GamepadButton.right:
        right = true;
        break;
      case GamepadButton.jump:
        jump = true;
        break;
      case GamepadButton.dash:
        dash = true;
        break;
    }
  }

  void release(GamepadButton button) {
    switch (button) {
      case GamepadButton.left:
        left = false;
        break;
      case GamepadButton.right:
        right = false;
        break;
      case GamepadButton.jump:
        jump = false;
        break;
      case GamepadButton.dash:
        dash = false;
        break;
    }
  }
}
