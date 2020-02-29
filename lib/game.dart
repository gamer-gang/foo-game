import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';

import 'common.dart';
import 'components/background.dart';
import 'components/dialog.dart';
import 'components/ground.dart';
import 'components/level.dart';
import 'components/obstacle.dart';
import 'components/player.dart';
import 'components/text.dart';

enum GamepadButtons { left, right, jump, dash }
enum GameState { playing, paused, gameOver }

class MonumentPlatformerGame extends BaseGame {
  @override
  bool debugMode() => true;

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
      x: 0,
      y: viewport.height - floorHeight,
      width: viewport.width,
      height: floorHeight,
      colorCode: 0xff48BB78,
    );
    currentLevel = Level(game: this);
    birdPlayer = Player(
      game: this,
      x: 0,
      y: birdPosY,
      width: tileSize,
      height: tileSize,
    );
    scoreText = TextComponent(
      game: this,
      text: '0',
      fontSize: 30.0,
      y: 60,
    );
    floorText = TextComponent(
      game: this,
      text: 'Tap to flutter!',
      fontSize: 40.0,
      y: viewport.height - floorHeight / 2,
    );
    gameOverDialog = Dialog(game: this);
  }

  Player birdPlayer;
  double birdPosY;
  double birdPosYOffset = 8;
  GameState currentGameState = GameState.playing;
  // Game Score
  double currentHeight = 0;

  bool _left = false, _right = false, _dash = false;

  Level currentLevel;
  double floorHeight = 150;
  TextComponent floorText;
  double flutterIntensity = 20;
  double flutterState = 0;
  Dialog gameOverDialog;
  Ground groundFloor;
  bool isFluttering = false;
  TextComponent scoreText;
  Background skyBackground;
  double tileSize;
  Size viewport;

  void resize(Size size) {
    super.resize(size);
    viewport = size;
    tileSize = viewport.width / 12;
    birdPosY = viewport.height - floorHeight - tileSize + (tileSize / 8);
  }

  void render(Canvas c) {
    skyBackground.render(c);
    c.save();
    c.translate(0, currentHeight);

    currentLevel.levelObstacles.forEach((obstacle) {
      if (obstacleInRange(obstacle)) obstacle.render(c);
    });
    groundFloor.render(c);
    floorText.render(c);
    c.restore();

    birdPlayer.render(c);

    if (currentGameState == GameState.gameOver)
      gameOverDialog.render(c);
    else
      scoreText.render(c);
  }

  void update(double t) {
    if (currentGameState == GameState.playing) {
      currentLevel.levelObstacles.forEach((obstacle) {
        if (obstacleInRange(obstacle)) {
          obstacle.update(t);
        }
      });
      skyBackground.update(t);
      birdPlayer.move(
        left: _left,
        right: _right,
        dash: _dash,
        time: t,
      );
      birdPlayer.update(t);
      // Update scoreText
      scoreText.setText(currentHeight.floor().toString());
      scoreText.update(t);
      floorText.update(t);
      gameOverDialog.update(t);
      // Game tasks
      flutterHandler();
      checkCollision();
    }
  }

  void checkCollision() {
    currentLevel.levelObstacles.forEach((obstacle) {
      if (obstacleInRange(obstacle) &&
          birdPlayer.toCollisionRect().overlaps(obstacle.toRect())) {
        obstacle.markHit();
        gameOver();
      }
    });
  }

  void gameOver() {
    currentGameState = GameState.gameOver;
  }

  void restartGame() {
    birdPlayer.setRotation(0);
    currentHeight = 0;
    currentLevel.generateObstacles();
    currentGameState = GameState.playing;
  }

  bool obstacleInRange(Obstacle obs) {
    return (-obs.y < viewport.height + currentHeight &&
        -obs.y > currentHeight - viewport.height);
  }

  void flutterHandler() {
    if (isFluttering) {
      flutterState = flutterState * 0.8;
      currentHeight += flutterState;
      birdPlayer.setRotation(-flutterState * birdPlayer.direction * 1.5);
      // Cut the jump below 1 unit
      if (flutterState < 1) isFluttering = false;
    } else {
      // If max. fallspeed not yet reached
      if (flutterState < 15) {
        flutterState = flutterState * 1.2;
      }
      if (currentHeight > flutterState) {
        birdPlayer.setRotation(flutterState * birdPlayer.direction * 2);
        currentHeight -= flutterState;
        // stop jumping below floor
      } else if (currentHeight > 0) {
        currentHeight = 0;
        birdPlayer.setRotation(0);
      }
    }
  }

  void onTapDown(TapDownDetails tapDownDetails) {
    if (gameOverDialog.playButton.contains(tapDownDetails.globalPosition))
      restartGame();
  }

  void jumpStart(PointerDownEvent pointerDownEvent) {
    if (currentGameState != GameState.gameOver) {
      // Make the bird flutter
      birdPlayer.startFlutter();
      isFluttering = true;
      flutterState = flutterIntensity;
      return;
    }
  }

  void jumpEnd(PointerUpEvent pointerUpEvent) {
    birdPlayer.endFlutter();
  }

  void pressed(List<GamepadButtons> pressed, PointerDownEvent tapDownDetails) {
    print("xV: " + birdPlayer.xV.roundToPrecision(2).toString());
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
      print("xV: " + birdPlayer.xV.roundToPrecision(2).toString());
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
