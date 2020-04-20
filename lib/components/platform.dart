import 'dart:ui';

import 'package:flutter/painting.dart';

import '../game.dart';
import 'component.dart';

class Platform extends GameObject with RectProperties {
  Color color;

  Platform.create({
    MonumentPlatformer game,
    this.color,
    Offset initialPosition,
    Offset size,
  }) : super.create(game) {
    this.size = size;
    this.pos = initialPosition;
  }

  void render(Canvas c) {
    Paint paint = Paint()..color = color;
    c.drawRect(Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy), paint);
  }

  void update(double t) {}
}
