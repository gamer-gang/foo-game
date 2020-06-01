import 'dart:ui';

import 'package:flutter/painting.dart';

import '../game.dart';
import 'gameobject.dart';

class Platform extends GameObject with RectProperties {
  Color color;
  bool canKillPlayer, collide;
  Offset pos, size;

  Platform.create({
    MonumentPlatformer game,
    this.color,
    this.canKillPlayer = false,
    this.collide = true,
    this.pos,
    this.size,
  }) : super.create(game);

  void render(Canvas c) {
    var paint = Paint()..color = color;
    c.drawRect(Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy), paint);
  }

  void update(double t) {}
}
