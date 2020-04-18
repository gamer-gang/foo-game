import 'dart:ui';

import '../game.dart';
import 'component.dart';

class Obstacle extends GameObject {
  List<Offset> points;
  Paint paint;

  int direction;
  double movementSpeed;

  Obstacle({
    MonumentPlatformer game,
    this.points,
  }) : super(game) {
    paint = Paint();
    paint.color = Color(0xff3d4852);
  }

  @override
  void render(Canvas c) {
    c.drawLine(points.first, points.last, paint);
    for (int p = 0; p < points.length; p++) {
      if (p == points.length) continue;
      Offset p1 = points[p];
      Offset p2 = points[p + 1];
      c.drawLine(p1, p2, paint);
    }
  }

  @override
  void update(double t) {}

  void checkCollision() {}

  void markHit() {
    paint.color = Color(0xffEF5753);
  }
}
