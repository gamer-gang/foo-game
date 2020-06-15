import 'package:flutter/painting.dart';

import '../game.dart';
import 'gameobject.dart';

class Goal extends GameObject {
  Offset pos;
  Color color;
  Goal.create({
    MonumentPlatformer game,
    this.color,
    this.pos,
  }) : super.create(game);

  void render(Canvas c) {
    c.drawRect(Rect.fromLTWH(pos.dx, pos.dy, 60, 60), Paint()..color = color);
  }

  void update(double t) {}
}
