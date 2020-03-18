import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';

import 'components/background.dart';
import 'components/dialog.dart';
import 'components/ground.dart';
import 'components/level.dart';
import 'components/platform.dart';
import 'components/player.dart';
import 'components/text.dart';
import 'components/wall.dart';

enum GamepadButtons { left, right, jump, dash }
enum GameState { playing, paused, gameOver }

class MonumentPlatformerGame extends Game {
  // Essential
  double tileSize;
  Size viewport;
  GameState currentGameState = GameState.playing;

  // Game score counters
  // double currentHeight = 0, currentWidth = 0;

  // Canvas translations
  double renderHeight = 0, renderWidth = 0;

  // Player
  Player player;
  double playerPosY;
  double playerPosYOffset = 8;
  double gravity = 0.25;
  bool _left = false, _right = false, _dash = false;

  // Ground
  Ground groundFloor;
  double groundHeight;
  TextComponent groundText;

  // Other
  Dialog gameOverDialog;
  Background skyBackground;
  Wall leftWall;
  TextComponent scoreText;
  Level currentLevel;
  TextComponent xPos, yPos, xV, yV;

  MonumentPlatformerGame(Size screenDimensions) {
    resize(screenDimensions);
    skyBackground = Background(
      game: this,
      x: 0,
      y: 0,
      width: viewport.width,
      height: viewport.height,
    );
    groundFloor = Ground(
      game: this,
      x: -viewport.width,
      y: viewport.height - groundHeight,
      width: viewport.width * 25,
      height: groundHeight,
      colorCode: 0xffaaaaaa,
    );
    leftWall = Wall(
      game: this,
      x: -viewport.width,
      y: -viewport.height * 99,
      width: viewport.width,
      height: viewport.height * 100,
      colorCode: 0xffaaaaaa,
    );
    currentLevel = Level(game: this);
    player = Player(
      game: this,
      x: 0,
      y: playerPosY - playerPosYOffset,
      width: tileSize,
      height: tileSize,
    );
    scoreText = TextComponent(
      game: this,
      displayString: '0',
      fontSize: 30.0,
      y: 60,
      offsetType: OffsetType.fixed,
      fixedOffset: 0,
    );
    groundText = TextComponent(
      game: this,
      displayString: 'go go go!',
      fontSize: 40.0,
      align: TextAlign.left,
      offset: Offset(100, viewport.height - groundHeight),
      y: viewport.height - groundHeight / 1.1,
      offsetType: OffsetType.specified,
    );
    xPos = TextComponent(
      game: this,
      displayString: '0',
      fontSize: 30,
      y: 60,
      align: TextAlign.left,
      offsetType: OffsetType.fixed,
      fixedOffset: -(viewport.width / 2 - 300),
    );
    yPos = TextComponent(
      game: this,
      displayString: '0',
      fontSize: 30,
      y: 60,
      align: TextAlign.left,
      offsetType: OffsetType.fixed,
      fixedOffset: -(viewport.width / 2 - 150),
    );
    xV = TextComponent(
      game: this,
      displayString: '0',
      fontSize: 30,
      y: 60,
      align: TextAlign.left,
      offsetType: OffsetType.fixed,
      fixedOffset: viewport.width / 2 - 300,
    );
    yV = TextComponent(
      game: this,
      displayString: '0',
      fontSize: 30,
      y: 60,
      align: TextAlign.left,
      offsetType: OffsetType.fixed,
      fixedOffset: viewport.width / 2 - 150,
    );
    gameOverDialog = Dialog(game: this);

    // extra modification
    player.x += 25;
  }

  void resize(Size size) {
    super.resize(size);

    viewport = size;
    groundHeight = viewport.height / 6;
    tileSize = viewport.width / 20;
    playerPosY = viewport.height - groundHeight - tileSize + (tileSize / 8);
  }

  void render(Canvas c) {
    skyBackground.render(c);

    c.save();
    c.translate(renderWidth, renderHeight);

    currentLevel.levelPlatforms.forEach((platform) {
      if (obstacleInRange(platform)) platform.render(c);
    });

    leftWall.render(c);
    groundFloor.render(c);
    groundText.render(c);

    player.render(c);
    player.renderCollisionBox(c);
    c.restore();

    if (currentGameState == GameState.gameOver)
      gameOverDialog.render(c);
    else
      scoreText.render(c);

    xPos.render(c);
    yPos.render(c);
    xV.render(c);
    yV.render(c);
  }

  void update(double t) {
    renderWidth = (-player.x + viewport.width / 2 - player.width / 2);
    renderHeight = (-player.y + viewport.height / 2 - player.height / 2);

    if (currentGameState == GameState.playing) {
      currentLevel.levelPlatforms.forEach((obstacle) {
        if (obstacleInRange(obstacle)) {
          obstacle.update(t);
        }
      });
      skyBackground.update(t);
      player.move(
        left: _left,
        right: _right,
        dash: _dash,
        time: t,
      );
      player.update(t);
      // Update scoreText
      scoreText.setText((-player.y / 10).floor().toString());

      xPos.setText('x: ' + player.x.round().toString());
      yPos.setText('y: ' + player.y.round().toString());

      xV.setText('xV: ' + player.xV.round().toString());
      yV.setText('yV: ' + player.yV.round().toString());

      scoreText.updateWithOffset();
      groundText.updateWithOffset();
      gameOverDialog.update(t);
    }
  }

  void checkCollision() {}

  void gameOver() {
    currentGameState = GameState.gameOver;
  }

  void restartGame() {
    // currentHeight = 0;
    player.y = playerPosY;
    player.x = 25;
    currentLevel.generatePlatforms();
    currentGameState = GameState.playing;
  }

  bool obstacleInRange(Platform platform) {
    return (-platform.y < viewport.height + -player.y &&
        -platform.y > -player.y - viewport.height);
  }

  // void jumpHandler() {
  //   if (jumping) {
  //     jumpState = jumpState * 0.8;
  //     currentHeight += jumpState;
  //     player.y -= jumpState;

  //     // Cut the jump below 1 unit
  //     if (jumpState < 1) jumping = false;
  //   } else {
  //     // If max. fallspeed not yet reached
  //     if (jumpState < 15) {
  //       jumpState = jumpState * 1.2;
  //     }
  //     if (currentHeight > jumpState) {
  //       currentHeight -= jumpState;
  //       player.y += jumpState;

  //       // stop jumping below floor
  //     } else if (currentHeight > 0) {
  //       currentHeight = 0;
  //       player.y = 0 + groundHeight - player.width;
  //     }
  //   }
  // }

  void onTapDown(TapDownDetails tapDownDetails) {
    if (gameOverDialog.playButton.contains(tapDownDetails.globalPosition))
      restartGame();
  }

  void onTapUp(TapUpDetails details) {}

  void jumpStart(PointerDownEvent pointerDownEvent) {
    player.jump();
  }

  void jumpEnd(PointerUpEvent pointerUpEvent) {}

  void pressed(List<GamepadButtons> pressed, PointerDownEvent tapDownDetails) {
    pressed.forEach((GamepadButtons button) {
      print("pressed " + button.toString());
      switch (button) {
        case GamepadButtons.left:
          _left = true;
          break;
        case GamepadButtons.right:
          _right = true;
          break;
        case GamepadButtons.jump:
          jumpStart(tapDownDetails);
          break;
        case GamepadButtons.dash:
          _dash = true;
          break;
      }
    });
  }

  void released(List<GamepadButtons> released, PointerUpEvent pointerUpEvent) {
    released.forEach((GamepadButtons button) {
      print("released " + button.toString());
      switch (button) {
        case GamepadButtons.left:
          _left = false;
          break;
        case GamepadButtons.right:
          _right = false;
          break;
        case GamepadButtons.jump:
          jumpEnd(pointerUpEvent);
          break;
        case GamepadButtons.dash:
          _dash = false;
          break;
      }
    });
  }
}
