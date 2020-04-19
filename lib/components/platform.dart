import 'dart:ui';

import '../game.dart';
import 'component.dart';

class Platform extends GameObject {
  MonumentPlatformer game;
  Color color;

  Offset pos;
  Offset size;

  Platform({
    this.game,
    this.color,
    Offset initialPosition,
    this.size,
  }) {
    pos = initialPosition;
  }

  void render(Canvas c) {
    Paint paint = Paint()..color = color;
    c.drawRect(Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy), paint);
  }

  void update(double t) {
    
  }

  Rect toRect() {
    return Rect.fromLTWH(pos.dx, pos.dy, size.dx, size.dy);
  }
}
