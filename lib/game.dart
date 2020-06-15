import 'dart:ui';

import 'package:flame/game.dart' as flame;
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';

import 'components/level.dart';
import 'components/levels/index.dart';
import 'components/particle.dart';
import 'components/player.dart';

enum GamepadButton { left, right, dash, jump }
enum GameState { playing, paused, gameOver }

class MonumentPlatformer extends flame.Game {
  Offset camera;
  Gamepad gamepad = Gamepad();
  Level level;
  Player player;
  Size viewport;
  ParticleManager particleManager = ParticleManager();

  MonumentPlatformer(Size screenDimensions, int levelNumber) {
    init(screenDimensions);
    camera = Offset(0, 0);
    player = Player.create(
      game: this,
      debug: true,
      pos: Offset(0, -20),
      size: Offset(50, 50),
      color: Color(0xff1e90ff),
    );
    level = levels[levelNumber](this);
  }

  void init(Size size) {
    viewport = size;
    // camera = Offset(viewport.width / 2, viewport.height / 2);
    camera = Offset(viewport.width / 2, viewport.height / 2);
  }

  void _renderLayer(
    Canvas c,
    Offset translation,
    void Function() renderLayer,
  ) {
    c.save();
    c.translate(translation.dx, translation.dy);
    renderLayer();
    c.restore();
  }

  void render(Canvas c) {
    // background
    level.renderBackground(c);

    // middleground
    _renderLayer(c, camera / 2, () {
      level.renderMiddleground(c);
    });

    // foreground
    _renderLayer(c, camera, () {
      level.renderForeground(c);
      player.render(c);
      particleManager.renderAll(c);
    });

    // UI
    level.renderUi(c);
  }

  void update(double t) {
    camera = Offset(
      (viewport.width - player.size.dx) / 2 - player.pos.dx,
      (viewport.height - player.size.dy) / 2 - player.pos.dy,
    );

    player.move(gamepad);
    player.update(t);

    particleManager.updateAll(t);

    level.updateBackground(t);
    level.updateForeground(t);
    level.updateMiddleground(t);
    level.updateUi(t);
  }

  void press(GamepadButton  pressed, PointerDownEvent event) {
    print("pressed $pressed");
    gamepad.press(pressed);
  }

  void release(GamepadButton released, PointerUpEvent event) {
    print("released $released");
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
