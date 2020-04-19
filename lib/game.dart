import 'dart:ui';

import 'package:flame/game.dart' as Flame;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/painting.dart';

import 'components/player.dart';
import 'components/background.dart';
import 'components/platform.dart';
import 'components/text.dart';

enum GamepadButton { left, right, dash, jump }
enum GameState { playing, paused, gameOver }

class MonumentPlatformer extends Flame.Game {
  Size viewport;
  Offset camera;
  Gamepad gamepad;

  Player player;
  Background background;
  Platform platform;

  Text playerPosX;
  Text playerPosY;

  MonumentPlatformer(Size screenDimensions) {
    init(screenDimensions);
    camera = Offset(0, 0);
    player = Player(
      game: this,
      initialPosition: Offset(0, 0),
      size: Offset(50, 50),
      color: Color(0xff1e90ff),
    );
    background = Background(
      game: this,
      initialColor: Color(0xffffffff),
    );
    gamepad = Gamepad();
    platform = Platform(
      game: this,
      color: Color(0xff333333),
      initialPosition: Offset(30, 30),
      size: Offset(70, 20),
    );
    playerPosX = Text(
      game: this,
      align: TextAlign.left,
      pos: Offset(30, viewport.width / 4),
      style: TextStyle(
        color: Colors.black,
        fontFamily: "PTSans",
      ),
      text: '',
      size: 14,
    );
    playerPosY = Text(
      game: this,
      align: TextAlign.left,
      pos: Offset(30, -(viewport.width / 4)),
      style: TextStyle(
        color: Colors.black,
        fontFamily: "PTSans",
      ),
      text: '',
      size: 14,
    );
  }

  void init(Size size) {
    viewport = size;
    camera = Offset(viewport.width / 2, viewport.height / 2);
  }

  void render(Canvas c) {
    // static things to render, like background
    background.render(c);
    playerPosX.render(c);
    playerPosY.render(c);

    // save original location for later
    c.save();
    c.translate(camera.dx, camera.dy);

    // things to render that move when the camera does
    player.render(c);
    platform.render(c);
    
    // reset back to original location
    c.restore();
  }

  void update(double t) {
    camera = Offset(
      // (viewport.width - player.size.dx) / 2 + 
      player.pos.dx,
      // (viewport.height - player.size.dy) / 2 + 
      player.pos.dy,
    );
    player.update(t);
    player.move(gamepad);
    background.updatePosition(player.pos);
    playerPosX.setText(player.pos.dx.toString());
    playerPosY.setText(player.pos.dy.toString());
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
