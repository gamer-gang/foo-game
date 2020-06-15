import 'dart:math';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart' show Colors;

import '../game.dart';
import 'gameobject.dart';
import 'particle.dart';

class Checkpoint extends GameObject {
  Offset pos;
  ParticleEffect particleEffect;
  int ticksSinceLastEffect = 0;

  Checkpoint.create({
    MonumentPlatformer game,
    this.pos,
  }) : super.create(game);

  void update(double t) {
    if (ticksSinceLastEffect == 0) {
      ticksSinceLastEffect = 10;
      ParticleEffect.checkpoint(
        game: game,
        pos: pos +
            Offset(Random().nextInt(40).toDouble(),
                Random().nextInt(75).toDouble()));
    } else {
      ticksSinceLastEffect--;
    }
  }

  void render(Canvas c) {
    var paint = Paint()..color = Colors.green;
    c.drawRect(Rect.fromLTWH(pos.dx, pos.dy, 40, 75), paint);
  }
}
