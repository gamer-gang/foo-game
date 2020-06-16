import 'dart:ui';

import 'package:flame/game.dart' as flame;
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';

import 'common.dart';
import 'components/level.dart';
import 'components/levels/index.dart';
import 'components/particle.dart';
import 'components/player.dart';
import 'data/savedata.dart';
import 'data/store.dart';

enum GamepadButton { left, right, dash, jump, restart, pause }
enum GameState { playing, paused, gameOver }

class MonumentPlatformer extends flame.Game {
  Offset camera;
  Level level;
  Gamepad gamepad;
  Player player;
  Size viewport;
  SaveData save;
  ParticleManager particleManager = ParticleManager();

  int frame = 0;
  bool _shouldUpdate = true;
  final int slowdown = 1;
  final bool updateWhenPressed = true;

  bool debug = true;
  GameState state = GameState.playing;

  MonumentPlatformer({Size dimensions, this.save}) {
    initScreen(dimensions);
    gamepad = Gamepad(this);
    camera = Offset(0, 0);
    player = Player.create(
      game: this,
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
    if (updateWhenPressed && gamepad.allReleased && !player.jumpedThisPress) {
      return;
    }
    if (state == GameState.paused) return;

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

class Gamepad extends EventTarget {
  bool left, right, dash, jump, pause;

  final MonumentPlatformer game;

  bool get allReleased => !left && !right && !dash && !jump;
  bool get allPressed => left && right && dash && jump;

  Gamepad(this.game) {
    left = false;
    right = false;
    dash = false;
    jump = false;
    pause = false;
  }

  void press(GamepadButton button) {
    switch (button) {
      case GamepadButton.left:
        left = true;
        emit('press', {'key': GamepadButton.left});
        break;
      case GamepadButton.right:
        right = true;
        emit('press', {'key': GamepadButton.right});
        break;
      case GamepadButton.jump:
        jump = true;
        emit('press', {'key': GamepadButton.jump});
        break;
      case GamepadButton.dash:
        dash = true;
        emit('press', {'key': GamepadButton.dash});
        break;
      case GamepadButton.restart:
        if (!game.player.dead) game.player.deathFrames = 60;
        emit('press', {'key': GamepadButton.restart});
        break;
      case GamepadButton.pause:
        pause = true;
        emit('press', {'key': GamepadButton.pause});
        break;
    }
  }

  void release(GamepadButton button) {
    switch (button) {
      case GamepadButton.left:
        left = false;
        emit('release', {'key': GamepadButton.left});
        break;
      case GamepadButton.right:
        right = false;
        emit('release', {'key': GamepadButton.right});
        break;
      case GamepadButton.jump:
        jump = false;
        emit('release', {'key': GamepadButton.jump});
        break;
      case GamepadButton.dash:
        dash = false;
        emit('release', {'key': GamepadButton.dash});
        break;
      case GamepadButton.restart:
        // nothing
        emit('release', {'key': GamepadButton.restart});
        break;
      case GamepadButton.pause:
        // TODO handle pause
        emit('release', {'key': GamepadButton.pause});
        break;
    }
  }
}
