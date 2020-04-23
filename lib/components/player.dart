import 'dart:ui';

import 'package:flutter/material.dart' show Colors;
import 'package:flutter/painting.dart';
import 'package:monument_platformer/components/platform.dart';

import '../game.dart';
import '../common.dart';
import 'component.dart';
import 'text.dart';

class Player extends GameObject with RectProperties {
  Color color;
  Offset vel, accel;
  Text posText, velText, accelText;
  bool dead, debug, jumping;

  static double acceleration = 1,
      accelFriction = 0.8,
      verticalFriction = 0.93,
      maxVelocity = 2,
      friction = 0.8,
      gravity = 0.8;

  Player.create({
    MonumentPlatformer game,
    Offset initialPosition,
    Offset size,
    this.color,
    this.debug = false,
  }) : super.create(game) {
    this.pos = initialPosition;
    this.size = size;
    this.dead = false;
    this.jumps = 2;
    this.vel = Offset(0, 0);
    this.accel = Offset(0, 0);
    this.jumpedThisPress = false;
    this.texts = {};
    if (debug) {
      texts.addAll({
        'pos': Text.monospace(game),
        'vel': Text.monospace(game),
        'accel': Text.monospace(game),
        'jumps': Text.monospace(game),
      });
    }
  }

  void render(Canvas c) {
    if (dead) {} // do something
    Paint paint = Paint()..color = color;
    c.drawRect(Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy), paint);
    if (debug) {
      c.drawPoints(
        PointMode.points,
        [
          pos,
          pos + vel * 10,
          pos + vel * 10 + accel * 10,
        ],
        Paint()
          ..color = Colors.black
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 5,
      );
      posText.render(c);
      velText.render(c);
      accelText.render(c);
    }
  }

  void update(double t) {
    if (checkDeath()) dead = true;
    vel = Offset(
      vel.dx.abs() > Player.maxVelocity
          ? Player.maxVelocity * vel.dx.sign
          : vel.dx,
      vel.dy.abs() > Player.maxVelocity
          ? Player.maxVelocity * vel.dy.sign
          : vel.dy,
    );

    pos += vel;
    vel += accel;

    game.level.platforms.forEach((platform) => this.collide(platform));

    vel = vel.translate(0, Player.gravity);

    vel = vel.scale(Player.friction, Player.verticalFriction);
    accel *= Player.accelFriction;

    if (debug) {
      posText.setText("Pos: (${pos.dx.roundTo(2).toString()}, "
          "${pos.dy.roundTo(2).toString()})");
      posText.setPos(pos.withY(pos.dy - 20));
      velText.setText("Vel: (${vel.dx.roundTo(2).toString()}, "
          "${vel.dy.roundTo(2).toString()})");
      velText.setPos((pos + vel * 10).withY(pos.dy - 35));
      accelText.setText("Accel: (${accel.dx.roundTo(2).toString()}, "
          "${accel.dy.roundTo(2).toString()})");
      accelText.setPos((pos + vel * 10 + accel * 10).withY(pos.dy - 50));
    }
  }

  void move(Gamepad gamepad) {
    if (gamepad.left) accel = accel.withX(-Player.acceleration);
    if (gamepad.right) accel = accel.withX(Player.acceleration);
    if (!gamepad.right && !gamepad.left) accel = accel.withX(0);

    if (gamepad.dash) pos = Offset.zero;

    if (gamepad.jump && !jumping) {
      accel = Offset(accel.dx, -30);
      // jumping = true;
    }
  }

  bool checkDeath() {
    return false;
  }

  void collide(Platform platform) {
    // platform.toRect().collision(this);

    if (this.right > platform.left && this.left < platform.right) {
      // we are within the platform width

      if (this.toRect().overlaps(platform.toRect())) {
        // we are intersecting the platform im some way

        if (this.bottom >= platform.top && this.bottom <= platform.bottom) {
          // we are falling through the platform; move to the top
          pos = pos.withY(platform.top - size.dy);
          jumping = false;
        } else if (this.top >= platform.top && this.top <= platform.bottom) {
          // we are hitting the bottom of the platform; move to the bottom
          pos = pos.withY(platform.bottom);
        } else if (this.right >= platform.left &&
            this.right <= platform.right) {
          // we are sliding into the left of the platform; move to the left
          pos = pos.withX(platform.left - size.dx);
        } else if (this.left >= platform.left && this.left <= platform.right) {
          // we are sliding into the right of the platform; move to the right
          pos = pos.withX(platform.right);
        }
      }
    }
  }
}
