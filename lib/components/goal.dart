import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../game.dart';
import 'gameobject.dart';
import 'particle.dart';

class Goal extends GameObject {
  Offset pos;
  Color color;
  int framesSinceLastEffect = 0;

  Goal.create({
    @required MonumentPlatformer game,
    @required this.color,
    @required this.pos,
  }) : super.create(game);

  void render(Canvas c) {
    c.drawRect(Rect.fromLTWH(pos.dx, pos.dy, 60, 60), Paint()..color = color);
  }

  void update(double t) {
    if (framesSinceLastEffect == 0) {
      framesSinceLastEffect = 10;
      ParticleEffect.ambientGoalEffect(game: game, pos: pos, color: color);
    } else {
      framesSinceLastEffect--;
    }
  }
}
