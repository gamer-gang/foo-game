import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/rendering.dart';

import '../common.dart';
import '../game.dart';
import 'core/gameobject.dart';

class Player extends GameObject {
  final List<List<Sprite>> characterSprites = [
    [Sprite('bird-0.png'), Sprite('bird-1.png')],
    [Sprite('bird-0-left.png'), Sprite('bird-1-left.png')]
  ];

  Rect rect;
  Paint paint;

  double collisionToleranceX, collisionToleranceY;

  double x, y, xV = 1, yV, friction, dashMultiplier = 32;
  double width, height;
  double rotation;

  bool isDashing = false;

  int direction = 1;
  int characterSpritesIndex = 0;
  int flutterFrame = 0;
  double movementSpeed;

  Player({
    MonumentPlatformerGame game,
    this.x,
    this.y,
    this.width,
    this.height,
    this.rotation: 0,
    this.friction: 0.2,
  }) : super(game) {
    collisionToleranceX = game.tileSize / 5;
    collisionToleranceY = game.tileSize / 6;
    movementSpeed = game.viewport.width / 12;
  }

  @override
  void render(Canvas c) {
    paint = Paint();
    // Transparent bounding box
    paint.color = Color(0x00000000);
    rect = Rect.fromLTWH(0, 0, width, height);
    c.save();
    c.translate(x, y);
    c.translate(width / 2, height / 2);
    c.rotate(rotation);
    c.translate(-width / 2, -height / 2);
    c.drawRect(rect, paint);
    characterSprites[characterSpritesIndex][flutterFrame]
        .renderRect(c, rect.inflate(0));
    c.restore();
  }

  @override
  void update(double t) {
    checkCollision();
    // x += direction * movementSpeed * t;
  }

  void move({bool left, bool right, bool dash, double time}) {
    if (dash) {
      if (!isDashing) {
        xV += movementSpeed *
            time *
            dashMultiplier *
            (characterSpritesIndex == 1 ? -1 : 1);
        isDashing = true;
      } else {
        if (xV.roundToPrecision(2) == 0) isDashing = false;
      }
    } else {
      if (left) {
        xV -= movementSpeed * time;
        characterSpritesIndex = 1;
      }

      if (right) {
        xV += movementSpeed * time;
        characterSpritesIndex = 0;
      }
    }

    xV *= 1 - friction;
    x += xV;
  }

  void setRotation(double deg) {
    rotation = deg * math.pi / 180;
  }

  void checkCollision() {
    if (x >= game.viewport.width - width)
      x = game.viewport.width - width;
    else if (x <= 0) x = 0;
  }

  void startFlutter() {
    flutterFrame = 1;
  }

  void endFlutter() {
    flutterFrame = 0;
  }

  Rect toRect() {
    return Rect.fromLTWH(x, y, width, height);
  }

  Rect toCollisionRect() {
    double left = x;
    double right = x + width;
    double top = y - game.currentHeight;
    double bottom = y - game.currentHeight + height;

    return Rect.fromLTRB(left + collisionToleranceX, top + collisionToleranceX,
        right - collisionToleranceX, bottom - collisionToleranceY);
  }
}
