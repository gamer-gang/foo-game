import 'dart:ui';

import 'package:flutter/material.dart' show Colors;
import 'package:flutter/painting.dart';
import 'package:monument_platformer/components/platform.dart';

import '../game.dart';
import '../common.dart';
import 'component.dart';
import 'text.dart';

class Player extends GameObject {
  MonumentPlatformer game;
  Color color;
  Offset pos, size, vel, accel;
  Text posText, velText, accelText;
  bool dead, debug, jumping;

  static double acceleration = 1,
      accelFriction = 0.8,
      verticalFriction = 0.93,
      maxVelocity = 2,
      friction = 0.8,
      gravity = 0.8;

  Player({
    this.game,
    Offset initialPosition,
    this.size,
    this.color,
    this.debug = false,
  }) {
    pos = initialPosition;
    dead = false;
    jumping = false;
    vel = Offset(0, 0);
    accel = Offset(0, 0);
    if (debug) {
      posText = Text(
        align: TextAlign.left,
        pos: pos.translate(0, -15),
        style: TextStyle(
          color: Colors.black,
          fontFamily: "Fira Code",
        ),
        text: '',
        size: 10,
      );
      velText = Text(
        align: TextAlign.left,
        pos: (pos + vel * 10).translate(0, -15),
        style: TextStyle(
          color: Colors.black,
          fontFamily: "Fira Code",
        ),
        text: '',
        size: 10,
      );
      accelText = Text(
        align: TextAlign.left,
        pos: (pos + vel * 10 + accel * 10).translate(0, -15),
        style: TextStyle(
          color: Colors.black,
          fontFamily: "Fira Code",
        ),
        text: '',
        size: 10,
      );
    }
  }

  void render(Canvas c) {
    if (dead) {} // do something
    Paint paint = Paint()..color = color;
    c.drawRect(Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy), paint);
    if (debug) {
      c.drawPoints(
        PointMode.points,
        [pos, pos + vel * 10, pos + vel * 10 + accel * 10],
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

  Rect toRect() {
    return Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy);
  }

  void collide(Platform platform) {
    double tolerance = 0.05;
    double playerLeft = pos.dx;
    double playerRight = pos.dx + size.dx;
    double playerTop = pos.dy;
    double playerBottom = pos.dy + size.dy;
    double platformLeft = platform.pos.dx + tolerance;
    double platformRight = platform.pos.dx + platform.size.dx - tolerance;
    double platformTop = platform.pos.dy + tolerance;
    double platformBottom = platform.pos.dy + platform.size.dy - tolerance;

    if (playerRight > platformLeft && playerLeft < platformRight) {
      // we are within the platform width

      if (this.toRect().overlaps(platform.toRect())) {
        // we are intersecting the platform im some way

        if (playerBottom >= platformTop && playerBottom <= platformBottom) {
          // we are falling through the platform; move to the top
          pos = pos.withY(platformTop - size.dy);
          jumping = false;
        } else if (playerTop >= platformTop && playerTop <= platformBottom) {
          // we are hitting the bottom of the platform; move to the bottom
          pos = pos.withY(platformBottom);
        } else if (playerLeft >= platformLeft && playerLeft <= platformRight) {
          // we are sliding into the right of the platform; move to the right
          pos = pos.withX(platformRight);
        } else if (playerRight >= platformLeft && playerRight <= platformRight) {
          // we are sliding into the left of the platform; move to the left
          pos = pos.withX(platformLeft - size.dx);
        }
      }
    }
  }
}
