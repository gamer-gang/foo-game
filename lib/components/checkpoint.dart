import 'dart:math';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart' show Colors, required;

import '../common.dart';
import '../game.dart';
import 'gameobject.dart';
import 'particle.dart';
import 'text.dart';

class Checkpoint extends GameObject {
  Offset pos;
  ParticleEffect particleEffect;
  int ticksSinceLastEffect = 0;
  bool reached = false;
  Text text;

  static Offset size = Offset(50, 90);

  Checkpoint.create({
    @required MonumentPlatformer game,
    @required this.pos,
  })  : text = Text.monospace(game)
          ..text = 'checkpoint'
          ..pos = pos.translateY(size.dy - 2.5)
          ..rotation = -90
          ..align = TextAlign.start,
        super.create(game);

  void update(double t) {
    if (!reached) return;

    if (ticksSinceLastEffect == 0) {
      ticksSinceLastEffect = 8;
      particleEffect = ParticleEffect.checkpoint(
        game: game,
        pos: pos +
            Offset(
              Random().nextInt(40).toDouble(),
              Random().nextInt(75).toDouble(),
            ),
      );
    } else {
      ticksSinceLastEffect--;
    }
  }

  void render(Canvas c) {
    var paint = Paint()..color = reached ? Colors.green : Colors.grey;
    c.drawRect(Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy), paint);
    text.render(c);
  }
}
