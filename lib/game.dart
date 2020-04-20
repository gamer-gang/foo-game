import 'dart:ui';

import 'package:flame/game.dart' as Flame;
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';

import 'components/level.dart';
import 'components/player.dart';
import 'components/background.dart';
import 'components/platform.dart';

enum GamepadButton { left, right, dash, jump }
enum GameState { playing, paused, gameOver }

class MonumentPlatformer extends Flame.Game {
  Background background;
  Offset camera;
  Gamepad gamepad;
  Level level;
  Player player;
  Size viewport;

  MonumentPlatformer(Size screenDimensions) {
    init(screenDimensions);
    camera = Offset(0, 0);
    player = Player.create(
      game: this,
      debug: true,
      initialPosition: Offset(0, 0),
      size: Offset(50, 50),
      color: Color(0xff1e90ff),
    );
    background = Background.create(
      game: this,
      initialColor: Color(0xffffffff),
    );
    gamepad = Gamepad();
    level = Level.create(
      game: this,
      platforms: [
        Platform.create(
          game: this,
          color: Color(0xff333333),
          initialPosition: Offset(30, 30),
          size: Offset(70, 20),
        ),
        Platform.create(
          game: this,
          color: Color(0xff333333),
          initialPosition: Offset(60, 60),
          size: Offset(70, 20),
        ),
      ],
    );
  }

  void init(Size size) {
    viewport = size;
    // camera = Offset(viewport.width / 2, viewport.height / 2);
    camera = Offset(viewport.width / 2, viewport.height / 2);
  }

  void render(Canvas c) {
    // static things to render, like the background or UI
    background.render(c);

    c.save();
    c.translate(camera.dx, camera.dy);

    player.render(c);
    level.render(c);

    c.restore();
  }

  void update(double t) {
    camera = Offset(
      (viewport.width - player.size.dx) / 2 - player.pos.dx,
      (viewport.height - player.size.dy) / 2 - player.pos.dy,
    );

    player.update(t);
    player.move(gamepad);
    background.updateColor(player.pos);
  }

  void press(GamepadButton pressed, PointerDownEvent event) {
    print("pressed " + pressed.toString());
    gamepad.press(pressed);
  }

  void release(GamepadButton released, PointerUpEvent event) {
    print("released " + released.toString());
    gamepad.release(released);
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
