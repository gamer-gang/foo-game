import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../common.dart';
import '../game.dart';
import 'component.dart';
import 'platform.dart';

class Player extends GameObject {
  Player({
    MonumentPlatformer game,
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

  double collisionToleranceX, collisionToleranceY;
  int direction = 1;
  double width, height;
  bool isDashing = false;
  double jumpHeight = 30;
  bool jumping = false;
  int jumps = 2;
  double movementSpeed;
  Paint paint, playerPaint;
  Rect rect, playerRect;
  double rotation;
  double x = 0, y = 0, xV = 0, yV = 0, friction, dashMultiplier = 32;

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

    c.restore();
  }

  @override
  void update(double t) {
    checkCollision();
  }

  void move({
    bool left,
    bool right,
    bool dash,
    double time,
  }) {
    if (dash) {
      if (!isDashing) {
        xV += movementSpeed * time * dashMultiplier * direction;
        isDashing = true;
      } else {
        if (xV.roundToPlaces(1) == 0) isDashing = false;
      }
    } else {
      if (left) {
        xV -= movementSpeed * time;
        direction = 1;
      }
      if (right) {
        xV += movementSpeed * time;
        direction = -1;
      }
      xV *= 1 - friction;
      x += xV;
    }

    if (jumping) {
      yV = yV * (1 - game.gravity);
      y -= yV;

      // Cut the jump below 1 unit
      if (yV < 1) jumping = false;
    } else {
      // If max. fallspeed not yet reached
      if (yV < 30) {
        yV = yV * (1 + game.gravity);
      }
      // if (y < yV) {
        y += yV;
      // }
    }
  }

  void checkCollision() {
    // left wall
    if (x <= 0) x = 0;

    // floor
    // if (y + height >= game.groundHeight - height) {
    //   y = game.groundHeight - width;
    //   yV = 0;
    // }

    for (Platform platform in game.currentLevel.levelPlatforms) {
      if (platform.toRectangle().intersects(this.toCollisionRectangle())) {
        // left of platform
        if (x + width + collisionToleranceX <= platform.x) {
          x = platform.x + width;
        }

        // right of platform
        else if (x + collisionToleranceX >= platform.x + platform.width) {
          x = platform.x + platform.width;
        }

        // within platform
        else if (x + collisionToleranceX + width >= platform.x && x <= platform.x + platform.width) {
          // above platform
          if (y + collisionToleranceY * 2 + height <= platform.y) {
            y = platform.y - height;
            yV = 0;
            jumps = 2;
          }

          // below platform
          else if (y + collisionToleranceY <= platform.y + platform.height) {
            y = platform.y + platform.height;
          }
        }
      }
    }
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

  Rectangle toCollisionRectangle() {
    double left = x;
    double right = x + width;
    double top = y;
    double bottom = y + height;

    return Rectangle(left + collisionToleranceX, top + collisionToleranceX, right - collisionToleranceX, bottom - collisionToleranceY);
  }

  void renderCollisionBox(Canvas c) {
    Paint paint = Paint();
    paint.color = Colors.red;
    Rect collisionRect = this.toCollisionRect();

    c.drawRect(collisionRect, paint);
  }

  void jump() {
    print('jump handler');
    if (jumps != 0) {
      // jumps--;
      jumping = true;
      yV = jumpHeight;
    }
  }
}
