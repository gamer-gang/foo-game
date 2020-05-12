import 'dart:ui';

import 'package:flutter/material.dart' show Colors;
import 'package:flutter/painting.dart';

import '../game.dart';
import '../common.dart';
import 'component.dart';
import 'text.dart';

class Player extends GameObject with RectProperties {
  Color color;
  Offset vel, accel;
  Map<String, Text> texts;
  bool dead, debug, jumpedThisPress;
  int jumps, dashes, dashFrames;
  // dashframes is how many frames you have left to dash

  /// Horizontal acceleration.
  static double acceleration = 1.4;

  /// Multiplied by the acceleration every update.
  static double accelFriction = 0.8;

  /// Velocity is translated by this constant every update.
  static double gravityConstant = 2;

  /// If jump button is down, the gravity constant is multiplied by this to make you "float".
  static double gravityPulldown = 0.5;

  /// Scale of the location of the debug points.
  static double pointMagnitude = 7;

  /// Added to the acceleration every jump.
  static double jumpAcceleration = 5;

  /// Added to your x during a dash.
  static double dashSpeed = 10;

  /// Limit of the velocity.
  static Offset maxSpeed = Offset(20, 20);

  /// Multiplied by the velocity every frame, exept when the player is jumping;
  /// in that case, the Y component is replaced with `Player.gravityPulldown`.
  static Offset friction = Offset(0.85, 0.8);

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
    this.jumps = 0;
    this.dashes = 0;
    this.dashFrames = 0;
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
          pos + vel * pointMagnitude,
          pos + vel * pointMagnitude + accel * pointMagnitude,
        ],
        Paint()
          ..color = Colors.black
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 5,
      );
      texts.values.forEach((text) => text.render(c));
    }
  }

  void update(double t) {
    // if (checkDeath()) dead = true;
    vel = Offset(
      vel.dx.abs() > Player.maxSpeed.dx
          ? Player.maxSpeed.dx * vel.dx.sign
          : vel.dx,
      vel.dy > Player.maxSpeed.dy ? Player.maxSpeed.dy : vel.dy,
    );

    pos += vel;
    vel += accel;

    game.level.platforms.forEach((platform) => this.collideWith(platform));

    vel = vel.scaleX(Player.friction.dx).scaleX(Player.friction.dx);

    accel *= Player.accelFriction;

    if (debug) {
      texts['pos']
        ..setText("Pos: (${pos.dx.roundTo(2).toString()}, "
            "${pos.dy.roundTo(2).toString()})")
        ..setPos(pos.withY(pos.dy - 20));
      texts['vel']
        ..setText("Vel: (${vel.dx.roundTo(2).toString()}, "
            "${vel.dy.roundTo(2).toString()})")
        ..setPos((pos + vel * pointMagnitude).withY(pos.dy - 35));
      texts['accel']
        ..setText("Accel: (${accel.dx.roundTo(2).toString()}, "
            "${accel.dy.roundTo(2).toString()})")
        ..setPos((pos + vel * pointMagnitude + accel * pointMagnitude)
            .withY(pos.dy - 50));
      texts['jumps']
        ..setText("Jumps: $jumps")
        ..setPos(Offset(this.right, this.bottom));
    }
  }

  void move(Gamepad gamepad) {
    // Normal movement code
    if (gamepad.left) accel = accel.withX(-Player.acceleration);
    if (gamepad.right) accel = accel.withX(Player.acceleration);
    if (!gamepad.right && !gamepad.left) accel = accel.withX(0);

    // Dash code
    if (gamepad.dash) {
      if (dashFrames == 0 && dashes != 0) {
        print('dashed');
        dashFrames = 30;
      } else
        dashFrames--;
    }
    if (dashFrames != 0) {
      accel = accel.withX(Player.dashSpeed);
    }

    // Jump code
    if (gamepad.jump && jumps != 0 && !jumpedThisPress) {
      vel = (vel.dy > jumpAcceleration) ? vel.withY(0) : vel;
      accel = accel.withY(-jumpAcceleration);

      jumps--;

      jumpedThisPress = true;
      print('jumped; jumps left: $jumps');
    } else if (!gamepad.jump) {
      jumpedThisPress = false;
    }

    // Gravity code
    if (gamepad.jump)
      vel = vel.translateY(Player.gravityConstant * Player.gravityPulldown);
    else
      vel = vel.translateY(Player.gravityConstant);
  }
}
