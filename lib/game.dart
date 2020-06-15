import 'dart:ui';

import 'package:flame/game.dart' as flame;
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';

import 'components/level.dart';
import 'components/levels/index.dart';
import 'components/particle.dart';
import 'components/player.dart';
import 'data/savedata.dart';
import 'data/store.dart';

enum GamepadButton { left, right, dash, jump, restart }
enum GameState { playing, paused, gameOver }

class MonumentPlatformer extends flame.Game {
  Offset camera;
  Level level;
  Gamepad gamepad;
  Player player;
  Size viewport;
  SaveData save;
  ParticleManager particleManager = ParticleManager();

  bool _shouldUpdate = true;
  int slowdown = 1;
  int frame = 0;

  bool debug = true;

  MonumentPlatformer({Size dimensions, this.save}) {
    initScreen(dimensions);
    gamepad = Gamepad(this);
    camera = Offset(0, 0);
    player = Player.create(
      game: this,
      debug: true,
      pos: Offset(0, -20),
      size: Offset(50, 50),
      color: Color(0xff1e90ff),
    );
    level = levels[save.level](this);
  }

  void initScreen(Size size) {
    viewport = size;
    // camera = Offset(viewport.width / 2, viewport.height / 2);
    camera = Offset(viewport.width / 2, viewport.height / 2);
  }

  Future<void> saveToFile() async {
    var store = SaveDataStore();
    await store.writeSaveFile(save.fileNumber, save);
    return;
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
    frame++;
    _shouldUpdate = frame % slowdown == 0;

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
    if (!_shouldUpdate) return;

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

  void press(GamepadButton pressed, PointerDownEvent event) {
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

  final MonumentPlatformer game;

  Gamepad(this.game) {
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
      case GamepadButton.restart:
        // TODO handle restart
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
      case GamepadButton.restart:
        // TODO handle restart
        break;
    }
  }
}
