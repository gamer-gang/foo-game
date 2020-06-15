import 'dart:ui';

import 'package:flutter/material.dart' show Colors;
import 'package:flutter/painting.dart';

import '../common.dart';
import '../game.dart';
import 'checkpoint.dart';
import 'gameobject.dart';
// import 'obtainable.dart';
import 'particle.dart';
import 'text.dart';

enum Facing { left, right }

class Player extends GameObject with RectProperties {
  Color color;
  Offset vel = Offset(0, 0);
  Offset accel = Offset(0, 0);
  Offset lastCheckpoint = Offset(0, -20);
  Map<String, Text> texts = {};
  bool debug;
  bool invincible = false;
  bool dead = false;
  bool jumpedThisPress = false;
  int jumps = 0;
  int dashes = 0;
  Facing facing = Facing.right;
  List<Offset> pastPositions = [];

  /// Number of frames left to dash.
  int dashFrames = 0;

  /// Number of frames left to die
  int deathFrames = 0;

  /// Horizontal acceleration.
  static double acceleration = 1.4;

  /// Multiplied by the acceleration every update.
  static double accelFriction = 0.8;

  /// Velocity is translated by this constant every update.
  static double gravityConstant = 2;

  /// If jump button is down, the gravity constant is
  /// multiplied by this to make you "float".
  static double gravityPulldown = 0.5;

  /// Scale of the location of the debug points.
  static double pointMagnitude = 7;

  /// Added to the acceleration every jump.
  static double jumpAcceleration = 5;

  /// Added to your x during a dash.
  static double dashSpeed = 15;

  /// Limit of the velocity.
  static Offset maxSpeed = Offset(20, 20);

  /// Multiplied by the velocity every frame, exept when the player is jumping;
  /// in that case, the Y component is replaced with `Player.gravityPulldown`.
  static Offset friction = Offset(0.85, 0.8);

  Player.create({
    MonumentPlatformer game,
    Offset pos,
    Offset size,
    this.color,
    this.debug = false,
  }) : super.create(game) {
    this.pos = pos;
    this.size = size;
    if (debug) {
      texts.addAll({
        'pos': Text.monospace(game),
        'vel': Text.monospace(game),
        'accel': Text.monospace(game),
        'jumps': Text.monospace(game),
        'dashes': Text.monospace(game),
      });
    }
  }

  void render(Canvas c) {
    var paint = Paint()..color = color;
    c.drawRect(Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy + 1), paint);

    if (dashFrames > 0) {
      drawTrail(c);
    }

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

      for (var text in texts.values) {
        text.render(c);
      }
    }
  }

  void update(double t) {
    handleColorChange();
    handleDeath();

    vel = Offset(
      vel.dx.abs() > maxSpeed.dx ? maxSpeed.dx * vel.dx.sign : vel.dx,
      vel.dy > maxSpeed.dy ? maxSpeed.dy : vel.dy,
    );

    pos += vel;
    vel += accel;

    for (var object in game.level.foreground) {
      if (object.collide ?? false) collideWith(object);
    }

    for (var object in game.level.foreground) {
      if (object is Checkpoint) handleCheckpoint(object);
    }

    vel = vel.scaleX(friction.dx).scaleX(friction.dx);

    accel *= accelFriction;

    if (debug) {
      texts['pos']
        ..text = "Pos: (${pos.dx.roundTo(2).toString()}, "
            "${pos.dy.roundTo(2).toString()})"
        ..pos = pos.withY(pos.dy - 20);
      texts['vel']
        ..text = "Vel: (${vel.dx.roundTo(2).toString()}, "
            "${vel.dy.roundTo(2).toString()})"
        ..pos = (pos + vel * pointMagnitude).withY(pos.dy - 35);
      texts['accel']
        ..text = "Accel: (${accel.dx.roundTo(2).toString()}, "
            "${accel.dy.roundTo(2).toString()})"
        ..pos = (pos + vel * pointMagnitude + accel * pointMagnitude)
            .withY(pos.dy - 50);
      texts['jumps']
        ..text = "Jumps: $jumps"
        ..pos = Offset(right, bottom);
      texts['dashes']
        ..text = "Dashes: $dashes"
        ..pos = Offset(right, bottom + 15);
    }
  }

  void move(Gamepad gamepad) {
    // Normal movement code
    if (gamepad.left) {
      accel = accel.withX(-Player.acceleration);
      facing = Facing.left;
    }
    if (gamepad.right) {
      accel = accel.withX(Player.acceleration);
      facing = Facing.right;
    }
    if (!gamepad.right && !gamepad.left) accel = accel.withX(0);

    // Dash code
    if (gamepad.dash && dashes != 0 && dashFrames == 0) {
      pastPositions = [];
      print('dashed');
      dashFrames = 10;
      dashes--;
    }
    if (dashFrames > 0) {
      pastPositions = [pos, ...?pastPositions];
      accel = facing == Facing.right
          ? accel.withX(Player.dashSpeed)
          : accel.withX(-Player.dashSpeed);
      dashFrames--;
    }

    // Jump code
    if (gamepad.jump && jumps > 0 && !jumpedThisPress) {
      vel = (vel.dy > jumpAcceleration) ? vel.withY(0) : vel;
      accel = accel.withY(-jumpAcceleration);
      jumpedThisPress = true;
      jumps--;

      print('jumped; jumps left: $jumps');
    } else if (!gamepad.jump) {
      jumpedThisPress = false;
    }

    // Gravity code
    if (dashFrames == 0) {
      if (gamepad.jump) {
        vel = vel.translateY(Player.gravityConstant * Player.gravityPulldown);
      } else {
        vel = vel.translateY(Player.gravityConstant);
      }
    }
  }

  void drawTrail(Canvas c) {
    for (var i = 1; i < pastPositions.length; i++) {
      var paint = Paint()..color = color.withAlpha(200 ~/ i);
      var trailPos = pastPositions[i - 1];
      c.drawRect(
          Rect.fromLTWH(trailPos.dx, trailPos.dy, size.dx + 1, size.dy), paint);
    }
  }

  void handleCheckpoint(Checkpoint object) {
    if (Rect.fromLTWH(object.pos.dx, object.pos.dy, 40, 75)
        .overlaps(Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy))) {
      lastCheckpoint = Offset(object.pos.dx, object.pos.dy);
    }
  }

  void handleDeath() {
    assert(deathFrames >= 0);

    if (deathFrames == 60) {
      ParticleEffect.death(game: game, pos: pos + (size / 2));
    }

    if (deathFrames > 0) {
      print('dead');
      dashFrames = 0;
      color = Color(0x00000000);
      invincible = true;
      dead = true;
      vel = Offset.zero;
      accel = Offset.zero;
      deathFrames--;
    } else if (deathFrames == 0 && dead) {
      dead = false;
      invincible = false;
      pos = lastCheckpoint;
      color = Color(0xff1e90ff);
    }
  }

  void handleColorChange() {
    if (dashes == 1 && jumps == 1) {
      color = Color(0xff1e90ff);
    } else if (dashes == 0 && jumps == 0) {
      color = Color(0xff696969);
    }
  }

  // void collectItems() {
  //   for (var obj in game.level.foreground) {
  //     if (obj is Obtainable) {
  //       obj;
  //     } else {
  //       obj;
  //     }
  //   }
  // }
}
