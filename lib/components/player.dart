import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../common.dart';
import '../game.dart';
import 'core/gameobject.dart';

class Player extends GameObject {
  final List<List<Sprite>> characterSprites = [
    [Sprite('bird-0.png'), Sprite('bird-1.png')],
    [Sprite('bird-0-left.png'), Sprite('bird-1-left.png')]
  ];

  Rect rect, playerRect;
  Paint paint, playerPaint;

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
    collisionToleranceX = game.tileSize / 20;
    collisionToleranceY = game.tileSize / 20;
    movementSpeed = game.viewport.width / 12;
  }

  @override
  void render(Canvas c) {
    paint = Paint();
    playerPaint = Paint();
    // Transparent bounding box
    paint.color = Color(0x00000000);
    playerPaint.color = Color.fromARGB(255, 200, 200, 200);
    rect = Rect.fromLTWH(0, 0, width, height);
    playerRect = Rect.fromLTWH(0, 0, width, height);
    
    c.save();
    c.translate(x, y);
    c.translate(width / 2, height / 2);
    c.rotate(rotation);
    c.translate(-width / 2, -height / 2);
    c.drawRect(rect, paint);
    c.drawRect(playerRect, playerPaint);
    // characterSprites[characterSpritesIndex][flutterFrame].renderRect(c, rect.inflate(0));
    c.restore();
  }

  @override
  void update(double t) {
    checkCollision();
    // if (y + height >= game.groundHeight) y = game.playerPosY - game.playerPosYOffset;
  }

  void move({bool left, bool right, bool dash, double time}) {
    if (dash) {
      if (!isDashing) {
        xV += movementSpeed * time * dashMultiplier * (characterSpritesIndex == 1 ? -1 : 1);
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
      xV *= 1 - friction;
      x += xV;
    }
  }

  void setRotation(double deg) {
    // rotation = deg * math.pi / 180;
    rotation = 0;
  }

  void checkCollision() {
    // if (x >= game.viewport.width - width)
    //   x = game.viewport.width - width;
    if (x <= 0) x = 0;
  }

  void startJump() {
    flutterFrame = 1;
  }

  void endJump() {
    flutterFrame = 0;
  }

  Rect toRect() {
    return Rect.fromLTWH(x, y, width, height);
  }

  Rect toCollisionRect() {
    double left = x;
    double right = x + width;
    double top = y;
    double bottom = y + height;

    return Rect.fromLTRB(left + collisionToleranceX, top + collisionToleranceX, right - collisionToleranceX, bottom - collisionToleranceY);
  }

  void renderCollisionBox(Canvas c) {
    Paint paint = Paint();
    paint.color = Colors.red;
    Rect collisionRect = this.toCollisionRect();

    c.drawRect(collisionRect, paint);  
  }
}
