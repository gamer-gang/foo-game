import 'dart:ui';

import 'package:flutter/painting.dart';

import '../game.dart';
import 'gameobject.dart';

class Platform extends GameObject with RectProperties {
  Color color;

  Platform.create({
    MonumentPlatformer game,
    this.color,
    bool canKillPlayer = false,
    bool collide = true,
    Offset pos,
    Offset size,
  }) : super.create(game) {
    this.size = size;
    this.pos = pos;
    this.canKillPlayer = canKillPlayer;
    this.collide = collide;
  }

  void render(Canvas c) {
    var paint = Paint()..color = color;
    c.drawRect(Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy), paint);
  }

  void update(double t) {}
}
